import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_test/block_chat/pages/welcome/bloc/welcome_events.dart';
import 'package:learn_test/block_chat/pages/welcome/bloc/welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeState()) {
    on<WelcomeEvent>((event, emit) {
      print("state.page...${state.page}");
      emit(WelcomeState(page: state.page));
    });
  }
}