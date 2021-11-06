import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_art/router/app_router.dart';
import 'package:open_art/router/main_router.dart';
import 'package:open_art/shared/utils/palette.dart';
import 'package:open_art/shared/utils/utils.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';
import 'package:provider/provider.dart';
import 'core/locator/locator.dart';
import 'core/service_injector/service_injector.dart';
import 'core/services/auth/auth_service.dart';
import 'core/viewmodel/appTheme.dart';
import 'modules/auth/auth.dart';
import 'modules/auth/widgets/sign_in_up_bar.dart';
import 'modules/auth/wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
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

    super.initState();
  }

  Future<void> _init() async {
    await si.init();

    setState(() {
      _initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _init = Firebase.initializeApp();
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Column(
                    children: [Icon(Icons.error), Text("something went wrong")],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return ScreenUtilInit(
              designSize: Size(logicalWidth(), logicalHeight()),
              builder: () => MultiProvider(
                providers: allProviders,
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  // navigatorObservers: <NavigatorObserver>[
                  //   // this is used by the router package
                  //   AppRouter.router.navigatorObserver,
                  //
                  //   // RouterService.routeObserver,
                  //
                  //   // This we use in app to listen to route changes
                  //   RouteObserverProvider.of(context),
                  // ],
                  // navigatorKey: AppRouter.router.navigatorKey,
                  // onGenerateRoute: MainRouter.generateRoute,
                  home: AuthScreen(),
                ),
              ),
            );
            //   MultiProvider(
            //   providers: [
            //     ChangeNotifierProvider<AuthServices>.value(
            //         value: AuthServices()),
            //     ChangeNotifierProvider(create: (_) => AppThemeModel()),
            //   ],
            //   child: MaterialApp(
            //     debugShowCheckedModeBanner: false,
            //     theme: ThemeData(
            //       visualDensity: VisualDensity.adaptivePlatformDensity,
            //       accentColor: Palette.darkOrange,
            //       appBarTheme: const AppBarTheme(
            //         brightness: Brightness.dark,
            //         color: Palette.darkBlue,
            //       ),
            //     ),
            //     // navigatorObservers: <NavigatorObserver>[
            //     //   // this is used by the router package
            //     //   AppRouter.router.navigatorObserver,
            //     //
            //     //   // RouterService.routeObserver,
            //     //
            //     //   // This we use in app to listen to route changes
            //     //   RouteObserverProvider.of(context),
            //     // ],
            //     // navigatorKey: AppRouter.router.navigatorKey,
            //     // onGenerateRoute: MainRouter.generateRoute,
            //     home: AuthScreen(),
            //   ),
            // );
          } else {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: LoadingIndicator(isLoading: true),
                ),
              ),
            );
          }
        });

    // return ScreenUtilInit(
    //   designSize: Size(logicalWidth(), logicalHeight()),
    //   builder: () => MultiProvider(
    //     providers: allProviders,
    //     child: MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       // navigatorObservers: <NavigatorObserver>[
    //       //   // this is used by the router package
    //       //   AppRouter.router.navigatorObserver,
    //       //
    //       //   // RouterService.routeObserver,
    //       //
    //       //   // This we use in app to listen to route changes
    //       //   RouteObserverProvider.of(context),
    //       // ],
    //       // navigatorKey: AppRouter.router.navigatorKey,
    //       // onGenerateRoute: MainRouter.generateRoute,
    //       home: AuthScreen(),
    //     ),
    //   ),
    // );
  }
}
