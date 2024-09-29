import 'package:central_perk/models/user.dart';

class UserManager {

  static List<User> users = List.empty(growable: true);

  UserManager() {
    users = _generateUsersList();
  }

  List<User> _generateUsersList() {
    return [
      _generateUser('Ross Geller', 'friends', ''),
      _generateUser('Carlos Martínez', '', ''),
      _generateUser('Ana Sofía', '', ''),
      _generateUser('María Fernanda', '', ''),
      _generateUser('Diego Alejandro', '', ''),
      _generateUser('Sofía Lucía', '', ''),
    ];
  }

  User _generateUser(
    String name,
    String password,
    String profileImage,
  ) {
    return User(
      name: name,
      password: password,
      profileImage: profileImage
    );
  }
}