import 'package:flutter/material.dart';

final boxHeight = 50.0;
final boxWidth = 200.0;

class CustomGauge extends StatefulWidget {
  const CustomGauge({Key? key}) : super(key: key);

  @override
  _CustomGaugeState createState() => _CustomGaugeState();
}

class _CustomGaugeState extends State<CustomGauge> {
  double cursorPosition = 10;

  late ValueNotifier<double> notifier;
   @override
  void initState() {
    super.initState();
    notifier =ValueNotifier(cursorPosition);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (detail) { notifier.value = detail.localPosition.dx;},
      child: FittedBox(
        child: Container(
          color: Colors.grey,
          child: SizedBox(
            width: boxWidth,
            height: boxHeight,
            child: CustomPaint(
              painter: MyPainter(notifier),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final ValueNotifier<double> notifier;
  Path boxPath = Path();

  MyPainter(this.notifier): super(repaint: notifier);

  @override
  void paint(Canvas canvas, Size size) {
    final myPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    Path path = Path();

    boxPath.addRect(Rect.fromPoints(Offset.zero, Offset(boxWidth, boxHeight)));
    path.addRect(
        Rect.fromPoints(Offset.zero, Offset(notifier.value.clamp(0.0, boxWidth), boxHeight)));
    boxPath.close();
    canvas.drawPath(boxPath, myPaint);
    canvas.drawPath(path, Paint());
  }

  @override
  bool shouldRebuildSemantics(MyPainter oldDelegate) => true;

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return oldDelegate.notifier.value != notifier.value;
  }

  @override
  bool? hitTest(Offset position) {
    notifier.value = position.dx;
    return boxPath.contains(position);
  }
}
