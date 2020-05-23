import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:platzi_trips_app/User/bloc/bloc_user.dart';
import 'package:platzi_trips_app/User/model/user.dart';
import 'package:platzi_trips_app/platzi_trips_cupertino.dart';
import 'package:platzi_trips_app/widgets/gradient_back.dart';
import 'package:platzi_trips_app/widgets/button_green.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class SignInScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
     return _SignInScreen();
  }



}

class _SignInScreen extends State{

  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession(){
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData || snapshot.hasError){
          return signInGoogleUI();
        }else{
          return PlatziTripsCupertino();
        }
      }
    );
  }

  Widget signInGoogleUI(){
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack("",null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Welcome \n This is your travel app",
                style: TextStyle(
                  fontSize: 37,
                  fontFamily: "Lato",
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
              ButtonGreen(onPressed: (){
                userBloc.signOut();
                userBloc.signIn().then((FirebaseUser user) 
                {
                  userBloc.updateUserData(User(
                    uid: user.uid,
                    name: user.displayName,
                    email:user.email,
                    photoURL: user.photoUrl));
                });
              },
                text: "Login with Gmail",
                width: 300,
                height: 65,
              ),
            ],
          )
        ],
      ),
    );
  }


}
