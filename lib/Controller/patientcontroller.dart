import 'package:apitest/Service/webservice.dart';
import 'package:get/get.dart';

class patientController extends GetxController {
  static patientController get to => Get.find();

  Future<Map<String, dynamic>> listpatient(String userId,
      String clinicId,) async {
    final results = await Webservice().listpatient(userId, clinicId);

    return results;
  }
}