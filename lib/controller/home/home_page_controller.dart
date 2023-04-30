import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController{
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  FirebaseAuth _auth = FirebaseAuth.instance;
  var expoList = [].obs;
  var isLoading = true.obs;

  void loadData() async{
    expoList.clear();
    final phoneNumber = _auth.currentUser!.phoneNumber!.substring(3);

    final snapshot =await ref.child('users/$phoneNumber/expo').get();

    for( var dataSnapshot in snapshot.children){
      expoList.add(dataSnapshot);
      print(dataSnapshot.key);
    }

    isLoading.value = false;

  }
}