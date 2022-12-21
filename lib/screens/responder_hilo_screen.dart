import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/comments_model.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/models/user_model.dart';
import 'package:tusgrupos/models/respuesta_model.dart';

import 'package:mongo_dart/mongo_dart.dart' as M;

class ResponderHilo extends StatelessWidget {
  final commentModel hilo;
  final groupModel grupo;

  var descripcionController = TextEditingController();
  var user;

  ResponderHilo({super.key, required this.hilo, required this.grupo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //--------------------appbar--------------------
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 120, 58, 100),
        title: const Text("Responder Hilo"),
//          leading: Builder(
//            builder: (BuildContext context) {
//              return IconButton(
//                icon: const Icon(Icons.menu),
//                onPressed: () {
//                  Scaffold.of(context).openDrawer();
//                },
//              );
//            },
//          ),
//          actions: <Widget>[
//            IconButton(
//              //todo: conectar a buscar grupo
//              onPressed: () {},
//              icon: const Icon(Icons.search),
//              tooltip: 'buscar grupos',
//            ),
//          ]
      ),

      //--------------------drawer--------------------

      //--------------------body--------------------
      body: SingleChildScrollView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(grupo.Name),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(hilo.Title),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  autofocus: true,
                  controller: descripcionController,
                  //initialValue: "Clave",
                  //obscureText: true,
                  validator: (value) {
                    if (value == null) return 'Campo requerido';
                    return value.length < 8 ? 'Ingresar Descripción' : null;
                  },
                  minLines: 5,
                  maxLines: 10,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: 'Respuesta',
                    labelText: 'Respuesta al Hilo',
                    icon: Icon(Icons.verified_user_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                IconButton(
                  onPressed: () {
                    _insertRespuesta(descripcionController.text);
                    print('Respuesta insertado!');
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.check),
                  tooltip: 'confirmar',
                  // disabledColor: Colors.grey,
                  color: Colors.green[800],
                  iconSize: 40,
                ),
              ],
            )),
      ),
    );
  }

  void _insertRespuesta(String descripcion) async {
    final prefs = await SharedPreferences.getInstance();

    var _id = M.ObjectId();
    final String? dueno = prefs.getString('userEmail');
    final now = DateTime.now();

    final user = await userModel.getUser(dueno.toString());

    final respuesta = respuestaModel(
      id: _id,
      Hilo: hilo.id,
      Owner: dueno.toString(),
      OwnerName: userModel.fromJson(user).Name,
      Group: grupo.id,
      Comment: descripcion,
      Date: now,
    );

    var result = await respuestaModel.insertRespuesta(respuesta);
    if (result == 'Success') {
      print("Hilo Creado");
    } else {
      print("Error en la inserción");
    }

    //ScaffoldMessenger.of(context).showSnackBar(
    //  const SnackBar(
    //    content: Text('Nuevo Grupo'),
    //  ),
    //);
    _clearAll();
  }

  void _clearAll() {
    descripcionController.text = '';
  }
}
