import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/group_list.dart';
import 'package:tusgrupos/screens/list_search.dart';
import 'package:tusgrupos/screens/menus.dart';

import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/group_model.dart';

import 'package:tusgrupos/screens/grupo_screen.dart';
import 'package:tusgrupos/screens/grupos_card.dart';
import 'package:tusgrupos/screens/small_groupCard.dart';

class BuscarGrupo extends StatefulWidget {
  const BuscarGrupo({super.key});

  @override
  _BuscarState2 createState() => _BuscarState2();
}

class _BuscarState extends State<BuscarGrupo> {
  // Widget? _ListaGrupos;
  var nameController = TextEditingController(text: '');
  var ownerController = TextEditingController(text: '');
  Widget? _child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 190, 173, 185),

      // backgroundColor: const Color.fromARGB(255, 201, 146, 183),
      //--------------------appbar--------------------
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 120, 58, 100),
        title: const Text('Buscar Grupo'),
      ),

      //--------------------body--------------------
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Nombre',
                        prefixIcon: const Icon(Icons.group),
                        prefixIconColor: const Color.fromARGB(255, 63, 3, 43),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // TextFormField(
                    //   controller: ownerController,
                    //   decoration: InputDecoration(
                    //     fillColor: Colors.grey.shade200,
                    //     filled: true,
                    //     hintText: 'Dueño',
                    //     prefixIcon: const Icon(Icons.person),
                    //     prefixIconColor: const Color.fromARGB(255, 63, 3, 43),
                    //     border: const OutlineInputBorder(
                    //       borderRadius: BorderRadius.all(Radius.circular(10)),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: const Color.fromARGB(255, 63, 3, 43),
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 100, vertical: 10),
                    //   ),
                    //   onPressed: () {
                    //     _child = ListSearch(nameController.toString(),
                    //         ownerController.toString());
                    //   },
                    //   child: const Text('Buscar'),
                    // ),
                  ],
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                //--------------------listview--------------------
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 181, 82, 155),
              // borderRadius: BorderRadius.circular(10),
            ),
            child: _child,
          )
        ],
      ),
    );
  }
}

class _BuscarState2 extends State {
  // TextEditingController searchField = TextEditingController(text: '');
  var _query = MongoDatabase.searchGroups('');

  // void updateList(String value) {
  //   _query = MongoDatabase.searchGroups(value);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 120, 58, 100),
        title: const Text('Buscar Grupo'),
      ),
      body: Column(
        children: [
          //  -------------------buscador-------------------
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  _query = MongoDatabase.searchGroups(value);
                });
              },
              // controller: searchField,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: 'busqueda',
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: const Color.fromARGB(255, 63, 3, 43),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          //  -------------------resultados-------------------

          Expanded(
            child: FutureBuilder(
                future: _query,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      var totalData = snapshot.data?.length;
                      return ListView.builder(
                        itemCount: totalData,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                          child: SmallGroupCard(
                            group: groupModel.fromJson(snapshot.data![index]),
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('No hay grupos'),
                      );
                    }
                  }
                }),
          )
        ],
      ),
    );
  }
}
