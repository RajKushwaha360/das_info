import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class PersonalLeadsController extends GetxController {
  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  var isLoading = true.obs;
  var data = [].obs;
  var name = ''.obs;
  var mobile = ''.obs;
  var email = ''.obs;
  var organization = ''.obs;
  var website = ''.obs;
  FirebaseAuth _auth = FirebaseAuth.instance;

  void loadData() async {

    data.clear();

    final phoneNumber = _auth.currentUser!.phoneNumber!.substring(3);
    
    final snapshot = await ref.child('users/$phoneNumber/contacts').get();

    for (var dataSnapshot in snapshot.children){
      fetchUserDetailsFromNumber(dataSnapshot.value.toString());
      print(dataSnapshot.value.toString());
    }

    isLoading.value = false;
  }

  void fetchUserDetailsFromNumber(String mobileNumber) async{
    final snapshot = await ref.child('users/$mobileNumber').get();
    data.add(snapshot);
  }

}
