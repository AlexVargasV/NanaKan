import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgIcon extends StatelessWidget {
  final String assetPath;
  final double size;
  final Color? color;

  const CustomSvgIcon({
    required this.assetPath,
    this.size = 24.0,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Theme.of(context).iconTheme.color;

    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(effectiveColor!, BlendMode.srcIn),
    );
  }
}
