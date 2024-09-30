import 'package:central_perk/models/user.dart';

class UserManager {

  static List<User> users = List.empty(growable: true);

  UserManager() {
    users = _generateUsersList();
    _defaultFriends();
  }

  List<User> _generateUsersList() {
    return [
      _generateUser('Ross Geller', 'proffesorgeller' ,'friends', ''),
      _generateUser('Rachel Greene', 'buyerasssistant' , '', ''),
      _generateUser('Monica Geller', 'bigfatgoalie' , '', ''),
      _generateUser('Joey Tribbiani', 'kenadams' , '', ''),
      _generateUser('Chandler Bing', 'chanandlerbong' , '', ''),
      _generateUser('Phoebe Buffay', 'reginaphalange' , '', ''),
    ];
  }

  User _generateUser(
    String name,
    String username,
    String password,
    String profileImage,
  ) {
    return User(
      name: name,
      username: username,
      password: password,
      profileImage: profileImage
    );
  }

  void _defaultFriends() {
    // Add all users as friends of user 1
    for (int i = 1; i < users.length; i++) {
      users[0].addFriend(users[i]);
    }
  }
}