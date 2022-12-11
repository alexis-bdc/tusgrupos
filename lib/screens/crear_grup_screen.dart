import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/home_screen.dart';
import 'package:tusgrupos/screens/menu_drawer.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final _formKey = GlobalKey<FormState>();
  var NombreControler = TextEditingController();
  var descripcionControler = TextEditingController();
  var claveControler = TextEditingController();

  @override
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
      body: const GroupForm(),
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
}

class GroupForm extends StatefulWidget {
  const GroupForm({Key? key}) : super(key: key);

  @override
  _GroupFormState createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
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
            decoration: const InputDecoration(
              hintText: 'Descripcion del grupo',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una descripcion';
              }
              return null;
            },
            minLines: 3,
            maxLines: 6,
          ),
          TextFormField(
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
    );
  }
}
