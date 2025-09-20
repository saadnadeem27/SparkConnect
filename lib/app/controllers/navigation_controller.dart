import 'package:get/get.dart';

/// Navigation controller for managing bottom navigation
class NavigationController extends GetxController {
  final RxInt _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  void changePage(int index) {
    _currentIndex.value = index;
  }

  void goToHome() => _currentIndex.value = 0;
  void goToSearch() => _currentIndex.value = 1;
  void goToCreate() => _currentIndex.value = 2;
  void goToNotifications() => _currentIndex.value = 3;
  void goToProfile() => _currentIndex.value = 4;
}
