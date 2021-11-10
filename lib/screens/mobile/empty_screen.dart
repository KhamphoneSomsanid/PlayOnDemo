import 'package:flutter/material.dart';
import 'package:mobile/themes/colors.dart';
import 'package:mobile/themes/dimens.dart';
import 'package:mobile/widgets/button_widget.dart';

class EmptyScreen extends Card {
  EmptyScreen({
    @required int index,
    @required Function() action,
  }) : super(
          margin: EdgeInsets.symmetric(
            horizontal: offsetBase,
            vertical: offsetXMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(dimenCorner),
          ),
          shadowColor: POColors.shadowColor,
          elevation: 5,
          child: Center(
            child: POButton(
              title: 'Create Team $index',
              action: action,
              padding: EdgeInsets.symmetric(
                horizontal: offsetBase,
                vertical: offsetSm,
              ),
            ),
          ),
        );
}
