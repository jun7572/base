import 'package:dio/adapter.dart';

// http请求管理
//
//
//--------------------------------------------------------------------------------

import 'dart:collection';
import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'logger.dart';

class DefaultHttpManager extends HttpManager {
  static DefaultHttpManager manager;
  final bool isDebug;

  DefaultHttpManager._(this.isDebug);

  static HttpManager initHttpManager(
      {String baseUrl, String imageUrl, String ossUrl, bool isDebug: true}) {
    assert(isDebug != null);
    return DefaultHttpManager._(isDebug);
  }
}

//class DefaultHttpManager extends HttpManager {
//  static DefaultHttpManager manager;
//  final bool isDebug;
//  final String baseUrl;
//  final String imageUrl;
//  final String ossUrl;
//
//  DefaultHttpManager._(this.baseUrl,this.imageUrl,this.ossUrl, this.isDebug);
//
//  static HttpManager initHttpManager(
//      {String baseUrl, String imageUrl, String ossUrl, bool isDebug: true}) {
//    assert(isDebug != null);
//    return DefaultHttpManager._(baseUrl,imageUrl,ossUrl,isDebug);
//  }
//}
abstract class HttpManager {
  //请求的url地址
  String baseUrl;

  //请求的图片
  String imageUrl;

  // oss
  String ossUrl;

  //是否为debug模式
  bool get isDebug;

  //通过该方法直接获取图片链接
  String getImage(String path) => path.startsWith('http')
      ? path
      : Uri.encodeFull('$imageUrl$path${_findNearest()}');

  //通过该方法直接获取附件资源链接 // ${path==null||path.endsWith('.mp4')||path.endsWith('.zip')?'':_findNearest()}
  String getOssUrl(String path) => Uri.encodeFull('$ossUrl$path');

  SplayTreeMap<double, String> candidates = SplayTreeMap.from({
    1.0: '?x-oss-process=image/resize,p_33',
    2.0: '?x-oss-process=image/resize,p_66',
    3.0: '',
  });

  // Return the value for the key in a [SplayTreeMap] nearest the provided key.
  String _findNearest() {
    double value = window.devicePixelRatio;
    if (candidates.containsKey(value)) return candidates[value];
    final double lower = candidates.lastKeyBefore(value);
    final double upper = candidates.firstKeyAfter(value);
    if (lower == null) return candidates[upper];
    if (upper == null) return candidates[lower];
    if (value > (lower + upper) / 2)
      return candidates[upper];
    else
      return candidates[lower];
  }

  //请求连接超时时间
  int connectTimeout = 30000;

  //请求接收超时时间
  int receiveTimeout = 30000;

  //请求头，通过setToken进行设置
  Map<String, String> headers = {};

  List<Interceptor> interceptorList = [];

  Dio get dio {
    if (interceptorList.isEmpty) {
      interceptorList.add(HttpLogInterceptor(this));
      interceptorList.add(TokenInterceptor(this));
    }
    Dio _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: headers,
      ),
    )..interceptors.addAll(interceptorList);

//    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//        (client) {
//      client.findProxy = (uri) {
//        return 'PROXY 172.16.11.79:8888';
//      };
//      return client;
//    };
    return _dio;
  }

  void updateResourceUrl({@required String imageUrl, @required String ossUrl}) {
    if (imageUrl != null && imageUrl.isNotEmpty) this.imageUrl = imageUrl;
    if (ossUrl != null && ossUrl.isNotEmpty) this.ossUrl = ossUrl;
  }

  void updateApiUrl({@required String baseUrl}) {
    this.baseUrl = baseUrl;
  }

  void clearToken() {
    headers.remove("token");
  }

  void addToken(String token) {
    headers["token"] = token;
  }

  //添加过滤
  void addInterceptor(Interceptor interceptor) {
    interceptorList.add(interceptor);
  }

  //移除过滤
  void removeInterceptor(Interceptor interceptor) {
    interceptorList.remove(interceptor);
  }

  Future<Response> get(String path, Map<String, dynamic> params,
      [CancelToken cancelToken]) async {
    return await dio.get(path,
        queryParameters: params, cancelToken: cancelToken);
  }

  Future<Response> postJson(String path, Map<String, dynamic> params,
      [CancelToken cancelToken]) async {
    return await dio.post(path, data: params, cancelToken: cancelToken);
  }

  Future<Response> postObject(String path, dynamic content,
      [CancelToken cancelToken]) async {
    return await dio.post(path, data: content, cancelToken: cancelToken);
  }

  //上传文件需要监听发送进度
  Future<Response> postForm(String path, Map<String, dynamic> params,
      {CancelToken cancelToken, ProgressCallback onSendProgress}) async {
    Dio _dio = dio;
    _dio.options.receiveTimeout = 1000 * 120;
    _dio.options.connectTimeout = 1000 * 120;
    _dio.options.sendTimeout = 1000 * 120;

    return await _dio.post(path,
//        options: Options(),
        data: params == null
            ? {}
            : FormdataExtension(FormData.fromMap({})).extensionFromMap(params),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress);
  }

  //上传图片
  MultipartFile formFile(String path) {
    return MultipartFile.fromFileSync(path,
        filename: path.substring(path.lastIndexOf('/') + 1));
  }

  // 传单次使用的token
  Future<Response> postJsonWithToken(
      String path, Map<String, dynamic> params, String token,
      [CancelToken cancelToken]) async {
    Dio _dio = dio;
    _dio.options.receiveTimeout = 1000 * 60;
    _dio.options.connectTimeout = 1000 * 60;
    _dio.options.sendTimeout = 1000 * 5;
    _dio..options.headers = {'token': token};

    return await _dio.post(path, data: params, cancelToken: cancelToken);
  }

  //下载文件
  Future<Response> download(String path, String filePath,
      {CancelToken cancelToken, ProgressCallback onReceiveProgress}) async {
    Dio _dio = dio;
    _dio.options.receiveTimeout = 1000 * 120;
    _dio.options.connectTimeout = 1000 * 120;
    _dio.options.sendTimeout = 1000 * 120;

    _dio..options.baseUrl = null;
    return await _dio.download(path, filePath,
        cancelToken: cancelToken, onReceiveProgress: onReceiveProgress);
  }

  // get file head
  Future<Response> head(String path, {CancelToken cancelToken}) async {
    Dio _dio = dio;

    _dio..options.baseUrl = null;
    return await _dio.head(path, cancelToken: cancelToken);
  }
}

