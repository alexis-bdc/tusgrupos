import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/buscar_grupo_screen.dart';
import 'package:tusgrupos/screens/crear_grupo_screen.dart';
// import 'package:tusgrupos/screens/menus.dart';
// import 'package:tusgrupos/screens/participacion_grupo_screen.dart';
import 'package:tusgrupos/screens/ver_mis_grupos_screen.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  // const Landing({super.key});
  Widget? _child;

  @override
  void initState() {
    super.initState();
    _child = VerMisGrupos();
  }

  @override
  Widget build(BuildContext context) {
    //todo: define text style and colors

    return Scaffold(
      //--------------------body--------------------
      body: _child,

      //--------------------bottom navigation bar--------------------
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(
              icon: Icons.group_add,
              backgroundColor: Colors.pink[100],
              extras: {"label": "Crear"}),
          FluidNavBarIcon(
              icon: Icons.group,
              backgroundColor: Colors.pink[100],
              extras: {"label": "Mis Grupos"}),
          FluidNavBarIcon(
              icon: Icons.search,
              backgroundColor: Colors.pink[100],
              extras: {"label": "Buscar"}),
        ],
        onChange: _handleNavigationChange,
        style: const FluidNavBarStyle(
            // barBackgroundColor: Colors.deepPurpleAccent,
            // iconBackgroundColor: Colors.pink,
            iconSelectedForegroundColor: Color.fromARGB(255, 63, 3, 43),
            iconUnselectedForegroundColor: Colors.grey),
        scaleFactor: 1.5,
        // defaultIndex: 0,
        itemBuilder: (icon, item) => Semantics(
          label: icon.extras!["label"],
          child: item,
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = CreateGroup();
          break;
        case 1:
          _child = VerMisGrupos();
          break;
        case 2:
          _child = BuscarGrupo();
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
