// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tusgrupos/dbHelper/mongodb.dart';

import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/models/user_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);
  // final userModel user;
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final _formkey = GlobalKey<FormState>();
  var NombreControler = TextEditingController();
  var descripcionControler = TextEditingController();
  var claveControler = TextEditingController();
  var user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Color.fromARGB(255, 190, 173, 185),

      //--------------------appbar--------------------
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 120, 58, 100),
        title: const Text("Crear Grupo"),
      ),

      //--------------------drawer--------------------
      // drawer: const MenuDrawer(),

      //--------------------body--------------------
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  //-------------------nombre-------------------------
                  TextFormField(
                    controller: NombreControler,
                    decoration: InputDecoration(
                      hintText: 'Nombre del grupo',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un nombre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //-------------------descripcion-------------------------
                  TextFormField(
                    controller: descripcionControler,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      hintText: 'Descripcion del grupo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese una descripcion';
                      }
                      return null;
                    },
                    minLines: 5,
                    maxLines: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //---------------activar clave--------------------

                  //-------------------clave-------------------------
                  TextFormField(
                    controller: claveControler,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      hintText: 'Clave del grupo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese una clave';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _insertGroup(NombreControler.text,
                          descripcionControler.text, claveControler.text);
                    }
                  },
                  icon: const Icon(Icons.check),
                  tooltip: 'confirmar',
                  // disabledColor: Colors.grey,
                  color: Colors.green[800],
                  iconSize: 40,
                ),
                // IconButton(
                //   onPressed: onPressed,
                //   icon: const Icon(Icons.cancel)),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _insertGroup(String nombre, String descripcion, String clave) async {
    final prefs = await SharedPreferences.getInstance();
    var _id = M.ObjectId();
    final String? dueno = prefs.getString('userEmail');

    final user = await MongoDatabase.getUser(dueno.toString());

    final group = groupModel(
      id: _id,
      idOwner: user['_id'],
      OwnerName: userModel.fromJson(user).Name,
      Name: nombre,
      Description: descripcion,
      password: clave,
    );

    var result = await MongoDatabase.insertGroup(group);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nuevo Grupo'),
      ),
    );
    if (result == 'Success') {
      result = await MongoDatabase.inscribeUser(group);
    }
    _clearAll();
  }

  void _clearAll() {
    NombreControler.text = '';
    descripcionControler.text = '';
    claveControler.text = '';
  }
}
