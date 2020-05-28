import 'dart:io';

import 'package:flutter/material.dart';
import 'package:platzi_trips_app/widgets/gradient_back.dart';
import 'package:platzi_trips_app/widgets/text_input.dart';
import 'package:platzi_trips_app/widgets/titile_header.dart';

class AddPlaceScreen extends StatefulWidget {

  File image;
  AddPlaceScreen({this.image});

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {

    final _controllerTittlePlace = TextEditingController();
    final _controllerDescriptionPlace = TextEditingController();
    double screenWidght = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack("", 300),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top:25, left:  5),
                child: SizedBox(
                  height: 45,
                  width: 45,
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      ),
                    onPressed: (){
                      Navigator.pop(context);
                    }
                    ),
                ),
              ),
              Flexible(
                
                child: Container(
                  padding: EdgeInsets.only(
                        top: 45,
                        left: 20,
                        right:10),
                  width: screenWidght,
                  child: TitleHeader(title: "Add a new place"),
                ))
            ] 
          ),
          Container( // Crear un saveArea
            margin: EdgeInsets.only(
              top:120,
              bottom: 20
            ),
            child: ListView(
              children: <Widget>[
                Container(

                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: TextInput(
                    hintText: "Title",
                    inputType: null,
                    controller: _controllerTittlePlace,
                    maxLines: 1,),
                ),
                 TextInput(
                    hintText: "Description",
                    inputType: null,
                    controller: _controllerDescriptionPlace,
                    maxLines: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



}