import 'package:open_art/core/services/auth/auth_service.dart';
import 'package:open_art/core/viewmodel/appTheme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

///multi-providers as a single child widget
final allProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => AppThemeModel()),
  // ChangeNotifierProvider(create: (_) => AppThemeModel()),
  // ChangeNotifierProvider(create: (_) => AuthServices()),
  ChangeNotifierProvider<AuthServices>.value(value: AuthServices())
];
