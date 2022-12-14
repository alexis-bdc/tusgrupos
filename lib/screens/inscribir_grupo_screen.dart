import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/menus.dart';

class InscribirGrupo extends StatelessWidget {
  const InscribirGrupo({super.key});

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
      body: SingleChildScrollView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: const [
                      ListTile(
                        title: Text('Nombre de Grupo'),
                        subtitle: Text('Descripción del Grupo'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  autofocus: true,
                  //initialValue: "Clave",
                  //obscureText: true,
                  //onChanged: (value) {
                  //  print('value: $value');
                  //},
                  validator: (value) {
                    if (value == null) return 'Campo requerido';
                    return value.length < 8
                        ? 'La clave es de 8 caracteres o más'
                        : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: 'Clave del grupo',
                    labelText: 'Clave',
                    icon: Icon(Icons.verified_user_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
