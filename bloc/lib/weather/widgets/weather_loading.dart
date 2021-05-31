


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('⛅', style: TextStyle(fontSize: 64)),
        Text(
          'Loading Weather',
        ),
        const Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator(),)
      ],
    );
  }
}
