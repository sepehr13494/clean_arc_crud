import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mc_crud_test/core/widgets/loading_widget.dart';
import 'package:mc_crud_test/features/crud/data/models/user_model.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';
import 'package:mc_crud_test/features/crud/presentation/models/create_user_obj.dart';
import 'package:mc_crud_test/features/crud/presentation/pages/add_edit_user.dart';

import '../bloc/user_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditUser(),
            ),
          );
        },
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context,state){
          if(state is WaitForResponse){
            EasyLoading.show();
          }else if(state is ResponseError){
            EasyLoading.dismiss();
            EasyLoading.showToast(state.message);
          }else if(state is SuccessfullyDoneState){
            EasyLoading.dismiss();
            EasyLoading.showToast(state.message);
            BlocProvider.of<UserBloc>(context).add(GetUsersEvent());
          }
        },
        buildWhen: (previous, current) {
          return (current is UsersLoading ||
              current is UsersLoaded ||
              current is UserError);
        },
        builder: (context, state) {
          print(state.toString());
          if (state is UsersLoading) {
            return const LoadingWidget();
          } else if (state is UserError) {
            print(state.message);
            return Padding(
              padding: const EdgeInsets.all(36),
              child: Center(
                child: Column(
                  children: [
                    Text(state.message,textAlign: TextAlign.center,),
                    const SizedBox(height: 24),
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<UserBloc>(context).add(GetUsersEvent());
                        },
                        icon: const Icon(Icons.refresh))
                  ],
                ),
              ),
            );
          } else if (state is UsersLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<UserBloc>(context).add(GetUsersEvent());
                return;
              },
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return state.users.isEmpty
                      ? const Center(
                          child: Padding(
                          padding: EdgeInsets.all(36),
                          child: Text("Empty"),
                        ))
                      : _userWidget(context,state.users[index]);
                },
                separatorBuilder: (context, _) => const Divider(),
                itemCount: state.users.isEmpty ? 1 : state.users.length,
              ),
            );
          } else {
            return ErrorWidget(state.toString());
          }
        },
      ),
    );
  }

  Widget _userWidget(BuildContext context,UserEntity userEntity) {
    return ListTile(
      leading: Text(userEntity.id.toString()),
      title: Text("${userEntity.firstname} ${userEntity.lastname}"),
      subtitle: Text(userEntity.phoneNumber),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: () {
            BlocProvider.of<UserBloc>(context).add(DeleteUserEvent(userModel: userEntity));
          }, icon: const Icon(Icons.delete)),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditUser(createUserObj: CreateUserObj.fromEntity(userEntity),isEdit: true),));
          }, icon: const Icon(Icons.edit)),
        ],
      ),
    );
  }
}
