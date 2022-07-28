import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login.dart';

void main() => runApp(MyApp());
void initApp() async {}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Test Prog',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider(
          create: (context) => AuthBloc(),
          child: LoginPage(),
        ));
  }
}
