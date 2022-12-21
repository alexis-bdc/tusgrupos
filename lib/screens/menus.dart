import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/grupos_inscritos.dart';
import 'package:tusgrupos/screens/login_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            curve: Curves.easeIn,
            child: Text('profile picture'),
          ),
          ListTile(
            title: Text('Mis Grupos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GruposInscritos()),
              );
            },
          ),
          ListTile(
            title: Text('Grupos Creados'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Cerrar Sesion'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          // ListTile(
          //   title: Text('Acerca de'),
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
}
