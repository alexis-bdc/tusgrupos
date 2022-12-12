import 'package:flutter/material.dart';
import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/group_model.dart';

class GruposCard extends StatelessWidget {
  final groupModel grupo;

  const GruposCard({Key? key, required this.grupo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [_BackgroundImage(), _DetalleGrupo(grupo: grupo)],
        ),
      ),
    );
  }
}

class _DetalleGrupo extends StatelessWidget {
  final groupModel grupo;

  const _DetalleGrupo({Key? key, required this.grupo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: _DetalleGrupoDecoration(),
      child: Column(
        children: [
          Text(
            '${grupo.Name}',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${grupo.Description}',
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  BoxDecoration _DetalleGrupoDecoration() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)));
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      child: FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(
            'https://i.kym-cdn.com/photos/images/facebook/002/471/150/78c'),
      ),
    );
  }
}

BoxDecoration _cardBorders() => BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 7),
            blurRadius: 10,
          )
        ]);
