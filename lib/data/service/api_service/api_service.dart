import 'package:dio/dio.dart';
import '../../model/response.dart';
import '../../model/user_model.dart';
import 'api_client.dart';

class ApiService extends ApiClient {
  Future<MyResponse> getAllUsers() async {
    MyResponse myResponse = MyResponse(error: "");
    try {
      Response response = await dio.get("${dio.options.baseUrl}/users");
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        myResponse.data = (response.data as List?)
            ?.map((e) => UsersModel.fromJson(e))
            .toList() ??
            [];
      }
    } catch (err) {
      myResponse.error = err.toString();
    }

    return myResponse;
  }
}