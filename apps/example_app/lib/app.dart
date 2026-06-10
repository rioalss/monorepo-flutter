import 'package:core_l10n/core_l10n.dart';
import 'package:core_state/core_state.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ExampleApp extends StatelessWidget {
  const ExampleApp({required this.router, super.key});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale?>(
      builder: (context, locale) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp.router(
              title: 'Example App',
              locale: locale,
              localizationsDelegates:
                  AppLocalizationsConfig.localizationsDelegates,
              supportedLocales: AppLocalizationsConfig.supportedLocales,
              localeResolutionCallback:
                  AppLocalizationsConfig.localeResolutionCallback,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeMode,
              routerConfig: router,
            );
          },
        );
      },
    );
  }
}
