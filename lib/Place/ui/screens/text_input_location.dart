import 'package:flutter/material.dart';

class TextInputLocation extends StatelessWidget {

  final String hintText;
  final TextEditingController controller;
  final IconData icon;

  const TextInputLocation({Key key, @required this.hintText,this.controller,@required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.only(
        right: 20,
        left: 20,
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 15,
          color: Colors.blueGrey,
          fontFamily: "Lato",
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: Icon(icon),
          fillColor: Colors.white,
          filled: true,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(12.0))
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(12.0))
          )

        ),
      ),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color:Colors.black12,
            blurRadius: 15,
            offset: Offset(0, 7)
          )
        ]
      ), 
    );
  }
}