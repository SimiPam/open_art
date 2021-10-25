import 'package:flutter/material.dart';

class VSpace extends StatelessWidget {
  const VSpace(
    this.length, {
    this.child,
  });

  final double length;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: length,
    );
  }
}

class HSpace extends StatelessWidget {
  const HSpace(
    this.length, {
    this.child,
  });

  final double length;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: length,
    );
  }
}
