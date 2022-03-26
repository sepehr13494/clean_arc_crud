import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';
import 'package:mc_crud_test/features/crud/presentation/bloc/user_bloc.dart';
import 'package:mc_crud_test/features/crud/presentation/pages/users_page.dart';
import 'package:mc_crud_test/injection_container.dart' as di;

import 'injection_container.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(UserEntityAdapter());
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<UserBloc>()..add(GetUsersEvent()))
        ],
        child: const UsersPage(),
      ),
    );
  }
}
