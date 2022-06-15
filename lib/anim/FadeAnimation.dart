
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double? delay;
  final Widget? child;
  final TimelineTween<MultiTween> _tween = TimelineTween<MultiTween>();
  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
   /* final tween = MultiTween([
      Track("opacity").add(Duration(milliseconds: 1000), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
        Duration(milliseconds: 1500), Tween(begin: -30.0, end: 0.0),
        curve: Curves.easeOut)
    ]);*/

/*    return ControlledAnimation(
      delay: Duration(milliseconds: (1000 * delay!.toDouble()).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
          offset: Offset(0, animation["translateY"]), 
          child: child
        ),
      ),
    );*/
    return Text("");
  }
}