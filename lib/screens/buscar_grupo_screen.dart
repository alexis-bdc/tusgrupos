// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/screens/small_groupCard.dart';

class BuscarGrupo extends StatefulWidget {
  const BuscarGrupo({super.key});

  @override
  _BuscarState2 createState() => _BuscarState2();
}

class _BuscarState2 extends State {
  // TextEditingController searchField = TextEditingController(text: '');
  var _query = groupModel.searchGroups('');

  // void updateList(String value) {
  //   _query = MongoDatabase.searchGroups(value);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 120, 58, 100),
        title: const Text('Buscar Grupo'),
        leading: const Icon(Icons.search),
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
                  _query = groupModel.searchGroups(value);
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
