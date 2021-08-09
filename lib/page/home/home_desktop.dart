import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeDesktop extends StatelessWidget {
  final ValueChanged<int> onPageChanged;
  final PageController pageController;
  final int pageIndex;
  final List<Widget> pages;
  final ValueChanged<int> onNavigationChanged;

  const HomeDesktop(
      {Key? key,
      required this.onPageChanged,
      required this.pageIndex,
      required this.onNavigationChanged,
      required this.pageController,
      required this.pages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          minWidth: 80,
          onDestinationSelected: onNavigationChanged,
          selectedIndex: pageIndex,
          elevation: 2,
          destinations: [
            NavigationRailDestination(
                icon: Icon(FontAwesomeIcons.solidImage), label: Text('Images')),
            NavigationRailDestination(
                icon: Icon(FontAwesomeIcons.video), label: Text('Videos')),
            NavigationRailDestination(
                icon: Icon(FontAwesomeIcons.cog), label: Text('Settings')),
          ],
          labelType: NavigationRailLabelType.all,
        ),
        Flexible(
          child: PageView(
            children: pages,
            onPageChanged: onPageChanged,
            controller: pageController,
            scrollDirection: Axis.vertical,
          ),
        ),
      ],
    );
  }
}
