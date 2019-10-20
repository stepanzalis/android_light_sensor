import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:light_sensor/light_bloc.dart';
import 'package:light_sensor/utils/constants.dart';
import 'package:light_sensor/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription _lightSubscription;
  final streamChannel = const EventChannel(PLATFORM_CHANNEL);

  @override
  Widget build(BuildContext context) {
    final _lightBloc = Provider.of<LightBloc>(context);

    return Scaffold(
        body: StreamBuilder<double>(
            initialData: _lightBloc.lightValue,
            stream: _lightBloc.lightStream,
            builder: (context, snapshot) => Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Color.lerp(Colors.black, Colors.white, _computeColor(snapshot.data)),
                  child: LightTextContainer(value: snapshot.data),
                )));
  }

  _setLightValue(double value, LightBloc _lightBloc) => _lightBloc.lightSink.add(value);

  _computeColor(double value) => value / 10;

  @override
  void initState() {
    super.initState();
    _lightSubscription =
        streamChannel.receiveBroadcastStream().listen((data) => _setLightValue(data, Provider.of<LightBloc>(context)));
  }

  @override
  void dispose() {
    super.dispose();
    _lightSubscription.cancel();
  }
}
