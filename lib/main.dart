import 'package:depois_do_ceu/business/bloc/login_cubit.dart';
import 'package:depois_do_ceu/business/bloc/message_detail_cubit.dart';
import 'package:depois_do_ceu/business/bloc/message_list_cubit.dart';
import 'package:depois_do_ceu/presentation/router/app_router.dart';
import 'package:depois_do_ceu/presentation/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business/bloc/recipient_detail_cubit.dart';
import 'business/bloc/recipient_list_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouter router = AppRouter();

    MessageDetailCubit messageDetailCubit = MessageDetailCubit();
    MessageListCubit messageCubit = MessageListCubit(messageDetailCubit);
    RecipientDetailCubit recipientDetailCubit = RecipientDetailCubit();
    RecipientListCubit recipientCubit = RecipientListCubit(recipientDetailCubit);
    LoginCubit loginCubit = LoginCubit(messageCubit, recipientCubit);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: messageCubit),
        BlocProvider.value(value: messageDetailCubit),
        BlocProvider.value(value: recipientDetailCubit),
        BlocProvider.value(value: recipientCubit),
        BlocProvider.value(value: loginCubit),
      ],
      child: MaterialApp(
        title: 'Depois do Céu',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: router.onGenerateRoute,
      ),
    );
  }
}
