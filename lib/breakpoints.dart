import 'package:flutter/material.dart';

const kMobileBreakpoint = 480;
const kTabletBreakpoint = 1024;
const kDesktopBreakPoint = 1366;

MapEntry<double, double> imageWidth(double screenWidth) {
  var width = 0.0;
  var height = 0.0;
  if (screenWidth <= kMobileBreakpoint) {
    width = 180.0;
    height = 180.0;
  } else if (screenWidth > kMobileBreakpoint &&
      screenWidth <= kTabletBreakpoint) {
    width = 250.0;
    height = 250.0;
  } else if (screenWidth > kTabletBreakpoint &&
      screenWidth <= kDesktopBreakPoint) {
    width = 300.0;
    height = 280.0;
  }else{
    width = 350.0;
    height = 350.0;
  }
  return MapEntry(width, height);
}

int calculateColumnRatio(BoxConstraints dimens) {
  var columnRatio = 0;
  if (dimens.maxWidth <= kMobileBreakpoint) {
    columnRatio = 6;
  } else if (dimens.maxWidth > kMobileBreakpoint &&
      dimens.maxWidth <= kTabletBreakpoint) {
    columnRatio = 4;
  } else if (dimens.maxWidth > kTabletBreakpoint &&
      dimens.maxWidth <= kDesktopBreakPoint) {
    columnRatio = 3;
  } else {
    columnRatio = 2;
  }
  return columnRatio;
}
