import 'package:flutter/material.dart';
import 'package:bank/APIService.dart';
import 'package:bank/model/UserModel.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {

    String? selectedOption;

    final List<String> options = ['By Name Ascending', 'By Name Descending', 'By ID Ascending', 'By ID Descending'];

    return FutureBuilder(
      future: APIService().fetch("users"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final userData = snapshot.data;
          for (final user in userData){
            User newUser = new User();
            newUser.updateUser(
                user["id"],
                user["name"],
                user["age"],
                user["username"],
                user["email"],
                user["address"],
                user["phone"],
                user["website"],
                user["occupation"],
                user["hobbies"]
            );
            Provider.of<UserModel>(context, listen: false).updateUserData(
                newUser
            );
          }
          final users = Provider.of<UserModel>(context).getUserData();
          return Padding(
              padding: EdgeInsets.all(15),
              child: Column(
              children: [
                DropdownButton<String>(
                  value: selectedOption,
                  hint: Text('Select a sort option'),
                  onChanged: (String? newValue) {
                    selectedOption = newValue;
                    Provider.of<UserModel>(context, listen: false).sortUserData(newValue);
                  },
                  items: options.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      print(users.length);
                      return ListTile(
                        title: Text(user.name),
                        subtitle: Text(user.email),
                        trailing: IconButton(icon: Icon(Icons.delete_outlined), onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirm Delete'),
                                content: Text('Are you sure you want to delete this item?'),
                                actions: [
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Delete'),
                                    onPressed: () {
                                      Provider.of<UserModel>(context, listen: false).deleteUserData(user.id);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },),
                      );
                    },
                  )
                )
              ],
            ),
          );
        }
      },
    );
  }
}