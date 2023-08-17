

import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

// BLoC
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        // Simulate an API call for login
        await Future.delayed(Duration(seconds: 2));
        // Add your login logic here

        yield LoginSuccess();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}