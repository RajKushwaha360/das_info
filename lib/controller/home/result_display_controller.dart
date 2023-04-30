import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class ResultDisplayController extends GetxController {
  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  var isLoading = true.obs;
  var name = ''.obs;
  var mobile = ''.obs;
  var email = ''.obs;
  var organization = ''.obs;
  var website = ''.obs;
  FirebaseAuth _auth = FirebaseAuth.instance;

  void loadData(String mobileNumber) async {
    final snapshot = await ref.child('users/$mobileNumber').get();

    name.value = snapshot.child('name').value.toString();
    mobile.value = snapshot.child('mobileNumber').value.toString();
    email.value = snapshot.child('emailId').value.toString();
    organization.value = snapshot.child('organization').value.toString();
    website.value = snapshot.child('website').value.toString();

    isLoading.value = false;
  }

  void addToContactBook(String mobileNumber) async {
    final phoneNumber = _auth.currentUser!.phoneNumber!.substring(3);
    try {
      await ref.child('users/$phoneNumber/contacts').push().set(mobileNumber);
    } catch (e) {
      print(e.toString());
    }

    Get.back();
  }

  void addAsVisitor(String expoKey, String resultData) async {
    final phoneNumber = _auth.currentUser!.phoneNumber!.substring(3);
    final snapshot = ref.child('users/$phoneNumber/expo');
    await snapshot
        .child(expoKey)
        .child('visitors')
        .push()
        .set(resultData);

    Get.back();
  }
}
