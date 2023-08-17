import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_bloc/login_bloc.dart';
import 'login_bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    _loginBloc.close();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: BlocProvider(
        create: (context) => _loginBloc,
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              CircularProgressIndicator();
            } else if (state is LoginSuccess) {
              // Handle successful login
              const snackBar = SnackBar(content: Text("Success"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is LoginFailure) {
              // Handle login failure
              final snackBar = SnackBar(content: Text(state.error));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      _loginBloc.add(
                        LoginButtonPressed(
                          username: _usernameController.text,
                          password: _passwordController.text,
                        ),
                      );
                    },
                    child: Text('Login'),
                  ),
                  if (state is LoginLoading) SizedBox(height: 20.0),
                  if (state is LoginLoading) CircularProgressIndicator(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
