import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/home_screen.dart';
import 'package:tusgrupos/screens/menu_drawer.dart';

class ResponderHilo extends StatelessWidget {
  const ResponderHilo({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: crear grupo screen

    return Scaffold(
      //--------------------appbar--------------------
      appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text("Responder Hilo"),
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
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Card(
                  child: Column(
                    children: const [
                      ListTile(
                        title: Text('Nombre del Hilo'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  autofocus: true,
                  //initialValue: "Clave",
                  //obscureText: true,
                  onChanged: (value) {
                    print('value: $value');
                  },
                  validator: (value) {
                    if (value == null) return 'Campo requerido';
                    return value.length < 8 ? 'Ingresar título' : null;
                  },
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
              ],
            )),
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
