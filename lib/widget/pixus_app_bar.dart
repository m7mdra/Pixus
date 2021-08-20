import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PixusAppBar extends StatelessWidget {
  final bool sliver;

  const PixusAppBar({
    Key? key,
  })  : sliver = false,
        super(key: key);

  PixusAppBar.sliver() : sliver = true;

  @override
  Widget build(BuildContext context) {
    if(sliver)
    return SliverAppBar(
      title: Text("Pixus",
          style: GoogleFonts.lobster(color: Colors.white, fontSize: 40)),
      pinned: true,
      floating: false,
      elevation: 0,
    );
    else
      return AppBar();
  }
}
