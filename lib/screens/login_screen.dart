import 'package:flutter/material.dart';
import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/screens/home_screen.dart';
import 'package:tusgrupos/screens/sign_up_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  // static String tag = 'login-page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController(text: 'example@usach.cl');
  var passwordController = TextEditingController(text: '1234');

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'Tus Grupos',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 60.0,
        child: Image.asset('assets/TusGrupos.png'),
      ),
    );

    final email = TextFormField(
      // key: _formKey,
      keyboardType: TextInputType.emailAddress,
      // autofocus: false,
      // initialValue: 'example@usach.cl',
      controller: emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Favor ingresar su email';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Favor ingresar su contraseña';
        }
        return null;
      },
      // autofocus: false,
      // initialValue: 'some password',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.all(12),
        ),
        onPressed: () =>
            _validateUser(emailController.text, passwordController.text),
        child: const Text('Iniciar sesión', style: TextStyle(color: Colors.white)),
      ),
    );

    // final forgotLabel = TextButton(
    //   child: const Text(
    //     'Forgot password?',
    //     style: TextStyle(color: Colors.black54),
    //   ),
    //   onPressed: () {},
    // );

    final signUpLabel = TextButton(
      child: const Text(
        'Regístrate',
        style: TextStyle(color: Color.fromARGB(136, 7, 38, 177)),
      ),
      onPressed: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const SignUpPage();
      })),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            // forgotLabel,
            signUpLabel
          ],
        ),
      ),
    );
  }

  Future<void> _validateUser(String email, String password) async {
    var result = await MongoDatabase.findUser(email, password);

    if (email == '' || password == '') {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Agregue un email y contraseña'),
      ));
    } else {
      if (result == true) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const HomeScreen();
        }));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Credenciales incorrectas'),
        ));
      }
    }
  }
}
