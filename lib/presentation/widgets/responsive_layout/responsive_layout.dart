import 'package:adonis_web_test/config/config.dart';
import 'package:flutter/material.dart';

class ResponisveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget tabletBody;
  final Widget desktopBody;

  const ResponisveLayout(
      {this.mobileBody, this.tabletBody, @required this.desktopBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, dimensions) {
        if (dimensions.maxWidth >= kDesktopBreakpoint) {
          return desktopBody;
        } else if (dimensions.maxWidth >= kTabletBreakpoint &&
            dimensions.maxWidth <= kDesktopBreakpoint) {
          return tabletBody ?? mobileBody;
        } else if (dimensions.maxWidth < kTabletBreakpoint) {
          return mobileBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}
