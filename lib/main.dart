import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'breakpoints.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixus',
      theme: ThemeData(
          primaryColor: Color(0xffFFECDC), accentColor: Color(0xffFFA500)),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedItemIndex = 0;

  //TODO: dispose variable.
  var _pageController = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, dimens) {
          int columnRatio = calculateColumnRatio(dimens);
          if (dimens.maxWidth <= kMobileBreakpoint) {
            return Column(
              children: [
                Flexible(
                  child: PageView(
                    children: [
                      Container(color: Colors.grey),
                      Container(color: Colors.green),
                      Container(color: Colors.blueGrey),
                      Container(color: Colors.blue)
                    ],
                    onPageChanged: (index) {
                      setState(() {
                        _selectedItemIndex = index;
                      });
                    },
                    controller: _pageController,
                  ),
                ),
                BottomNavigationBar(
                  onTap: (index) {
                    setState(() {
                      _pageController.jumpToPage(index);

                      _selectedItemIndex = index;
                    });
                  },
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.solidImages),
                        label: 'Images'),
                    BottomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.video), label: 'Videos'),
                    BottomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.th), label: 'Categories'),
                    BottomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.cog), label: 'Settings'),
                  ],
                  currentIndex: _selectedItemIndex,
                )
              ],
            );
          } else {
            return Row(
              children: [
                NavigationRail(
                  minWidth: 60,
                  onDestinationSelected: (index) {
                    setState(() {
                      _pageController.jumpToPage(index);

                      _selectedItemIndex = index;
                    });
                  },
                  selectedIndex: _selectedItemIndex,
                  destinations: [
                    NavigationRailDestination(
                        icon: Icon(FontAwesomeIcons.solidImage),
                        label: Text('Images')),
                    NavigationRailDestination(
                        icon: Icon(FontAwesomeIcons.video),
                        label: Text('Videos')),
                    NavigationRailDestination(
                        icon: Icon(FontAwesomeIcons.th),
                        label: Text('Categories')),
                    NavigationRailDestination(
                        icon: Icon(FontAwesomeIcons.cog),
                        label: Text('Settings')),
                  ],
                  labelType: NavigationRailLabelType.all,
                ),
                Flexible(
                  child: PageView(
                    children: [
                      Container(color: Colors.grey),
                      Container(color: Colors.green),
                      Container(color: Colors.blueGrey),
                      Container(color: Colors.blue),
                    ],
                    onPageChanged: (index) {
                      setState(() {
                        _selectedItemIndex = index;
                      });
                    },
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
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
}
