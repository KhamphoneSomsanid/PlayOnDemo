import 'package:flutter/material.dart';

const double offsetXLg = 40.0;
const double offsetLg = 32.0;
const double offsetXMd = 24.0;
const double offsetMd = 20.0;
const double offsetBase = 16.0;
const double offsetSm = 8.0;
const double offsetXSm = 4.0;

const double dimenButtonHeight = 52.0;
const double dimenCorner = 10.0;
const double dimenHeader = 56.0;
const double dimenFooter = 44.0;

const double fontsize_14 = 14.0;
const double fontsize_17 = 17.0;

class Dimension {
  Size screenSize;
  Dimension(this.screenSize);

  double widthSm = 420;
  double widthBs = 640;
  double widthMd = 768;
  double widthLg = 1024;

  double wp(percentage) {
    return percentage / 100 * screenSize.width;
  }

  double hp(percentage) {
    return percentage / 100 * screenSize.height;
  }

  double getWidthPx(int pixels) {
    return (pixels / 3.61) / 100 * screenSize.width;
  }

  double sValue(double value) {
    if (screenSize.width > widthLg) {
      return value * 1.5;
    } else if (screenSize.width > widthMd) {
      return value * 1.35;
    } else if (screenSize.width > widthBs) {
      return value * 1.2;
    } else if (screenSize.width > widthSm) {
      return value * 1.1;
    } else {
      return value;
    }
  }

  int getStatus() {
    if (screenSize.width > widthLg) {
      return 4;
    } else if (screenSize.width > widthMd) {
      return 3;
    } else if (screenSize.width > widthBs) {
      return 2;
    } else if (screenSize.width > widthSm) {
      return 1;
    } else {
      return 0;
    }
  }
}
