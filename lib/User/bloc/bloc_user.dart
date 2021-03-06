

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/Place/repository/firebase_storage_repository.dart';
import 'package:platzi_trips_app/Place/ui/widgets/card_image.dart';
import 'package:platzi_trips_app/User/model/user.dart';
import 'package:platzi_trips_app/User/repository/auth_repository.dart';
import 'package:platzi_trips_app/User/repository/cloud_firestore_api.dart';
import 'package:platzi_trips_app/User/repository/cloud_firestore_repository.dart';
import 'package:platzi_trips_app/User/ui/widgets/profile_place.dart';

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();

  Stream<FirebaseUser> streamFirebase =
      FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => streamFirebase;

  Future<FirebaseUser> get currentUser =>  FirebaseAuth.instance.currentUser();

  final _firebaseStorageRepository = FirebaseStorageRepository();
  Future<StorageUploadTask> uploadFile(String path, File image) =>_firebaseStorageRepository.uploadFile(path, image);

  // Login con google
  Future<FirebaseUser> signIn() {
    return _auth_repository.signInFirebase();
  }

  //Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFireStoreRepository();
  void updateUserData(User user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);


  //Mantiene siempre a la escucha esa coleccion
  
  Stream<QuerySnapshot> placesListStream = Firestore.instance.collection(CloudFirestoreAPI().PLACES).snapshots();
  Stream<QuerySnapshot> get placesStream => placesListStream;
 
  Stream<QuerySnapshot> myPlacesListStream (String uid) =>
    Firestore.instance.collection(CloudFirestoreAPI().PLACES).
      where("userOwner",isEqualTo: Firestore.instance.document("${CloudFirestoreAPI().USERS}/${uid}")).snapshots();

  List<CardImage> buildPlaces(List<DocumentSnapshot> placeListsnapshot) =>_cloudFirestoreRepository.buildPlaces(placeListsnapshot);


  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreRepository.buildMyPlaces(placesListSnapshot);

  Future<void> updatePlaceData(Place place) =>
      _cloudFirestoreRepository.updatePlaceData(place);

  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
