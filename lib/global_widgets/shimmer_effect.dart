import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  final Widget child;

  const ShimmerEffect({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: child,
      baseColor: Colors.grey[200],
      highlightColor: Colors.white,
    );
  }
}
