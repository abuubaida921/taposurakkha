import 'package:get/get.dart';
import 'court_controller.dart';

class CourtBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CourtController());
  }
}

