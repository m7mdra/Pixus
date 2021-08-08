import 'package:flutter/material.dart';

import '../breakpoints.dart';

class BreakpointLayoutBuilder extends StatelessWidget {
  final Widget mobileWidget;
  final Widget largeWidget;

  const BreakpointLayoutBuilder(
      {Key? key, required this.mobileWidget, required this.largeWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= kMobileBreakpoint) {
          return mobileWidget;
        } else {
          return largeWidget;
        }
      },
    );
  }
}
