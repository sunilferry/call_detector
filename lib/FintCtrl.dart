
import 'package:call_detect/socket_contrller.dart';
import 'package:get/get.dart';

/**
 *Developed by Suneel kumar 11-03-2022
 */

class FindCtrl{
  static SocketIoController socketIo=Get.find<SocketIoController>();

  static final  mysocketIo=Get.find<SocketIoController>().socket;
}