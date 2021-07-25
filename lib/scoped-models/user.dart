import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class UserModel extends Model {
  Future<Map<String, dynamic>> signUp(
      String id,
      String fname,
      String lname,
      String username,
      String password,
      String email,
      String phoneNo,
      String address) async {
    final Map<String, dynamic> userData = {
      "id": id,
      "first_name": fname,
      "last_name": lname,
      "username": username,
      "password": password,
      "email": email,
      "phone_no": phoneNo,
      "address": address
    };
    Uri url = Uri.parse("http://10.0.2.2:3000/client");
    final http.Response response = await http.post(url,
        body: json.encode(userData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);

    return {'success': true, 'message': "signed up"};
  }
}
