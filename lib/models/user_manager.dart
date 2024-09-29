import 'package:central_perk/models/user.dart';

class UserManager {

  static List<User> users = List.empty(growable: true);

  UserManager() {
    users = _generateUsersList();

    for (int i = 0; i < users.length; i++) {
      print(users[i].name);
      print(users[i].id);
    }
  }

  List<User> _generateUsersList() {
    return [
      _generateUser('Carlos Martínez', '', ''),
      _generateUser('Ana Sofía', '', ''),
      _generateUser('María Fernanda', '', ''),
      _generateUser('Diego Alejandro', '', ''),
      _generateUser('Sofía Lucía', '', ''),
    ];
  }

  User _generateUser(String name, String password, String profileImage) {
    return User(
      name: name,
      password: password,
      profileImage: profileImage
    );
  }
}