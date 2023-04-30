import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class QrScannerController extends GetxController {
  var isLoading = false.obs;
  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  void loadData(String expoKey, String resultData) async {
    isLoading.value = true;

    final phoneNumber = _auth.currentUser!.phoneNumber!.substring(3);
    final snapshot = ref.child('users/$phoneNumber/expo');
    await snapshot.child(expoKey).child('visitors').push().set(resultData);

    isLoading.value = false;
  }
}
