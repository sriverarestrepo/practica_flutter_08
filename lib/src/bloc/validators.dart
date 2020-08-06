import 'dart:async';

class Validators {
  
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: ( psw , sink) {
      if( psw.length >= 6){
        sink.add(psw);
      }else{
        sink.addError('Debes ingresar 6 o más caracteres por favor.');
      }
    }
  );

   final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: ( email , sink) {
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if(regExp.hasMatch(email)){
        sink.add(email);
      }else{
         sink.addError('Email no es correcto.');
      }
    }
  );

}