import 'package:flutter/material.dart';
import 'package:mobile/themes/colors.dart';
import 'package:mobile/themes/dimens.dart';

bool isShowing = false;

class DialogProvider {
  final BuildContext context;

  DialogProvider(this.context);

  static DialogProvider of(BuildContext context) {
    return DialogProvider(context);
  }

  bool hideLoading() {
    if (context == null) {
      return true;
    }
    isShowing = false;
    Navigator.of(context).pop(true);
    return true;
  }

  bool showLoading() {
    if (context == null) {
      return true;
    }
    isShowing = true;
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                POColors.green,
              ),
            ),
          );
        },
        useRootNavigator: false);
    return true;
  }

  void showSnackBar(
    String content, {
    SnackBarType type = SnackBarType.SUCCESS,
  }) async {
    var backgroundColor = Colors.white;
    var icons = Icons.check_circle_outline;
    switch (type) {
      case SnackBarType.SUCCESS:
        backgroundColor = Colors.green;
        icons = Icons.check_circle_outline;
        break;
      case SnackBarType.WARING:
        backgroundColor = Colors.orange;
        icons = Icons.warning_amber_outlined;
        break;
      case SnackBarType.INFO:
        backgroundColor = Colors.blueGrey;
        icons = Icons.info_outline;
        break;
      case SnackBarType.ERROR:
        backgroundColor = Colors.red;
        icons = Icons.cancel_outlined;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Card(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(offsetSm)),
          elevation: 2.0,
          child: Container(
            padding: EdgeInsets.all(offsetBase),
            child: Row(
              children: [
                Icon(
                  icons,
                  color: Colors.white,
                  size: 42.0,
                ),
                SizedBox(
                  width: offsetSm,
                ),
                Expanded(
                  child: Text(
                    content,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration(milliseconds: 2000),
      ),
    );
  }
}

enum SnackBarType { SUCCESS, WARING, INFO, ERROR }
