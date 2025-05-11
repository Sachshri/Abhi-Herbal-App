import 'package:new_flutter_app/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:flutter/material.dart';

class ClipPathContainer extends StatelessWidget {
  const ClipPathContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: CurverEdgesClipper(), child: child);
  }
}
