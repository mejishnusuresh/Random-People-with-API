import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apitest/Model/patientmodel.dart';

class Webservice {

  //list patient
  Future<Map<String, dynamic>> listpatient(
      String userId,
      String clinicId,
      ) async {
    var result;

    var token =
        "ZG9jdG9zbWFydGFkbWluOiQyeSQxMiQ5WmE3VXROT2xqUlVXVm1WcnE4eXYuWnB1ekVoSzZ5ekkuZ2RLUkN4dzJFdFVmdnh5U1YzUw==";
    String basicAuth = 'Basic ' + token;
    print(basicAuth);
    final url =
        "https://app.doctosmart.com/api/patients?user_id=$userId&clinic_id=$clinicId&page_no=0";
    final response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Basic $token'});

    print(response.statusCode);
    if (response.statusCode == 200) {
      print("inside 200");
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      var userData = responseData;

      ListPatientModel user = ListPatientModel.fromJson(userData);

      result = {'status': true, 'message': 'Successful', 'user': user};
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

}