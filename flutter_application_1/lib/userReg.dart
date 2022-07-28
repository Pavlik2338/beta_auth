import 'package:flutter/material.dart';

final TextEditingController loginController = TextEditingController();

final TextEditingController dataController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class Pagereg extends StatelessWidget {
  final String name;
  Pagereg({required this.name});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: (Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text("Зарегестрируйтесь!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20))),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormUp.email(loginController),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormUp.password(passwordController),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormUp.data(dataController),
                      ),
                    ])))));
  }
}

class FormUp extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  FormUp.email(this.controller) : hint = 'Email';

  FormUp.password(this.controller) : hint = 'Пароль ';
  FormUp.data(this.controller) : hint = 'Дата рождения ';

  Widget build(BuildContext context) {
    return Form(
        child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
          filled: true, //залитие
          fillColor: Colors.yellow, //цвет залития
          hintText: hint, //надпись

          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20))), //форма текстового поля
    ));
  }
}
