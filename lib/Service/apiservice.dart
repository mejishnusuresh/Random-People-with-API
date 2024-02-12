import 'dart:convert';
import 'package:apitest/Model/usermodel.dart';
import 'package:http/http.dart' as http;

class UserAPI {
  static Future<List<UserModel>> fetchUsers() async {
    try {
      const url = "https://randomuser.me/api/?results=100";
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        final results = json['results'] as List<dynamic>;

        final users = results.map((e) {
          return UserModel.fromMap(e);
        }).toList();
        return users;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error fetching users: $e');
      throw Exception('Failed to load users');
    }
  }
}
