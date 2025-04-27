import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  Future<String?> getToken() async {
    return (await SharedPreferences.getInstance()).getString('token');
  }
}
