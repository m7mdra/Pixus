import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pix/locator.dart';
import 'package:pix/page/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme()
      ),
      home: HomePage(),
    );
  }
}
