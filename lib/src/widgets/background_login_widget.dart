import 'package:flutter/material.dart';

class BackgroundLoginWidget extends StatelessWidget {
  const BackgroundLoginWidget({
    Key key, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
        children: <Widget>[
          _crearFondo(context),
          Positioned(
            top: 90.0,
            left: 30.0,
            child: _crearCirculoDecorativo(100.0),
          ),
          Positioned(
            top: -40,
            right: -20,
            child: _crearCirculoDecorativo(150.0),
          ),
          Positioned(
            bottom: -50,
            right: -10,
            child: _crearCirculoDecorativo(200.0),
          ),
          _crearTitulo(),
        ],
    );
  }

  Widget _crearFondo(BuildContext context){
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        
        ),
      ),
    );
  }

  Widget _crearCirculoDecorativo(double size){
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size),
        color: Color.fromRGBO(255, 255, 255, 0.04)
      ),
    );
  }

  Widget _crearTitulo(){

    return Container(
      padding: EdgeInsets.only(top:80.0),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.person_pin_circle, 
            color: Colors.white,
            size: 120.0,
          ),
          SizedBox(height: 10.0,width: double.infinity),
          Text(
            'Santiago Rivera R',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}