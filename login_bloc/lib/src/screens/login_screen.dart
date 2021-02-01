import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import '../blocs/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: [
          emailField(bloc),
          Container(margin: EdgeInsets.only(top: 15.0)),
          passwordField(bloc),
          Container(margin: EdgeInsets.only(top: 25.0)),
          submitButton(bloc),
        ],
      ),
    );
  }
}

Widget emailField(Bloc bloc) {
  return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "email@example.com",
            labelText: "Email",
            errorText: snapshot.error,
          ),
          onChanged: bloc.changeEmail,
        );
      });
}

Widget passwordField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.password,
    builder: (context, snapshot) {
      return TextField(
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Password",
          labelText: "Password",
          errorText: snapshot.error,
        ),
        onChanged: bloc.changePassword,
      );
    },
  );
}

Widget submitButton(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.submitValid,
    builder: (context, snapshot) {
      return RaisedButton(
        child: Text("Login"),
        color: Colors.green,
        textColor: Colors.white,
        onPressed: snapshot.hasError || !snapshot.hasData
            ? null
            : () {
                bloc.submit();
              },
      );
    },
  );
}
