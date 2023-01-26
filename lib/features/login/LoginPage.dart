import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_helpful_toolbox/data/models/UserModel.dart';
import 'package:the_helpful_toolbox/features/dashboard/dashboard.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';
import 'package:the_helpful_toolbox/helper/snackbarDisplay.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _connectionString = TextEditingController();
  @override
  void initState() {
    super.initState();
    _getEmail();
  }

  void _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('loginEmail') ?? '';
    _email.text = name;

    final connString = prefs.getString('ConnectionString') ?? '';
    _connectionString.text = connString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (val) {
              switch (val) {
                case 'Settings':
                  _showSettingsDialog(_connectionString);
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: isSmallScreen(context)
                    ? getScreenWidth(context) * 0.8
                    : getScreenWidth(context) * 0.3,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email-Address'),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@') ||
                                !value.contains('.')) {
                              return 'Invalid Email';
                            }
                            _email.text = value;
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _password,
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Invalid Password';
                            }

                            _password.text = value;
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            if (_formKey.currentState!.validate()) {
                              loginUser(_email.text, _password.text);
                            } else {}
                          },
                        ),
                      ),
                      const SizedBox(width: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _formKey.currentState!.reset();
                            },
                            child: const Text('Delete'),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                loginUser(_email.text, _password.text);
                              } else {}
                            },
                            child: const Text('Login'),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog(TextEditingController connectionString) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Login Settings"),
            content: Form(
              key: _formKey2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: connectionString,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Connection Url'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Invalid Password';
                        }
                        connectionString.text = value;
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (_formKey2.currentState!.validate()) {
                          setConnectionString(connectionString.text);
                        } else {}
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey2.currentState!.validate()) {
                        setConnectionString(connectionString.text);
                      } else {}
                    },
                    child: const Text('Save'),
                  )
                ],
              ),
            ),
          );
        });
  }

  void loginUser(String email, String password) {
    UserModel user = UserModel(email: email, password: password);
    var response = user.loginUser(user, context).then(
      (value) {
        if (value!.statusCode == 200) {
          snackbarwithMessage("Login Successful!", context, 1);

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Dashboard()),
            (route) => false,
          );
        } else {
          Map<String, dynamic> temp = json.decode(value.body);
          String message = temp["message"];
          snackbarwithMessage("Login Error! $message", context, 2);
        }
      },
    );
  }

  Future<void> setConnectionString(String text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ConnectionString', text).then(
      (value) {
        Navigator.pop(context);
        snackbarwithMessage("Connection saved!", context, 1);
      },
    );
  }
}
