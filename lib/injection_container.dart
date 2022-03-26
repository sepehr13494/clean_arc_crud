import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mc_crud_test/core/util/input_validator.dart';
import 'package:mc_crud_test/features/crud/data/data_sources/user_local_data_source.dart';
import 'package:mc_crud_test/features/crud/data/repositories/user_repository_impl.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/create_user.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/delete_user.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/edit_user.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/get_users.dart';
import 'package:mc_crud_test/features/crud/presentation/bloc/user_bloc.dart';

import 'features/crud/domain/repositories/user_repository.dart';

final sl = GetIt.instance;

Future<void> init() async{
  initFeatures();
  initCore();
  await initExternal();
}

void initFeatures() {
  //bloc
  sl.registerFactory(
    () => UserBloc(
      createUser: sl(),
      editUser: sl(),
      deleteUser: sl(),
      getUsers: sl(),
      inputValidator: sl(),
    ),
  );

  //useCases
  sl.registerLazySingleton(() => CreateUserUseCase(sl()));
  sl.registerLazySingleton(() => EditUserUseCase(sl()));
  sl.registerLazySingleton(() => DeleteUserUseCase(sl()));
  sl.registerLazySingleton(() => GetUsersUseCase(sl()));
  
  //repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(userLocalDataSource: sl()));
  
  //dataSource
  sl.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSourceImpl(box: sl()));
}

void initCore() {
  sl.registerLazySingleton<InputValidator>(() => InputValidatorImpl(phoneNumberManager: sl(), emailManager: sl()));
  sl.registerLazySingleton(() => PhoneNumberManager());
  sl.registerLazySingleton(() => EmailManager());
}

Future<void> initExternal() async {
  final Box box = await Hive.openBox("user");
  sl.registerLazySingleton<Box>(() => box);
}
