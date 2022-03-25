import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState().init());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    }
  }

  Future<UserState> init() async {
    return state.clone();
  }
}
