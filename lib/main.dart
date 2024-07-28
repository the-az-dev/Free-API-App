import 'package:bank/model/UserModel.dart';
import 'package:bank/view/UsersPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<UserModel>(
      create: (BuildContext context) => UserModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    User user = new User();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Free API App'),
        ),
        floatingActionButton: ElevatedButton.icon(onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add ne User Data'),
                content: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Name:",
                      ),
                      onChanged: (value) {
                        user.name = value;
                        print(user.name);
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "E-Mail:",
                      ),
                      onChanged: (value) {
                        user.email = value;
                        print(user.email);
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Create'),
                    onPressed: () {
                      Provider.of<UserModel>(context, listen: false).updateUserData(user);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }, label: Text("Add", style: TextStyle(fontSize: 18, color: Colors.black),), icon: Icon(Icons.add, color: Colors.black,)),
        body: UserScreen(),
      ),
    );
  }
}