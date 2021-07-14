import 'package:flutix/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'bloc/blocs.dart';
import 'ui/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: AuthServices.userStream,
        child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => PageBloc()),
              BlocProvider(create: (_) => UserBloc()),
              BlocProvider(create: (_) => ThemeBloc())
            ],
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (_, themeState) => GetMaterialApp(
                  theme: themeState.themeData,
                  debugShowCheckedModeBanner: false,
                  home: Wrapper()),
            )));
  }
}
