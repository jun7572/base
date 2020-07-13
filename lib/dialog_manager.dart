
// 对话框弹出管理
//
//
//--------------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_alert/flutter_alert.dart';

import 'screen_manager.dart';

abstract class DialogManager {
  Future<T> showLoadingDialog<T>(
      {@required BuildContext context,
      @required String text,
      bool canDismiss: true});

  Future<T> showSuccessDialog<T>(
      {@required BuildContext context,
      @required String text,
      bool canDismiss: true});

  Future<T> showErrorDialog<T>(
      {@required BuildContext context,
      @required String text,
      bool canDismiss: true});

  Future<T> showCommonConfirmDialog<T>(
      {@required BuildContext context,
      @required String content,
      String title = "提示",
      String confirm,
      String cancel,
      VoidCallback onCancel,
      VoidCallback onConfirm,
      bool canDismiss: true});
}

class DefaultDialogManager extends DialogManager {
  @override
  Future<T> showErrorDialog<T>(
      {BuildContext context, String text, bool canDismiss = true}) async {
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context);
    });
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: SizedBox(
                height: getWp(200),
                width: getWp(200),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: getWp(100),
                      height: getWp(100),
                      child: Icon(
                        Icons.close,
                        size: getWp(60),
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      height: getWp(20),
                    ),
                    Text(text, style: TextStyle(fontSize: getSp(16)),),
                  ],
                ),
              ),
            ));
  }

  @override
  Future<T> showLoadingDialog<T>(
      {BuildContext context, String text, bool canDismiss = true}) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: SizedBox(
                height: getWp(200),
                width: getWp(200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: getWp(50),
                      height: getWp(50),
                      child: CircularProgressIndicator(
                        strokeWidth: getWp(4),
                      ),
                    ),
                    SizedBox(
                      height: getWp(30),
                    ),
                    Text(text, style: TextStyle(fontSize: getSp(16)),),
                  ],
                ),
              ),
            ));
  }

  @override
  Future<T> showSuccessDialog<T>(
      {BuildContext context, String text, bool canDismiss = true}) async {
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context);
    });
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: SizedBox(
                height: getWp(200),
                width: getWp(200),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: getWp(100),
                      height: getWp(100),
                      child: Icon(
                        Icons.check,
                        size: getWp(60),
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      height: getWp(20),
                    ),
                    Text(text, style: TextStyle(fontSize: getSp(16)),),
                  ],
                ),
              ),
            ));
  }

  @override
  Future<T> showCommonConfirmDialog<T>(
      {BuildContext context,
      String content,
      String title = "提示",
      String confirm,
      String cancel,
      onCancel,
      onConfirm,
      bool canDismiss = true}) {
    showAlert(
      context: context,
      title: title,
      body: content,
      actions: [
        AlertAction(
          text: confirm ?? "S.of(context).determine",
          isDestructiveAction: false,
          onPressed: () {
            if (onConfirm != null) {
              onConfirm();
            }
          },
        ),
        AlertAction(
          text: cancel ??"S.of(context).cancel",
          isDestructiveAction: false,
          onPressed: () {
            if (onCancel != null) {
              onCancel();
            }
          },
        ),
      ],
      cancelable: canDismiss,
    );
    return null;
  }
}
