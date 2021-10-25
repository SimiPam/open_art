import 'package:open_art/core/viewmodel/appTheme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

///multi-providers as a single child widget
final allProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => AppThemeModel()),
];
