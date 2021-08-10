import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PixusSliverAppBar extends StatelessWidget {
  const PixusSliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text("Pixus",
          style: GoogleFonts.lobster(color: Colors.white, fontSize: 40)),
      pinned: false,
      floating: false,
      elevation: 0,
    );
  }
}