import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_helpful_toolbox/data/models/UserModel.dart';
import 'package:the_helpful_toolbox/features/dashboard/presentation/dashboard.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
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
    print(name);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = getScreenWidth(context);
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
                            } else {
                              print("Formular ist nicht gültig");
                            }
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
                            child: Text('Delete'),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                loginUser(_email.text, _password.text);
                              } else {
                                print("Formular ist nicht gültig");
                              }
                            },
                            child: Text('Save'),
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
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Login Settings"),
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
                        } else {
                          print("Connection String nicht gültig");
                        }
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey2.currentState!.validate()) {
                        setConnectionString(connectionString.text);
                      } else {
                        print("Connection String nicht gültig");
                      }
                    },
                    child: Text('Save'),
                  )
                ],
              ),
            ),
          );
        });
  }

  void loginUser(String email, String password) {
    UserModel user = UserModel(email: email, password: password);
    var response = user.loginUser(user).then(
      (value) {
        if (value!.statusCode == 200) {
          const snackBar = SnackBar(
            content: Text("Login Successful!"),
            backgroundColor: (Colors.green),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Dashboard()),
            (route) => false,
          );
        } else {
          const snackBar = SnackBar(
            content: Text("Login Error!"),
            backgroundColor: (Colors.red),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }

  Future<void> setConnectionString(String text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ConnectionString', text);
    Navigator.pop(context);
    const snackBar = SnackBar(
      content: Text("Connection saved!"),
      backgroundColor: (Colors.green),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}