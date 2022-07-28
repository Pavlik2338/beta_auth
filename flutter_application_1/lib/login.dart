import 'package:flutter_application_1/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/auth_bloc.dart';
import 'package:flutter_application_1/bloc/auth_state.dart';
import 'package:flutter_application_1/infopage.dart';
import 'package:flutter_application_1/userReg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<FormState> loginkey = GlobalKey<FormState>();
final GlobalKey<FormState> passwordkey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget {
  final TextEditingController loginController = TextEditingController();
  late AuthBloc bloc;

  final TextEditingController passwordController = TextEditingController();
  void signIn() {
    bloc.add(SignInEvent(
        email: loginController.text, password: passwordController.text));
  }

  void signUp() {
    bloc.add(SignUpEvent(
        email: loginController.text, password: passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<AuthBloc>(context);
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => InfoPage()));
        },
        child: (Icon(Icons.mail)

            // text() : Text('Доп Инфа', style: TextStyle(fontSize: 15),)
            ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthInitial) {
            if (state is StateError) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorText)));
            }
            if (state.success) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Pagereg(name: loginController.text)));
            }
          }
        }, builder: (context, state) {
          if (state is AuthInitial) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text("Авторизация",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20))),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormIn.login(loginController, loginkey),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormIn.password(passwordController, passwordkey),
                  ),
                  SignButton.enter(action: signIn),
                  SignButton.reg(action: signUp),
                ]);
          }
          if (state is LoadingState) {
            return Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text('Загрузка'),
                ],
              ),
            );
          }
          return LoginPage();
        }),
      ),
    ));
  }
}

class SignButton extends StatelessWidget {
  final VoidCallback action;
  final String textCaption;
//CallbackAction
  // ignore: use_key_in_widget_constructors
  const SignButton.enter({Key? key, required this.action})
      : textCaption = "Войти";
  // ignore: use_key_in_widget_constructors
  const SignButton.reg({Key? key, required this.action})
      : textCaption = "Зарегестрироваться";

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: action,
        splashColor: Colors.blue,
        // highlightColor: Theme.of(context).primaryColor,
        color: Colors.yellow,
        child: Text(textCaption,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20)));
  }
}

class FormIn extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) validator;
  final String hint;
  final IconData icon;
  bool obscure = false;
  final GlobalKey<FormState> key1;
  FormIn.login(this.controller, this.key1)
      : hint = 'логин ',
        icon = Icons.person,
        validator = loginvalid;
  FormIn.password(this.controller, this.key1)
      : obscure = true,
        hint = 'Пароль ',
        icon = Icons.vpn_key,
        validator = passwordvalid;
  static loginvalid(value) {
    if (value.length < 2) return ' логин слишком короткий!';
    return null;
  }

  static passwordvalid(value) {
    if (value.length < 2) return "пароль слишком короткий!";
    if (!value.contains(RegExp(r'[a-zA-Zа-яА-Я]')))
      return "пароль должен содержать букву";
    return null;
  }

  // класс для полей логин и пароль
  @override
  Widget build(BuildContext context) {
    return Form(
        key: key1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          //validator: validator;
          obscureText: obscure,
          controller: controller,
          decoration: InputDecoration(
              filled: true, //залитие
              fillColor: Colors.yellow, //цвет залития
              hintText: hint, //надпись
              prefixIcon: Icon(icon), //иконка
              border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(20))), //форма текстового поля
        ));
  }
}
