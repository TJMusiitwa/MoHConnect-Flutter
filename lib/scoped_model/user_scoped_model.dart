import 'package:moh_connect/models/register_user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class UserScopedModel extends Model {
  User _currentUser;

  void login(User user) {
    _currentUser = user;
  }

  User get currentUser {
    return _currentUser;
  }

  void registerUser() async {
    try {
      http.Response response = await http
          .get('http://15.188.180.73:8080/YCSR/webapi/requests/user/register');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
