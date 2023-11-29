import 'package:bloc/bloc.dart';
import 'package:depois_do_ceu/business/bloc/recipient_list_cubit.dart';
import 'package:depois_do_ceu/business/exception/unauthorized_login_exception.dart';
import 'package:depois_do_ceu/business/security.dart';
import 'package:depois_do_ceu/data/provider/login_provider.dart';
import 'package:meta/meta.dart';

import 'message_list_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  late MessageListCubit messageCubit;
  late RecipientListCubit recipientCubit;

  LoginCubit(this.messageCubit, this.recipientCubit): super(LoggedOut());

  Future<bool> login(String username, String password) async {
    emit(LoginLoading());

    String jwt = "";
    try {
      LoginProvider loginProvider = LoginProvider();
      jwt = await loginProvider.login(username, password);
    }
    on UnauthorizedLoginException catch (e){
      //todo: tratar o caso de erro de login
      print(e);
      emit(LoggedOut());
      return false;
    }
    on Exception catch (e){
      print(e);
      emit(LoggedOut());
      return false;
    }

    Security.setLoginData(jwt);
    messageCubit.refresh();
    recipientCubit.refresh();
    emit(LoggedIn(jwt));
    return true;
  }
}
