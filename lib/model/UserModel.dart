import 'package:flutter/cupertino.dart';

class UserModel with ChangeNotifier{

  List<User> users = [];

  List<User> getUserData(){
    return users;

  }

  void updateUserData(User user) {
    if(users.isNotEmpty){
      final extUser = users.where((exitingUser) => exitingUser.id == user.id);
      if(extUser != true){
        users.add(user);
      }
    }else {
      users.add(user);
    }
    notifyListeners();
  }

  void sortUserData(String? sortType){
    if(sortType == "By Name Ascending"){
      users.sort((a, b) => a.name.compareTo(b.name));
    }
    else if(sortType == "By Name Descending"){
      users.sort((a, b) => b.name.compareTo(a.name));
    }
    else if(sortType == "By ID Ascending"){
      users.sort((a, b) => a.id.compareTo(b.id));
    }
    else if(sortType == "By ID Descending"){
      users.sort((a, b) => b.id.compareTo(a.id));
    }
    notifyListeners();
  }

  void deleteUserData(id){
    users.removeWhere((user) => user.id == id);
    notifyListeners();
  }

  UserModel({users = const []});
}


class User{
  int id;
  String name;
  int age;
  String username;
  String email;
  Object address;
  String phone;
  String website;
  String occupation;
  List hobbies;

  void updateUser(id, name, age, username, email, address, phone, website, occupation, hobbies){
    this.id = id;
    this.name = name;
    this.age = age;
    this.username = username;
    this.email = email;
    this.address = address;
    this.phone = phone;
    this.website = website;
    this.occupation = occupation;
    this.hobbies = hobbies;
  }

  User({
    this.id = 0,
    this.name = '',
    this.age = 0,
    this.username = '',
    this.email = '',
    this.address = const {},
    this.phone = '',
    this.website = '',
    this.occupation = '',
    this.hobbies = const []
  });
}