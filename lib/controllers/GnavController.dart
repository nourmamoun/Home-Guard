import 'package:get/get.dart';
import 'package:smart_home/pages/Camera.dart';
import 'package:smart_home/pages/NotificationPage.dart';
class BottomNavigationBarController extends GetxController{
  RxInt index = 0.obs;

  var pages = [
    NotificationsPage(),
    CameraPage()
  ];
}