import 'dart:ui';

import 'package:flutter/material.dart';

class FloatingActionButtonGreen extends StatefulWidget {

  final IconData icon;
  final VoidCallback onPressed;

  FloatingActionButtonGreen({@required this.icon,@required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FloatingActionButtonGreen();
  }

}


class _FloatingActionButtonGreen extends State<FloatingActionButtonGreen> {
/*
  void onPressedFav(){
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Agregaste a tus Favoritos"),
        )
    );

  }
  */

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
      backgroundColor: Color(0xFF11DA53),
      mini: true,
      tooltip: "Fav",
      onPressed: widget.onPressed,
      child: Icon(widget.icon),
      heroTag: null,
    );
  }

}