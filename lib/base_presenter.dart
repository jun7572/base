import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'common.dart';
import 'dialog_manager.dart';
import 'logger.dart';
import 'page_manager.dart';

export 'dart:async';

class DefaultPresenterBase extends PresenterBase {
  String get statusKey => 'code';

  int get normalStatus => 200;

  String get msgKey => 'msg';

  String get dataKey => 'data';

  @override
  Future<bool> handlerGlobalHttpError(
      BuildContext context, DioError error) async {
    if (error.response != null &&
        error.response.statusCode == 401
    //todo
//        && imStore.isLogin
    ) {
      //todo
      // 登录失败处理
//      await imStore.logout(context: context);
      return true;
    }
    return false;
  }
}

enum AutoHandler {
  Page, //页面处理
  Toast, //toast处理
  Dialog, //对话框处理
}

///[isEmpty] 判断是否有数据
///[emptyTip] 无数据的提示语
///[saveCode] 保存数据的代号
///[message] 获取到的消息数据，通过[_kMsgKey]字段进行获取
///[status] 状态码，通过[_kStatusKey]字段进行获取
///[data] 数据信息
mixin BasePresenter<T extends StatefulWidget, D> on State<T> {
  String get emptyTip => "S.of(context).disconnnet_tip";

  bool get isEmpty => null;

  String get saveCode => null;
  String message;

  ValueNotifier<int> status = ValueNotifier(null); //状态码，200为正常
  ValueNotifier<D> data = ValueNotifier(null); //数据
  ValueNotifier<bool> transValue = ValueNotifier(false); //转换数据标识
  /// ui相关
  DialogManager get dialog => BaseConfig.dialogBase;

  PageManager get pageManager => BaseConfig.pageBase;

  //重试
  VoidCallback get onTry => () {
        message = null;
        status.value = null;
        _dataFuture = dataFuture;
        loadData();
      }; //点击重试

  //重试
  Future<void> onRefreshData() async {
    _dataFuture = dataFuture;
    await loadData();
  } //点击重试
  ///**************************** start 这部分都可以重写 ****************************///

  //显示加载失败页面
  Widget get buildErrorWidget => Scaffold(
        body: pageManager.buildErrorWidget(context,
            message: message, onTry: onTry),
      );

  //显示加载中页面
  Widget get buildLoadingWidget => Scaffold(
        body: pageManager.buildLoadingWidget(context),
      );

  //显示没有数据页面
  Widget get buildEmptyWidget => Scaffold(
        body:
            pageManager.buildEmptyWidget(context, tip: emptyTip, onTry: onTry),
      );

  Widget get buildWidget;

  //加载数据的Future，即接口
  Future get dataFuture;

  Future _dataFuture;

  Future get _future {
    if (_dataFuture == null) {
      _dataFuture = dataFuture;
    }
    return _dataFuture;
  }
  D get pp =>Provider.of<D>(context);
  // 重新装载Future
  void reloadFuture() {
    _dataFuture = dataFuture;
  }

  //加载数据
  Future loadData() async {
    if (_future != null) {
      return post(_future, autoHandler: AutoHandler.Page,
          onSuccess: (result) async {
        if (result.data[BaseConfig.presenterBase.dataKey] == null) {
          transValue.value = true;
          return;
        }
        try {
          D d = BaseConfig.entityBase
              .formJson<D>(result.data[BaseConfig.presenterBase.dataKey]);
          data.value = await transformData(d);

          transValue.value = true;
        } catch (_, __) {
          logger.e("S.of(context).something_went_wrong", _, __);
          transValue.value = true;
        }
      });
    }
  }

  ///**************************** end 这部分都可以重写 ****************************///

  //是否需要转换数据，如果需要则重写
  FutureOr<D> transformData(D d) {
    return d;
  }

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    if (isLoaded) return;
    this.isLoaded = true;

    if (saveCode != null) {
      data.addListener(() {
        //监听数据的变化，并保存的数据库中
        //todo
//        BaseConfig.dataBase.savePageData<D>(saveCode, data.value);
      });
    }
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    data.dispose();
    status.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //如果接口为空，则直接调用buildWidget
    return _future == null
        ? (buildWidget ?? Container())
        : ValueListenableBuilder(
            valueListenable: status,
            builder: (BuildContext context, int value2, _) {
              if (value2 == null) {
                //正在加载数据
                return buildLoadingWidget;
              } else if (value2 == BaseConfig.presenterBase.normalStatus) {
                //正常的返回码
                return ValueListenableBuilder(
                  valueListenable: transValue,
                  builder: (BuildContext context, bool value3, _) {
                    if (value3 == false) {
                      return buildLoadingWidget;
                    } else {
                      return _;
                    }
                  },
                  child: ValueListenableBuilder(
                    valueListenable: data,
                    builder: (BuildContext context, value, _) {
                      if (data.value is List) {
                        if ((data.value as List)?.length == 0 &&
                            (isEmpty != null && isEmpty)) {
                          return buildEmptyWidget;
                        }
                      } else if (data.value == null ||
                          isEmpty != null && isEmpty) {
                        return buildEmptyWidget;
                      }
                      return buildWidget ?? Container();
                    },
                  ),
                );
              } else {
                // 不正常的返回码
                return buildErrorWidget;
              }
            },
          );
  }

  //提交任务,这里可以对错误进行统一处理
  Future<void> post(
    Future<Response> future, {
    String loadingTip, //加载提示语
    AutoHandler autoHandler, //是否自动处理错误
    FutureOr<void> onSuccess(Response response), //请求成功，判断为200的时候
    FutureOr<void> onError(), //异常
    FutureOr<void> onFinally(), //完成所有总是会执行
  }) async {
    //当前加载为页面加载，saveCode不为空，读取本地，然后再加载
    var dbData;
    if (autoHandler == AutoHandler.Page && saveCode != null) {
      dbData = await BaseConfig.dataBase.getDbResponse(saveCode);
      if (dbData != null) {
        status.value = dbData.statusCode;
        await onSuccess(dbData);
      }
    }
    if (loadingTip != null) {
      dialog.showLoadingDialog(context: context, text: loadingTip);
    }
    try {
      Response result = await future;
      if (!mounted) return;

      int statusCode = result.data[BaseConfig.presenterBase.statusKey];
      String msg = result.data[BaseConfig.presenterBase.msgKey];
      if (autoHandler == AutoHandler.Page) {
        message = msg;
        status.value = statusCode;
        if (status.value == BaseConfig.presenterBase.normalStatus) {
          if (onSuccess != null) {
            await onSuccess(result);
          }
        }
      } else if (autoHandler == AutoHandler.Toast) {
        if (statusCode == BaseConfig.presenterBase.normalStatus) {
          if (onSuccess != null) {
            await onSuccess(result);
          }
        } else {
          if (msg != null)
            Toast.showToast(msg: msg, gravity: ToastGravity.CENTER);

        }
      } else if (autoHandler == AutoHandler.Dialog) {
        if (statusCode == BaseConfig.presenterBase.normalStatus) {
          if (onSuccess != null) {
            await onSuccess(result);
          }
        } else {
          pageManager.errorDialog(context, msg);
        }
      } else {
        if (onSuccess != null) {
          await onSuccess(result);
        }
      }
    } catch (e, s) {
      if (e is DioError) {
        if (await BaseConfig.presenterBase.handlerGlobalHttpError(context, e)) {
          return;
        }
      }
      logger.e("S.of(context).network_error", e, s);
      String msg = _formatDioError(context, e);
      if (autoHandler == AutoHandler.Page) {
        message = msg;
        if (dbData == null) {
          status.value = -1;
        } else {
          if (msg != null)
            Toast.showToast(msg: msg, gravity: ToastGravity.CENTER);
        }
      } else if (autoHandler == AutoHandler.Toast) {
        if (msg != null)
          Toast.showToast(msg: msg, gravity: ToastGravity.CENTER);
      } else if (autoHandler == AutoHandler.Dialog) {
        pageManager.errorDialog(context, msg);
      } else {
        if (onError != null) {
          await onError();
        }
      }
    } finally {
      if (loadingTip != null &&
          Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
      }
      if (onFinally != null) {
        await onFinally();
      }
    }
    return;
  }
}

//格式化dio的错误
String _formatDioError(BuildContext context, e) {
  String msg;
  if (e is DioError) {
    switch (e.type) {
      case DioErrorType.RECEIVE_TIMEOUT:
        msg = "=======the_current_network_connection_timed_out";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        msg = "=======connect_time_out";
        break;
      case DioErrorType.SEND_TIMEOUT:
        msg = "=======connect_time_out_tip";
        break;
      case DioErrorType.RESPONSE:
        msg = "=======network_connection_failed";
        break;
      case DioErrorType.DEFAULT:
        msg = "=======the_network_connection_has_been_dropped";
        break;
      case DioErrorType.CANCEL:
        msg = "=======request_cancelled";
        break;
      default:
        msg = e.toString();
        break;
    }
  } else {
    msg = e.toString();
  }
  return msg;
}

abstract class PresenterBase {
  //获取状态码的key
  String get statusKey;

  //判断是否正确的状态码
  int get normalStatus;

  //获取服务器返回的消息key
  String get msgKey;

  //获取服务器返回的数据
  String get dataKey;

  /// 返回true 会对错误进行拦截 ，false会放行
  Future<bool> handlerGlobalHttpError(BuildContext context, DioError error);
}
