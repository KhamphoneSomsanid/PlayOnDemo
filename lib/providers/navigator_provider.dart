import 'package:flutter/material.dart';

class NavigatorProvider {
  final BuildContext context;

  NavigatorProvider(this.context);

  static NavigatorProvider of(BuildContext context) {
    return NavigatorProvider(context);
  }

  void pushToWidget({
    @required Widget screen,
    bool replace = false,
    Function(dynamic) pop,
  }) {
    if (replace) {
      Navigator.of(context)
          .pushReplacement(
          MaterialPageRoute<Object>(builder: (context) => screen))
          .then((value) => {if (pop != null) pop(value)});
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute<Object>(builder: (context) => screen))
          .then((value) => {if (pop != null) pop(value)});
    }
  }
}