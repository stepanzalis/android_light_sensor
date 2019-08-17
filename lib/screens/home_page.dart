import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:light_sensor/light_bloc.dart';
import 'package:light_sensor/utils/constants.dart';
import 'package:light_sensor/widgets/text_widget.dart';

class HomePage extends StatefulWidget {

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  StreamSubscription _lightSubscription;

  final _lightBloc = LightBloc();
  final streamChannel = const EventChannel(PLATFORM_CHANNEL);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<double>(
            initialData: _lightBloc.lightValue,
            stream: _lightBloc.lightStream,
            builder: (context, snapshot) => TextWidgetContainer(luxValue: snapshot.data)));
  }

  _setLightValue(double value) async => _lightBloc.lightSink.add(value);

  @override
  void initState() {
    super.initState();
    _lightSubscription = streamChannel.receiveBroadcastStream().listen((data) => _setLightValue(data));
  }

  @override
  void dispose() {
    super.dispose();
    _lightBloc.cancel();
    _lightSubscription.cancel();
  }
}
