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
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _getEmail();
  }

  void _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('loginEmail') ?? '';
    _email.text = name;
    print(name);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = getScreenWidth(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
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

  void loginUser(String email, String password) {
    UserModel user = UserModel(email: email, password: password);
    var response = user.loginUser(user).then(
      (value) {
        if (value!.statusCode == 200) {
          final snackBar = SnackBar(
            content: const Text("Login Successful!"),
            backgroundColor: (Colors.green),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Dashboard()),
            (route) => false,
          );
        } else {
          final snackBar = SnackBar(
            content: const Text("Login Error!"),
            backgroundColor: (Colors.red),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }
}
