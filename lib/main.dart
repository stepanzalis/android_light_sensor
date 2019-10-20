import 'package:flutter/material.dart';
import 'package:light_sensor/screens/home_page.dart';
import 'package:provider/provider.dart';

import 'light_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Provider<LightBloc>(
            builder: (context) => LightBloc(),
            dispose: (context, bloc) => bloc.cancel(),
            child: HomePage()
        )
    );
  }
}

