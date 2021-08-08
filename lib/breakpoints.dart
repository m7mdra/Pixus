import 'package:flutter/material.dart';

const kMobileBreakpoint = 480;
const kTabletBreakpoint = 1024;
const kDesktopBreakPoint = 1366;

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

