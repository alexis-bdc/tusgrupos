import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/login_screen.dart';

import 'dbHelper/mongodb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage());
  }
}

// TODO: screen mis grupos
// TODO: screen login / register
// TODO: screen buscar grupo
// TODO: screen respuesta / subir archivo
// TODO: screen crear hilo
// TODO: screen this group
// TODO: screen control de grupo