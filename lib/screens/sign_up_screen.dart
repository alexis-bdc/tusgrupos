import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
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
              'Registro',
              style: TextStyle(
                color: Color.fromARGB(255, 50, 0, 148),
                fontWeight: FontWeight.bold,
                fontSize: 45,
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
                      prefixIconColor: const Color.fromARGB(255, 50, 0, 148),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

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
                      prefixIconColor: const Color.fromARGB(255, 50, 0, 148),
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
                        return 'Favor ingresar su contrase??a';
                      }
                      return null;
                    },
                    controller: PasswordController,
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIconColor: const Color.fromARGB(255, 50, 0, 148),
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Contrase??a',
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
                        _insertUser(NombreControler.text, EmailController.text,
                            PasswordController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      backgroundColor: const Color.fromARGB(255, 172, 0, 101),
                    ),
                    child: const Text(
                      'Registrarse',
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
                      const Text('Ya tienes cuenta? '),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 122, 195, 255),
                          ),
                          child: const Text('Ingresa')),
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
    var result = await userModel.insertUser(user);
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
