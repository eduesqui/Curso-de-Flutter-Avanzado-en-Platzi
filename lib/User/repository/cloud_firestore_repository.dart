import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/Place/ui/widgets/card_image.dart';
import 'package:platzi_trips_app/User/model/user.dart';
import 'package:platzi_trips_app/User/repository/cloud_firestore_api.dart';
import 'package:platzi_trips_app/User/ui/widgets/profile_place.dart';

class CloudFireStoreRepository{
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(User user)=>_cloudFirestoreAPI.updateUserData(user);

  Future<void> updatePlaceData(Place place) =>_cloudFirestoreAPI.updatePlaceData(place);

   List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placeListSnapshot) => _cloudFirestoreAPI.buildMyPlaces(placeListSnapshot);
   List<CardImage> buildPlaces(List<DocumentSnapshot> placeListsnapshot) => _cloudFirestoreAPI.buildPlaces(placeListsnapshot);

}