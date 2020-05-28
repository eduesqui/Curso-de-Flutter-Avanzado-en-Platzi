import 'package:flutter/material.dart';

class TitleHeader extends StatefulWidget {

  final String title;

  TitleHeader({@required this.title});

  @override
  _TitleHeaderState createState() => _TitleHeaderState();
}

class _TitleHeaderState extends State<TitleHeader> {
  @override
  Widget build(BuildContext context) {
    

    return  Text(
          widget.title,
          style: TextStyle(
            color:Colors.white,
            fontSize: 30.0,
            fontFamily: "latto",
            fontWeight: FontWeight.bold
          ),
        
      ); 
    
    
  }
}