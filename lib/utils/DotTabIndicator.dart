import 'package:flutter/material.dart';

const kDefaultDotIndicatorRadius = 3.0;

class DotTabIndicator extends Decoration {
  const DotTabIndicator({required this.indicatorColor, this.radius = kDefaultDotIndicatorRadius});

  final Color indicatorColor;
  final double radius;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    throw UnimplementedError();
  }

 /* @override
  BoxPainter createBoxPainter([onChanged]) {
    return _DotPainter(this, onChanged);
  }*/
}

class _DotPainter extends BoxPainter {
  _DotPainter(this.decoration, VoidCallback onChanged) : super(onChanged);

  final DotTabIndicator decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final center = configuration.size!.center(offset);
    final dy = configuration.size!.height;

    final newOffset = Offset(center.dx, dy - 8);

    final paint = Paint();
    paint.color = decoration.indicatorColor;
    paint.style = PaintingStyle.fill;

    canvas.drawCircle(newOffset, decoration.radius, paint);
  }
}