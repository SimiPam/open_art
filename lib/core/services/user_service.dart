import 'package:open_art/core/services/api_service.dart';
import 'package:open_art/core/services/storage_service.dart';
import 'package:open_art/shared/models/api_model.dart';
import 'package:open_art/shared/models/user_model.dart';

class UserService {
  UserService({
    this.storageService,
    this.apiService,
  });

  StorageService storageService;
  ApiService apiService;

  Stream<ApiResponse<User>> getCurrentUser() {
    return apiService.getApiStoreData(
      'users/whoami',
      transform: (dynamic res) {
        return User.fromJson(res);
      },
    );
  }

  Future<ApiResponse<dynamic>> updateUser(
      User user, Map<String, String> body) async {
    final ApiResponse<dynamic> res = await apiService.putApi<dynamic>(
      'users/id/${user.id}',
      body,
      transform: (dynamic res) => res,
    );

    if (!res.error) {
      // update store
      getCurrentUser();
    }

    print('Saving user update here');

    return res;
  }
}
