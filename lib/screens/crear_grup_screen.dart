import 'package:flutter/material.dart';
import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/models/user_model.dart';
import 'package:tusgrupos/screens/home_screen.dart';
import 'package:tusgrupos/screens/menu_drawer.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);
  // final userModel user;
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  @override
  final _formkey = GlobalKey<FormState>();
  var NombreControler = TextEditingController();
  var descripcionControler = TextEditingController();
  var claveControler = TextEditingController();

  Widget build(BuildContext context) {
    // TODO: crear grupo screen

    return Scaffold(
      //--------------------appbar--------------------
      appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text("Crear Grupo"),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              //todo: conectar a buscar grupo
              onPressed: () {},
              icon: const Icon(Icons.search),
              tooltip: 'buscar grupos',
            ),
          ]),

      //--------------------drawer--------------------
      drawer: const MenuDrawer(),

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
                  TextFormField(
                    controller: NombreControler,
                    decoration: const InputDecoration(
                      hintText: 'Nombre del grupo',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un nombre';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: descripcionControler,
                    decoration: const InputDecoration(
                      hintText: 'Descripcion del grupo',
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
                  TextFormField(
                    controller: claveControler,
                    decoration: const InputDecoration(
                      hintText: 'Clave del grupo',
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
          ],
        ),
      ),
      //--------------------BottomNavigationBar------------------------------
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Confirmar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            label: 'Cancelar',
          )
        ],
        currentIndex: 0,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.red,
        onTap: (index) {
          if (index == 0) {
            _insertGroup(NombreControler.text, descripcionControler.text,
                claveControler.text);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          } else if (index == 1) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          }
        },
      ),
    );
  }

  void _insertGroup(String nombre, String descripcion, String clave) async {
    var _id = M.ObjectId();
    // var userid = widget.user.id;
    final group = groupModel(
        id: _id, Name: nombre, Description: descripcion, password: clave);

    var result = await MongoDatabase.insertGroup(group);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nuevo Usuario'),
      ),
    );
    _clearAll();
  }

  void _clearAll() {
    NombreControler.text = '';
    descripcionControler.text = '';
    claveControler.text = '';
  }
}
