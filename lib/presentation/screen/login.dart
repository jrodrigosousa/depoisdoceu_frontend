import 'package:depois_do_ceu/business/bloc/login_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Login extends StatelessWidget {
  TextEditingController usernameController = TextEditingController(
      text: kDebugMode ? "rodrigo" : "");
  TextEditingController passwordController = TextEditingController(
      text: kDebugMode ? "teste" : "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Color(0xFF1D3557),
      ),
      body: ScaffoldMessenger(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                    labelText: "Usuário",
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Senha",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return ElevatedButton.icon(
                    onPressed: (state is LoginLoading)? null : () => login(context),
                    label: Text("Entrar"),
                    icon: (state is LoginLoading) ? CircularProgressIndicator() : Icon(Icons.login),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF1D3557),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  login(context) async {
    print("iniciando processo de login");
    bool loggedIn = await BlocProvider.of<LoginCubit>(context)
        .login(usernameController.text, passwordController.text);
    if (loggedIn) {
      print("logado...");
      Navigator.of(context).pushReplacementNamed("/home");
    }
  }
}