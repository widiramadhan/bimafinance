import 'package:flutter/material.dart';

class ModalProgress extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  Offset? offset;
  final bool dismissible;
  final Widget child;

  ModalProgress({
    Key? key,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.progressIndicator = const CircularProgressIndicator(),
    this.offset,
    this.dismissible = false,
    required this.child,
  })  : assert(child != null),
        assert(inAsyncCall != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!inAsyncCall) return child;

    Widget layOutProgressIndicator;
    if (offset == null)
      layOutProgressIndicator = Center(child: progressIndicator);
    else {
      layOutProgressIndicator = Positioned(
        child: progressIndicator,
        left: offset!.dx,
        top: offset!.dy,
      );
    }

    return new Stack(
      children: [
        child,
        new Opacity(
          child: new ModalBarrier(dismissible: dismissible, color: color),
          opacity: opacity,
        ),
        layOutProgressIndicator,
      ],
    );
  }
}