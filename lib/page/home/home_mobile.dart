import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeMobile extends StatelessWidget {
  final ValueChanged<int> onPageChanged;
  final PageController pageController;
  final int pageIndex;
  final List<Widget> pages;
  final ValueChanged<int> onNavigationChanged;

  const HomeMobile(
      {Key? key,
      required this.onPageChanged,
      required this.pageIndex,
      required this.onNavigationChanged,
      required this.pageController,
      required this.pages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: PageView(
            children: pages,
            onPageChanged: onPageChanged,
            controller: pageController,
          ),
        ),
        BottomNavigationBar(
          onTap: onNavigationChanged,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidImages), label: 'Images'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.video), label: 'Videos'),

            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.cog), label: 'Settings'),
          ],
          currentIndex: pageIndex,
        )
      ],
    );
  }
}
