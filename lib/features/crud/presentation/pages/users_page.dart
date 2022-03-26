import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_crud_test/core/widgets/loading_widget.dart';
import 'package:mc_crud_test/features/crud/data/models/user_model.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';
import 'package:mc_crud_test/features/crud/presentation/pages/add_edit_user.dart';
import 'package:mc_crud_test/injection_container.dart';

import '../bloc/user_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEditUser(),
              ));
        },
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial || state is UsersLoading) {
            return const LoadingWidget();
          }else if(state is UserError){
            return ErrorWidget(state.message);
          } else if(state is UsersLoaded){
            return ListView.separated(
              itemBuilder: (context, index) {
                return _userWidget(state.users[index]);
              },
              separatorBuilder: (context, _) => Divider(),
              itemCount: state.users.length,
            );
          }else{
            return ErrorWidget("something went wrong");
          }
        },
      ),
    );
  }

  Widget _userWidget(UserEntity userEntity) {
    return ListTile(
      title: Text("${userEntity.firstname} ${userEntity.lastname}"),
      subtitle: Text(userEntity.phoneNumber),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
        ],
      ),
    );
  }
}
