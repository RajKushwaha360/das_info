import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class IntroductionScreenController extends GetxController {
  PageController controller = PageController();
  var currentPageIndex = 0.obs;

  void goToLastPage() {
    controller.jumpToPage(1);
  }

  void goToNextPage() {
    controller.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void changeCurrentPageIndex(int pageIndex) {
    currentPageIndex.value = pageIndex;
  }

  void loadData(){
    final getStorage = GetStorage();
    getStorage.write("isFirstTime", false);
  }
}
