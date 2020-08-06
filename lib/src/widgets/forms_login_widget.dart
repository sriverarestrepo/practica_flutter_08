import 'package:flutter/material.dart';
import 'package:crud_practica/src/bloc/login_bloc.dart';
import 'package:crud_practica/src/bloc/provider.dart';

class FormsLoginWidget extends StatelessWidget {
  const FormsLoginWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
             height: size.height * 0.25,
            )
          ),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(5.0),
             boxShadow: <BoxShadow> [
               BoxShadow(
                 color: Colors.black26,
                 blurRadius: 3.0,
                 offset: Offset(1.0, 6.0),
                 spreadRadius: 3.0,
               )
             ]
           ),
           child: Column(
             children: <Widget>[
              Text(
                 'Ingreso',
                 style: TextStyle(
                  fontSize: 20.0,
                 ),
              ),
              SizedBox(height: 30.0),
              _crearEmail(bloc),
              SizedBox(height: 5.0),
              _crearPsw(bloc),
              SizedBox(height: 30.0),
              _crearBoton(bloc),
             ],
           ),
          ),

          Text('¿Olvidó la contraseña?'),
          SizedBox(height: 30.0),

        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.alternate_email,
                color: Colors.deepPurple,
              ),
              hintText: 'ejemplo@correo.com',
              labelText: 'Email',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearPsw(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,        
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock_outline ,
                color: Colors.deepPurple,
              ),
              labelText: 'Password',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
   
  }

 Widget _crearBoton(LoginBloc bloc) {

   return StreamBuilder(
     stream: bloc.formValidStream ,
     builder: (BuildContext context, AsyncSnapshot snapshot){
       return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Ingresar'),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.deepPurple,
        textColor: Colors.white,
        elevation: 0.0,
        onPressed: snapshot.hasData == true  ? () => _login(context, bloc) : null,
        );
     },
   );
 }

 _login(BuildContext context, LoginBloc bloc){
   Navigator.pushReplacementNamed(context, 'home');
 }

}