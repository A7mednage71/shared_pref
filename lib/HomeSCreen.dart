import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_pref/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "User Name";

  int phone = 0;

  // ignore: non_constant_identifier_names
  GlobalKey<FormState> _FormKey = GlobalKey();

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    gitdata();
  }

  Future<void> gitdata() async {
    final sharedPreference = await SharedPreferences.getInstance();
    name = sharedPreference.getString('Name') ?? 'USerName';
    phone = sharedPreference.getInt('Phone') ?? 555;

    var model = sharedPreference.getString('UserModel');

    UserModel userModel =
        model == null ? UserModel() : UserModel.fromJSON(json.decode(model));
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _FormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$name',
                  style: const TextStyle(color: Colors.red, fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '$phone',
                  style: const TextStyle(color: Colors.red, fontSize: 24),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    name = newValue!;
                  },
                  decoration: InputDecoration(
                    prefix: const Icon(
                      Icons.person,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) {
                    phone = int.parse(newValue!);
                  },
                  decoration: InputDecoration(
                    prefix: const Icon(
                      Icons.phone,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    labelText: 'phone',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  onPressed: () {
                    saveData();
                    setState(() {});
                  },
                  child: Text('Save'),
                  color: Colors.amber,
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      DeleteData();
                    });
                  },
                  child: Text('Delete'),
                  color: Colors.amber,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveData() async {
    _FormKey.currentState!.save();
    final sharedPreference = await SharedPreferences.getInstance();

    sharedPreference.setString('Name', name);
    sharedPreference.setInt('phone', phone);

    sharedPreference.setString(
      //store instance of UserModel // object لازم تعمل انكود للاوبجكت علشان يتخزن ك استرنج
      'UserModel',
      json.encode(
        UserModel(age: 50, secName: 'nageh').toJSON(),
      ),
    );

    print(sharedPreference.getString('Name'));
    print(sharedPreference.getInt('phone'));
    print(sharedPreference.getString('UserModel'));
  }

  DeleteData() async {
    final sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.remove('name');
    sharedPreference.remove('phone');
    setState(() {
      name = 'empty';
      phone = 0;
    });
  }
}
