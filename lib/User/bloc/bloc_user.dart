import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/User/model/user.dart';
import 'package:platzi_trips_app/User/repository/auth_repository.dart';
import 'package:platzi_trips_app/User/repository/cloud_firestore_api.dart';
import 'package:platzi_trips_app/User/repository/cloud_firestore_repository.dart';

class UserBloc implements Bloc{

  final _auth_repository = AuthRepository();


  Stream<FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => streamFirebase;
  // Login con google
  Future<FirebaseUser> signIn(){
    return _auth_repository.signInFirebase();
  }

  //Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFireStoreRepository();
  void updateUserData(User user) => _cloudFirestoreRepository.updateUserDataFirestore(user);

  signOut(){
    _auth_repository.signOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

}