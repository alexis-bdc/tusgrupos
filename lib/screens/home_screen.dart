import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/crear_grup_screen.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //todo: define text style and colors
    


    // TODO: implement build home screen scaffold
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text("Pagina Principal"),
          leading: GestureDetector( //todo: conectar a buscar grupos
            onTap: () {},
            child: const Icon(Icons.search),
          ),
        ),
        body:
          Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[ //todo: conectar a lista de grupos participante

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton( //todo: conectar a crear grupos
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreateGroup())
            );
          },
          child: const Icon(Icons.add)
        )
        ); 
  }
}
