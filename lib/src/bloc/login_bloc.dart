import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:crud_practica/src/bloc/validators.dart';

class LoginBloc with Validators{
  
  final _emailController = BehaviorSubject<String>();
  final _pswController = BehaviorSubject<String>();


  //Recuperar los datos del Stream
  Stream<String> get emailStream    => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _pswController.stream.transform(validarPassword);

  //Combinacion de Streams
  Stream<bool> get formValidStream => Rx.combineLatest2(emailStream, passwordStream, (es, ps) => true);

  //Insertar valores al Stream
  Function(String)  get changeEmail     => _emailController.sink.add;
  Function(String)  get changePassword  => _pswController.sink.add;

  dispose(){
    _emailController?.close();
    _pswController?.close();
  }

  //Obtener el ultimo valor ingresado en los streams

  String get email    => _emailController.value;
  String get password => _pswController.value;

}