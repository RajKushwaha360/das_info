import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePageController extends GetxController {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  var isLoading = true.obs;
  var name = ''.obs;
  var designation = ''.obs;
  var mobile = ''.obs;
  var email = ''.obs;
  var organization = ''.obs;
  var website = ''.obs;
  var address = ''.obs;
  var isShowQr = false.obs;
  FirebaseAuth _auth = FirebaseAuth.instance;

  void loadData() async {
    // final currentUser = _auth.currentUser!;
    // final mobileNumber = currentUser.phoneNumber!.substring(3);
    final phoneNumber = _auth.currentUser!.phoneNumber!.substring(3);
    final snapshot = await ref.child('users/$phoneNumber').get();

    name.value = snapshot.child('name').value.toString();
    designation.value = snapshot.child('designation').value.toString();
    mobile.value = snapshot.child('mobileNumber').value.toString();
    email.value = snapshot.child('emailId').value.toString();
    organization.value = snapshot.child('organization').value.toString();
    website.value = snapshot.child('website').value.toString();
    address.value = snapshot.child('address').value.toString();

    isLoading.value = false;
  }
}
