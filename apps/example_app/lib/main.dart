import 'package:core_state/core_state.dart';
import 'package:example_app/app.dart';
import 'package:example_app/bootstrap/app_bootstrap.dart';
import 'package:example_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  await bootstrapApp();

  final sessionCubit = getIt<SessionCubit>();
  final themeCubit = getIt<ThemeCubit>()..load();
  final localeCubit = getIt<LocaleCubit>()..load();
  final router = createAppRouter(sessionCubit: sessionCubit);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sessionCubit),
        BlocProvider.value(value: themeCubit),
        BlocProvider.value(value: localeCubit),
      ],
      child: ExampleApp(router: router),
    ),
  );
}
