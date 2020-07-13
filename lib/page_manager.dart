import 'package:base/custom_ink_well.dart';
import 'package:base/screen_manager.dart';

// 页面管理
//
//
//--------------------------------------------------------------------------------
import 'package:flutter/material.dart';

import 'image_view.dart';

abstract class PageManager {
  /// 构建空数据的界面
  Widget buildEmptyWidget(BuildContext context,
      {VoidCallback onTry, String tip});

  /// 构建出错的界面
  Widget buildErrorWidget(BuildContext context,
      {String message, VoidCallback onTry});

  /// 构建加载中的部件
  Widget buildLoadingWidget(
    BuildContext context,
  );

  void errorDialog(BuildContext context, String message);
}

class DefaultPageManager extends PageManager {
  @override
  Widget buildEmptyWidget(BuildContext context,
      {VoidCallback onTry, String tip}) {
    return Stack(
      children: <Widget>[
//        if (Navigator.of(context).canPop())
//          backButton(context),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AssetImageView(
                assets: 'mine/gou.png',
                width: getWp(149),
                height: getWp(214),
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: getHp(42),
              ),
              Text(
                tip ?? "no_data_for_now",
                style: TextStyle(
                  fontSize: getSp(15),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget buildErrorWidget(
    BuildContext context, {
    String message,
    VoidCallback onTry,
  }) {
    return Stack(
      children: <Widget>[
//        if (Navigator.of(context).canPop())
//          backButton(context),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AssetImageView(
                assets: 'mine/gou.png',
                width: getWp(149),
                height: getWp(214),
              ),
              SizedBox(
                height: getWp(42),
              ),
              Text("no_data_for_now"),
            ],
          ),
        ),
      ],
    );
  }

  Widget backButton(BuildContext context) {
    return Positioned(
      top: getWp(24 + 10.0),
      left: getWp(0),
      child: CustomInkWell(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(99),
        margin: EdgeInsets.symmetric(
          horizontal: getWp(15),
        ),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getWp(8), vertical: getWp(8)),
          child: Image.asset(
            "assets/images/new_mine/back2.png",
            width: getWp(19),
            height: getWp(18),
            fit: BoxFit.contain,
          ),
        ),
        onPressed: () {
          Navigator.maybePop(context);
        },
      ),
    );
  }

  @override
  Widget buildLoadingWidget(
    BuildContext context,
  ) {
    return Center(
      child: Container(
//        color: Colors.red,
        alignment: Alignment.center,
        constraints: BoxConstraints(
          maxWidth: getWp(200),
          maxHeight: getWp(200),
        ),
        child: FlutterLogo(),
      ),
    );
  }

  @override
  void errorDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("S.of(context).something_went_wrong"),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("S.of(context).determine")),
              ],
            ));
  }
}
