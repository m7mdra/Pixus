import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pix/breakpoints.dart';

class ResponsiveHome extends StatelessWidget {
  final ValueChanged<int> onPageChanged;
  final PageController pageController;
  final int pageIndex;
  final List<Widget> pages;
  final ValueChanged<int> onNavigationChanged;

  const ResponsiveHome(
      {Key? key,
      required this.onPageChanged,
      required this.pageIndex,
      required this.onNavigationChanged,
      required this.pageController,
      required this.pages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          children: [
            if (constraints.maxWidth > kMobileBreakpoint)
            NavigationRail(
              minWidth: 80,
              onDestinationSelected: onNavigationChanged,
              selectedIndex: pageIndex,
              elevation: 2,
              destinations: [
                NavigationRailDestination(
                    icon: Icon(FontAwesomeIcons.solidImage),
                    label: Text('Images')),
                NavigationRailDestination(
                    icon: Icon(FontAwesomeIcons.video), label: Text('Videos'))
              ],
              labelType: NavigationRailLabelType.all,
            ),
            Flexible(
              child: Column(
                children: [
                  Flexible(
                    child: PageView(
                      children: pages,
                      onPageChanged: onPageChanged,
                      controller: pageController,
                    ),
                  ),
                  if (constraints.maxWidth <= kMobileBreakpoint)
                    BottomNavigationBar(
                      onTap: onNavigationChanged,
                      type: BottomNavigationBarType.fixed,
                      items: [
                        BottomNavigationBarItem(
                            icon: Icon(FontAwesomeIcons.solidImages),
                            label: 'Images'),
                        BottomNavigationBarItem(
                            icon: Icon(FontAwesomeIcons.video), label: 'Videos')
                      ],
                      currentIndex: pageIndex,
                    )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
