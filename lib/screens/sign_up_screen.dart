// import 'dart:js_util';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/user_model.dart';
import 'package:tusgrupos/screens/login_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  // final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;
  // var _passwordVisible = false;
  var NombreControler = TextEditingController();
  // var ApellidoController = TextEditingController();
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sign up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Favor ingresar su nombre';
                      }
                      return null;
                    },
                    controller: NombreControler,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Nombre',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     //--------------NombreControler------------------
                  //     Expanded(
                  //       child:
                  //     ),
                  //     const SizedBox(
                  //       width: 20,
                  //     ),
                  //     --------------ApellidoController------------------
                  //     Expanded(
                  //       child: TextFormField(
                  //         validator: (value) {
                  //           if (value == null || value.isEmpty) {
                  //             return 'Favor ingresar su Apellido';
                  //           }
                  //           return null;
                  //         },
                  //         controller: ApellidoController,
                  //         maxLines: 1,
                  //         decoration: InputDecoration(
                  //           hintText: 'Apellido',
                  //           prefixIcon: const Icon(Icons.person),
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  //--------------Email------------------
                  TextFormField(
                    validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : "Favor de ingresar un correo valido",
                    controller: EmailController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Correo',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //--------------Password------------------
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: PasswordController,
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _insertUser(
                            NombreControler.text,
                            // ApellidoController.text,
                            EmailController.text,
                            PasswordController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already registered?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: const Text('Sign in'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _insertUser(
      // ignore: non_constant_identifier_names
      String Nombre,
      // String Apellido,
      String email,
      String password) async {
    var _id = M.ObjectId();
    final user = userModel(
        id: _id,
        Name: Nombre,
        // LastName: Apellido,
        Email: email,
        Password: password);

    // ignore: unused_local_variable
    var result = await MongoDatabase.insertUser(user);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nuevo Usuario'),
      ),
    );
    _clearAll();
  }

  void _clearAll() {
    NombreControler.clear();
    // ApellidoController.clear();
    EmailController.clear();
    PasswordController.clear();
  }
}