extension FormdataExtension on FormData {
  FormData extensionFromMap(Map<String, dynamic> map) {
    for (MapEntry<String, dynamic> entry in map.entries) {
      if (entry.value == null) continue;
      if (entry.value is List<MultipartFile>) {
        List<MultipartFile> fileList = entry.value;
        files
            .addAll(fileList.map((data) => MapEntry(entry.key, data)).toList());
      } else if (entry.value is MultipartFile) {
        files.add(MapEntry(entry.key, entry.value));
      } else {
        fields.add(MapEntry(entry.key, entry.value.toString()));
      }
    }
    return this;
  }
}

// 日志打印
class HttpLogInterceptor extends Interceptor {
  final HttpManager manager;

  HttpLogInterceptor(this.manager);

  DateTime _time;

  bool get isDebug => manager.isDebug;

  @override
  Future onRequest(RequestOptions options) {
    _time = DateTime.now();
    if (isDebug) logger.d('''
**  .-------------------------------- Request ${DateFormat().format(_time)}--------------------------------
** |  
** |  url    : ${options.baseUrl}${options.path}
** |  method : ${options.method}
** |  header : ${options.headers}
** |  params : ${options.method == 'POST' ? options.data is Map ? json.encode(options.data) : options.data : options.queryParameters}
** |  
**  `-------------------------------- Request ${DateFormat().format(_time)}--------------------------------''');
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    DateTime endTime = DateTime.now();
    if (isDebug) logger.d('''
**  .-------------------------------- Response ${DateFormat().format(_time)}--------------------------------
** |  
** |  time   : ${endTime.millisecondsSinceEpoch - _time.millisecondsSinceEpoch}ms
** |  url    : ${response.request.baseUrl}${response.request.path}
** |  method : ${response.request.method}
** |  header : ${response.request.headers}
** |  params : ${response.request.method == 'POST' ? response.request.data is Map ? json.encode(response.request.data) : response.request.data : response.request.queryParameters}
** |  status : ${response.statusCode}
** |  result : ${response.toString()}
** |  
**  `-------------------------------- Response ${DateFormat().format(_time)}--------------------------------
    ''');
//    try {
//      if (response.statusCode != 200 ||
//          response.data[BaseConfig.presenterBase.statusKey] !=
//              BaseConfig.presenterBase.normalStatus) {
//        FlutterBugly.uploadException(
//            message: "status error", detail: response.request.toString());
//      }
//    } catch (e) {
//      print(e);
//    }
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    logger.e(err.message, err.error, null);
//    FlutterBugly.uploadException(
//        message: "request error",
//        detail: """url:${err.request.baseUrl}${err.request.path}
//method:${err.request.method}
//error:${err.error}
//""");
    return super.onError(err);
  }
}

// token 刷新拦截器
class TokenInterceptor extends Interceptor {
  final HttpManager manager;

  TokenInterceptor(this.manager);

  @override
  Future onError(DioError error) async {
//    if (error.response != null &&
//        error.response.statusCode == 401
//        &&
//        imStore.isLogin
//    ) {
//      //401代表token过期
//      Dio dio = manager.dio; //获取Dio单例
//      dio.lock();
//      var response = await getToken(); //异步获取新的accessToken
//      if (response != null && response.data["code"] == 200) {
//        String accessToken =
//            response.data["data"]['access_token']; //新的accessToken
//        String refreshToken =
//            response.data["data"]['refresh_token']; //新的refreshToken
//
//        await imStore.saveNewToken(
//            token: accessToken, refreshToken: refreshToken); //保存新的token
//
//        dio.unlock();
//
//        //重新发起一个请求获取数据
//        var request = error.response.request;
//        request.headers["token"] = accessToken; // 重新赋值token
//        try {
//          var response = await dio.request(request.path,
//              data: request.data,
//              queryParameters: request.queryParameters,
//              cancelToken: request.cancelToken,
//              options: request,
//              onReceiveProgress: request.onReceiveProgress);
//          return response;
//        } on DioError catch (e) {
//          return e;
//        }
//      } else {
//        dio.unlock();
//      }
//    }
    return super.onError(error);
  }

//  static Future<Response> getToken() async {
//    String accessToken = SpValues.token; //获取当前的accessToken
//    String refreshToken = SpValues.refreshToken; //获取当前的refreshToken
//
//    Dio dio = BaseConfig.httpBase.dio; //获取Dio单例
//
//    dio.options.headers['token'] = accessToken; //设置当前的accessToken
//    var response;
//    try {
//      String url =
//          "/system_app/refresh_token?refresh_token=$refreshToken"; //refreshToken url
//      response = await dio.get(url); //请求refreshToken刷新的接口
//    } on DioError catch (e) {
//      logger.d("refresh token error");
//    }
//    return response;
//  }
}
