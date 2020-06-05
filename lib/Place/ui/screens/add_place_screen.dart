import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/Place/ui/screens/text_input_location.dart';
import 'package:platzi_trips_app/Place/ui/widgets/card_image.dart';
import 'package:platzi_trips_app/User/bloc/bloc_user.dart';
import 'package:platzi_trips_app/widgets/button_purple.dart';
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
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    final _controllerTittlePlace = TextEditingController();
    final _controllerDescriptionPlace = TextEditingController();
    double screenWidght = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack("", 300),
          Row(children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 25, left: 5),
              child: SizedBox(
                height: 45,
                width: 45,
                child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
            Flexible(
                child: Container(
              padding: EdgeInsets.only(top: 45, left: 20, right: 10),
              width: screenWidght,
              child: TitleHeader(title: "Add a new place"),
            ))
          ]),
          Container(
            // Crear un saveArea
            margin: EdgeInsets.only(top: 120, bottom: 20),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: CardImage(
                      pathImage: widget.image.path,
                      //pathImage: "assets/img/beach_palm.jpeg",
                      iconData: Icons.camera_alt,
                      onPressedFabIcon: null,
                      height: 250,
                      wigth: 300,
                      left: 0),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: TextInput(
                    hintText: "Title",
                    inputType: null,
                    controller: _controllerTittlePlace,
                    maxLines: 1,
                  ),
                ),
                TextInput(
                  hintText: "Description",
                  inputType: null,
                  controller: _controllerDescriptionPlace,
                  maxLines: 4,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextInputLocation(
                      hintText: "Add Location", icon: Icons.location_on),
                ),
                Container(
                  width: 70,
                  child: ButtonPurple(
                      buttonText: "Add Place",
                      onPressed: () {
                        //FireBase Storage
                        //Id usuario logeado
                        //Subir archivo
                        userBloc.currentUser.then((FirebaseUser user){
                          if(user!=null){
                            String uid = user.uid;
                            String path = "${uid}/${DateTime.now().toString()}.jpg";
                            userBloc.uploadFile(path, widget.image).then(
                              (StorageUploadTask storageUploadTask){
                                storageUploadTask.onComplete.then((StorageTaskSnapshot snapshot){
                                  snapshot.ref.getDownloadURL().then(
                                    (urlImage){
                                      print("urlImage *****************************");

                                      print("urlImage: ${urlImage}");

                                      //Guardar informacion
                                        userBloc.updatePlaceData(Place(
                                        name: _controllerTittlePlace.text,
                                        description: _controllerDescriptionPlace.text,
                                        urlImage: urlImage,
                                        likes: 0,
                                        )).whenComplete(
                                        (){
                                          Navigator.pop(context);
                                        });



                                    });
                                });
                              }
                            );
                          

                          }
                        });

                      
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
