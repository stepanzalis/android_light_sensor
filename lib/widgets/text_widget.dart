import 'package:flutter/material.dart';
import 'package:light_sensor/light_bloc.dart';

class LightTextContainer extends StatelessWidget {

  final double lightValue;
  final LightBloc bloc;

  const LightTextContainer({
    @required this.lightValue,
    @required this.bloc,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Positioned(
          width: screenWidth,
          top: screenHeight / 2 - 50,
          child: Text("Light value from sensor",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.amber[600],
                  fontSize: 20,
                  fontFamily: DefaultTextStyle.of(context).style.fontFamily)),
        ),
        Positioned(
          top: screenHeight / 2,
          width: screenWidth,
          child: Text("$lightValue",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: _computeFontSize(lightValue),
                  fontFamily: DefaultTextStyle.of(context).style.fontFamily)),
        )
      ],
    );
  }

  _computeFontSize(double value) => value >= 40 ? 40.0 : value * 3;
}
