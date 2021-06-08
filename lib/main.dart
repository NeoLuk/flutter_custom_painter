import 'package:custom_painter/custom_gauge.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  return runApp(GaugeApp());
}

/// Represents the GaugeApp class
class GaugeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radial Gauge Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

/// Represents MyHomePage class
class MyHomePage extends StatefulWidget {
  /// Creates the instance of MyHomePage
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _getGauge({bool isRadialGauge = false}) {
    if (isRadialGauge) {
      return _getRadialGauge();
    } else {
      return _getCustomGauge();
    }
  }

  double _volumeValue = 50;

  void onVolumeChanged(double value) {
    setState(() {
      _volumeValue = value;
    });
  }

  Widget _getRadialGauge() {
    return SfRadialGauge(
        title: GaugeTitle(
            text: 'Speedometer',
            textStyle:
                const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        axes: <RadialAxis>[
          RadialAxis(
              minimum: 0,
              maximum: 100,
              showLabels: false,
              showTicks: false,
              labelOffset: -20,
              tickOffset: -10,
              startAngle: 110,
              endAngle: 70,
              axisLineStyle: AxisLineStyle(
                  cornerStyle: CornerStyle.bothFlat,
                  color: Colors.black12,
                  thickness: 100),
              pointers: <GaugePointer>[
                MarkerPointer(
                    markerType: MarkerType.rectangle,
                    markerWidth: 100,
                    value: _volumeValue,
                    color: Colors.yellow,
                    onValueChanged: onVolumeChanged,
                    borderWidth: 1,
                    borderColor: Colors.black,
                    overlayColor: Colors.transparent,
                    enableDragging: true),
                RangePointer(
                  value: _volumeValue,
                  color: Colors.yellow,
                  cornerStyle: CornerStyle.bothFlat,
                  width: 100,
                  sizeUnit: GaugeSizeUnit.logicalPixel,
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Container(
                        child: Text(_volumeValue.toInt().toString(),
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold))),
                    angle: 90)
              ])
        ]);
  }

  Widget _getCustomGauge() {
    return Center(child: CustomGauge());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Syncfusion Flutter Gauge')),
        body: _getGauge());
  }
}
