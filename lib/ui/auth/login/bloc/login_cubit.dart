import 'package:fluter_app/ui/auth/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void login(String email, String password) {
    print('email: $email, password: $password');
  }
}
