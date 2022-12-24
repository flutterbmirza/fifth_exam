import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../data/repository/users_repo.dart';
import '../../data/service/api_service/api_service.dart';
import '../../view_models/users_viewmodel.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          UsersViewModel(
            usersRepository: UsersRepository(apiService: ApiService()),
          ),
      builder: (context, child) {
        var viewModel = context.watch<UsersViewModel>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Users'),
          ),
          body: viewModel.errorForUI.isNotEmpty
              ? Center(
            child: Text(viewModel.errorForUI),
          )
              : viewModel.isLoading? Center(
            child: CircularProgressIndicator(),
          )
              : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: viewModel.users!.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(viewModel.users[index].avatarUrl as String),
                        fit: BoxFit.cover),
                  ),
                ),
                title: Text(viewModel.users[index].username as String),
                subtitle: Text(viewModel.users[index].name as String),
              );
            },
          )
        );
      },
    );
  }

}