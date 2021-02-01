import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

// class Bloc extends Object with Validators
class Bloc with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Getters - add data to stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);

  // Setters - change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;
    print('$validEmail logged in sucessful');
  }

  // close streams
  dispose() {
    _email.close();
    _password.close();
  }
}
