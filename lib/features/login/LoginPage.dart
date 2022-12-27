import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/UserModel.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

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
                              // Wenn alle Validatoren der Felder des Formulars gültig sind.
                              if (_formKey.currentState!.validate()) {
                                loginUser(_email.text, _password.text);
                                // Hier können wir mit den geprüften Daten aus dem Formular etwas machen.
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
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final snackBar = SnackBar(
            content: const Text("Login Error!"),
            backgroundColor: (Colors.red),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }
}
