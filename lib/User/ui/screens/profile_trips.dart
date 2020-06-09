import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/User/bloc/bloc_user.dart';
import 'package:platzi_trips_app/User/model/user.dart';
import 'package:platzi_trips_app/User/ui/screens/profile_header.dart';
import '../widgets/profile_places_list.dart';
import '../widgets/profile_background.dart';

class ProfileTrips extends StatelessWidget {

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
   
    userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        switch (snapshot.connectionState) {
          case ConnectionState.waiting :

          case ConnectionState.none :
            return CircularProgressIndicator();
          case ConnectionState.active :
           return  showProfileData(snapshot);
           
          case ConnectionState.done :
           return  showProfileData(snapshot);
            break;
          default:
          break;
        }
      });
    
    
  
  }

  Widget showProfileData(AsyncSnapshot snapshot){

    if(!snapshot.hasData || snapshot.hasError){
      print("No login");
      return Stack(
      children: <Widget>[
        ProfileBackground(),
        ListView(
          children: <Widget>[
          //  ProfileHeader(),
           // ProfilePlacesList()
            Text("Usuario No logueado")
          ],
        ),
      ],
      );
    }else{
      print("UsuarioLoggueado");
      var user = User(
        uid: snapshot.data.uid,
        name: snapshot.data.displayName,
        email: snapshot.data.email,
        photoURL: snapshot.data.photoUrl);

      return Stack(
      children: <Widget>[
        ProfileBackground(),
        ListView(
          children: <Widget>[
            ProfileHeader(user),
            ProfilePlacesList(user)

            ],
          ),
        ],
      );

    }
  }

}