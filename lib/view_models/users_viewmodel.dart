import 'package:flutter/cupertino.dart';
import '../data/model/response.dart';
import '../data/model/user_model.dart';
import '../data/repository/users_repo.dart';

class UsersViewModel extends ChangeNotifier {
  UsersRepository usersRepository;
  UsersViewModel({required this.usersRepository}) {
    fetchUserInfo();
  }

  bool isLoading = false;
  List<UsersModel> users = [];
  String errorForUI = "";

  fetchUserInfo() async {
    notify(true);
    MyResponse myResponse = await usersRepository.getAllUsers();
    if (myResponse.error.isEmpty) {
      users = myResponse.data as List<UsersModel>;
    } else {
      errorForUI = myResponse.error;
    }
    notify(false);
  }
  notify(bool v) {
    isLoading = v;
    notifyListeners();
  }
}