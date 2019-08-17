import 'package:flutter/material.dart';

class TextWidgetContainer extends StatelessWidget {

  final double luxValue;
  const TextWidgetContainer({@required this.luxValue});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.lerp(Colors.black, Colors.white, _computeColor(luxValue)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Center(child: Text("Lux value from sensor", style: TextStyle(color: Colors.grey[300], fontSize: 20))),
            SizedBox(height: 15),
            Center(
                child: Text("$luxValue",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: _computeFontSize(luxValue),
                        fontFamily: DefaultTextStyle.of(context).style.fontFamily)))
          ],
        ),
      );

  _computeFontSize(double value) => value >= 40 ? 40.0 : value * 3;

  _computeColor(double value) => value / 10;
}
