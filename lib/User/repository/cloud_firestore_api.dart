import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/Place/ui/widgets/card_image.dart';
import 'package:platzi_trips_app/User/model/user.dart';
import 'package:platzi_trips_app/User/ui/widgets/profile_place.dart';

class CloudFirestoreAPI{
  final String USERS="users";
  final String PLACES="places";
  final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateUserData(User user) async{
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    return await ref.setData({
      'uid':user.uid,
      'name':user.name,
      'email':user.email,
      'photoURL':user.photoURL,
      'myPlaces':user.myPlaces,
      'myFavoritePlaces':user.myfavoritePlaces,
      'lastSignIn':DateTime.now()
    },merge: true);
  }

  Future<void> updatePlaceData(Place place) async {
      CollectionReference refPlaces = _db.collection(PLACES);
      
     await _auth.currentUser().then((FirebaseUser user){
        refPlaces.add({
          'name':place.name,
          'description': place.description,
          'likes':place.likes,
          'urlImages':place.urlImage,
          'userOwner': _db.document("${USERS}/${user.uid}")
          }).then((DocumentReference dr){
            dr.get().then((DocumentSnapshot snapshot){
              
              DocumentReference refUser = _db.collection(USERS).document(user.uid);
              refUser.updateData({
                'myPlaces' : FieldValue.arrayUnion([_db.collection(PLACES).document(snapshot.documentID)])
              });
            });
          });
      });

    
     
  }

    List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot){
      List<ProfilePlace> profilePlaces = List<ProfilePlace>();
      placesListSnapshot.forEach((p) {
        print(":::::::::> ${p.data['name']}");
        print(":::::::::> ${p.data['description']}");
        print(":::::::::> ${p.data['urlImages']}");
        profilePlaces.add(ProfilePlace(
          Place(
              name: p.data['name'],
              description: p.data['description'],
              urlImage: p.data['urlImages'],
              likes: p.data['likes'])
          ));

      });

      return profilePlaces;


  }

  List<CardImage> buildPlaces(List<DocumentSnapshot> placeListsnapshot){
    List<CardImage>  placesCard = List<CardImage>();
    double height = 200;
    double widght = 250;
    double left = 20;
    IconData iconData = Icons.favorite_border; 


       placeListsnapshot.forEach((p) {
         print("::::::::::    ${p.data["urlImages"]}");
        placesCard.add(CardImage(
            
            pathImage: p.data["urlImages"],
            widght: widght,
            height: height,
            left: left,
            onPressedFabIcon: (){
              likePlace(p.documentID);
            },
            iconData: iconData
        )
        );
      });
   
   return placesCard;
  }


  Future likePlace(String idPlace) async{
    await _db.collection(PLACES).document(idPlace).get().then(
      (DocumentSnapshot ds){
        int likes = ds.data["likes"];
        print("====== Likes ${likes}" );
        _db.collection(PLACES).document(idPlace).updateData({
          'likes' : likes+1
        });
      }
    );

  }
}