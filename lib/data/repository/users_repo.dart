
import '../model/response.dart';
import '../service/api_service/api_service.dart';

class UsersRepository {
  ApiService apiService;
  UsersRepository({required this.apiService});

  Future<MyResponse> getAllUsers() => apiService.getAllUsers();
}