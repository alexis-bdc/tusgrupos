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
        height: 300,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            _BackgroundImage(),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: _DetalleGrupo(grupo: grupo),
            ),
          ],
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
      height: 50,
      decoration: _DetalleGrupoDecoration(),
      child: Column(
        children: [
          Text(
            grupo.Name,
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            grupo.Description,
            style: const TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  BoxDecoration _DetalleGrupoDecoration() => const BoxDecoration(
      color: Color.fromARGB(255, 210, 154, 248),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)));
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 250,
        //decoration: _backgroundImageDecoration(),
        child: const FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(
              'https://i.kym-cdn.com/photos/images/facebook/002/471/150/78c'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

//No se está ocupando
BoxDecoration _backgroundImageDecoration() => BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    );

BoxDecoration _cardBorders() => BoxDecoration(
        color: Color.fromARGB(255, 210, 154, 248),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 7),
            blurRadius: 10,
          )
        ]);
