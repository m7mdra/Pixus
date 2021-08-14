import 'package:flutter/material.dart';
import 'package:pix/page/home/resposive_home.dart';
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
  var _pages = [const PhotosPage(), const VideosPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ResponsiveHome(
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
      )),
    );
  }
}
