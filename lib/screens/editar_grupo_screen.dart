// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/screens/ajustes_grupo_screen.dart';

class EditarGrupo extends StatelessWidget {
  final groupModel grupo;

  EditarGrupo({Key? key, required this.grupo}) : super(key: key);
  // final userModel user;

  var NombreControler = TextEditingController();
  var descripcionControler = TextEditingController();
  var claveControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Color.fromARGB(255, 190, 173, 185),

      //--------------------appbar--------------------
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 120, 58, 100),
        title: Text("Editar Grupo " + grupo.Name),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  //-------------------nombre-------------------------
                  TextFormField(
                    //initialValue: grupo.Name,
                    controller: NombreControler,
                    //autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        NombreControler.text = grupo.Name;
                      } else {
                        NombreControler.text = value;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //-------------------descripcion-------------------------
                  TextFormField(
                    //initialValue: grupo.Description,
                    controller: descripcionControler,
                    //autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        descripcionControler.text = grupo.Description;
                      } else {
                        descripcionControler.text = value;
                      }
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
                    //initialValue: grupo.password,
                    controller: claveControler,
                    //autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        claveControler.text = grupo.password;
                      } else {
                        claveControler.text = value;
                      }
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
                    _updateGroup(NombreControler.text,
                        descripcionControler.text, claveControler.text, grupo);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AjustesGrupoScreen(grupo: grupo),
                      ),
                    );
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

  void _updateGroup(
      String nombre, String descripcion, String clave, groupModel grupo) async {
    final updateGrupo = groupModel(
        id: grupo.id,
        idOwner: grupo.idOwner,
        OwnerName: grupo.OwnerName,
        Name: nombre.toString(),
        Description: descripcion.toString(),
        password: clave.toString());

    var result = await groupModel.updateGroup(updateGrupo);
    _clearAll();
  }

  void _clearAll() {
    NombreControler.text = '';
    descripcionControler.text = '';
    claveControler.text = '';
  }
}
