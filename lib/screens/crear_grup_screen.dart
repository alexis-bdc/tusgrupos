
import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/home_screen.dart';

class CreateGroup extends StatelessWidget {
  const CreateGroup({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: crear grupo screen

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("Crear Grupo"),
        leading: GestureDetector( //todo: conectar a buscar grupos
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen())
            );
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container( //todo: implementar cuadros de registro
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.orange,
              borderRadius: BorderRadius.circular(15.0),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(50.0),
            margin: const EdgeInsets.all(20.0),
            child: const Text("titulo")
          ),


          Container( //todo: implementar cuadro de registro descripcion
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.orange,
                borderRadius: BorderRadius.circular(15.0),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(160.0),
              margin: const EdgeInsets.all(20.0),
              child: const Text("Descripcion")
          ),



        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {  },
        elevation: 10,
        child: const Icon(Icons.add_circle_outline),
      ),

    );
  }

}