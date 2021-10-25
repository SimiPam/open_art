import 'package:open_art/core/services/api_service.dart';
import 'package:open_art/core/services/auth_service.dart';
import 'package:open_art/core/services/color_service.dart';
import 'package:open_art/core/services/layout_service.dart';
import 'package:open_art/core/services/router_service.dart';
import 'package:open_art/core/services/storage_service.dart';
import 'package:open_art/core/services/store_service.dart';
import 'package:open_art/core/services/user_service.dart';

class Injector {
  StoreService storeService = StoreService();
  StorageService storageService = StorageService();
  LayoutService layoutService = LayoutService();
  RouterService routerService = RouterService();
  ApiService apiService;
  AuthService authService;
  ColorService colorService;
  UserService userService;
  Future<bool> init() async {
    // init storage service
    await storageService.initStorage();

    apiService = ApiService(storeService);
    // color and theme service
    colorService = ColorService(storageService);
    authService = AuthService(
      storageService: storageService,
      storeService: storeService,
    );
    userService = UserService(
      storageService: storageService,
      apiService: apiService,
    );

    return true;
  }
}

Injector si = Injector();
