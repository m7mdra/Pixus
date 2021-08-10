import 'package:flutter/material.dart';
import 'package:pix/breakpoints.dart';
import 'package:pix/page/home/home_desktop.dart';
import 'package:pix/page/home/home_mobile.dart';
import 'package:pix/page/photos/photos_page.dart';
import 'package:pix/page/videos/videos_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedItemIndex = 0;

  //TODO: dispose variable.
  var _pageController = PageController(keepPage: true);
  var _pages = [
    const PhotosPage(),
    const VideosPage(),
    Container(color: Colors.blue)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, dimens) {
            if (dimens.maxWidth <= kMobileBreakpoint) {
              return HomeMobile(
                pageController: _pageController,
                pageIndex: _selectedItemIndex,
                onNavigationChanged: (page) {
                  setState(() {
                    _pageController.jumpToPage(page);
                    _selectedItemIndex = page;
                  });
                },
                pages: _pages,
                onPageChanged: (page) {
                  setState(() {
                    this._selectedItemIndex = page;
                  });
                },
              );
            } else {
              return HomeDesktop(
                pageController: _pageController,
                pageIndex: _selectedItemIndex,
                onNavigationChanged: (page) {
                  setState(() {
                    _pageController.jumpToPage(page);
                    _selectedItemIndex = page;
                  });
                },
                pages: _pages,
                onPageChanged: (page) {
                  setState(() {
                    this._selectedItemIndex = page;
                  });
                },
              );
            }
          },
        ),
      ),
    );
  }
}
