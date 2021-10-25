import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_art/modules/home_module/home.dart';
import 'package:open_art/router/app_router.dart';
import 'package:open_art/router/main_router.dart';
import 'package:open_art/shared/utils/utils.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';
import 'package:provider/provider.dart';
import 'core/locator/locator.dart';
import 'core/service_injector/service_injector.dart';
import 'modules/auth/login_first_user.dart';

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
//     return ScreenUtilInit(
//       designSize: Size(375, 812),
//       builder: () => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.green,
//           textTheme: TextTheme(
//               //To support the following, you need to use the first initialization method
//               button: TextStyle(fontSize: 45.sp)),
//         ),
//         home: Home(),
//       ),
//     );
//   }
// }

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(RouteObserverProvider(
    child: const MyApp(
      appKey: ValueKey<String>('root'),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({this.appKey}) : super(key: appKey);
  final ValueKey<String> appKey;

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _splashDone = false;
  @override
  void initState() {
    _init();
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarBrightness: Brightness.dark,
    //     statusBarColor: Colors.black,
    //     systemNavigationBarColor: Colors.black,
    //   ),
    // );

    // // The preferred screen orientation
    // SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]).then((_) {});

    super.initState();

    BackButtonInterceptor.add(_myInterceptor);
  }

  bool _myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    // if (si.routerService.routeStack().length > 0) {
    //   si.routerService.popStack();
    // } else {
    //   si.routerService.pop();
    // }

    return true;
  }

  Future<void> _init() async {
    await si.init();

    setState(() {
      _initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: Size(logicalWidth(), logicalHeight()),
      builder: () => MultiProvider(
        providers: allProviders,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              //   primarySwatch: Colors.green,
              //   textTheme: TextTheme(
              //       //To support the following, you need to use the first initialization method
              //       button: TextStyle(fontSize: 45.sp)),
              ),
          navigatorObservers: <NavigatorObserver>[
            // this is used by the router package
            AppRouter.router.navigatorObserver,

            // RouterService.routeObserver,

            // This we use in app to listen to route changes
            RouteObserverProvider.of(context),
          ],
          navigatorKey: AppRouter.router.navigatorKey,
          onGenerateRoute: MainRouter.generateRoute,
          home: Home(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(_myInterceptor);

    super.dispose();
  }
}
