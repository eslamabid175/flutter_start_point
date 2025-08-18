import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/extensions/extensions.dart';

class BaseShimmer extends StatelessWidget {
  final Widget child;
  const BaseShimmer({required this.child, super.key});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        highlightColor: context.hintColor.withOpacity(.2),
        baseColor: context.hintColor.withOpacity(.5),
        child: child,
      );
}
