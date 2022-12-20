import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tusgrupos/models/comments_model.dart';
import 'package:tusgrupos/models/group_model.dart';

import '../dbHelper/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

//
//TO DO: Tiene que haber una retroalimentación de la creación del hilo
//      También falta modificar el modelo del hilo para que guarde el título (Listo!)
//      Falta hacer la pantalla del hilo                                     (Listo!)
//      Asegurarse que el nuevo hilo aparezca en la pantalla de hilos
//      Refinar la pantalla del hilo, tiene que aparecer el nombre del usuario que lo hizo
//      Agregar la posibilidad de responder al hilo en la pantalla del hilo  (Listo!)
//      Hacer pantalla de responder hilo                                     (Listo!)
//

class CrearHilo extends StatelessWidget {
  final groupModel grupo;

  var tituloController = TextEditingController();
  var descripcionController = TextEditingController();
  var user;

  CrearHilo({Key? key, required this.grupo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //--------------------appbar--------------------
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 120, 58, 100),
        title: const Text("Crear Hilo"),
      ),

      //--------------------drawer--------------------
      //drawer: const MenuDrawer(),

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
                const SizedBox(height: 30),
                TextFormField(
                  controller: tituloController,
                  autofocus: true,
                  //initialValue: "Clave",
                  //obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un nombre';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: 'Título',
                    labelText: 'Título Hilo',
                    icon: Icon(
                      Icons.title_outlined,
                      color: Colors.purple,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  //initialValue: "Clave",
                  //obscureText: true,
                  controller: descripcionController,
                  minLines: 5,
                  maxLines: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un nombre';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: 'Hilo',
                    labelText: 'Cuerpo del Hilo',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    icon:
                        Icon(Icons.description_outlined, color: Colors.purple),
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
                    _insertComment(
                        tituloController.text, descripcionController.text);
                    print('Comentario insertado!');
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

  void _insertComment(String titulo, String descripcion) async {
    final prefs = await SharedPreferences.getInstance();

    var _id = M.ObjectId();
    final String? dueno = prefs.getString('idUser');
    final now = DateTime.now();

    final comment = commentModel(
      id: _id,
      Owner: dueno.toString(),
      Group: grupo.id,
      Title: titulo,
      Comment: descripcion,
      Date: now,
    );

    var result = await MongoDatabase.insertComment(comment);
    if (result == "Success") {
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
    tituloController.text = '';
    descripcionController.text = '';
  }
}
