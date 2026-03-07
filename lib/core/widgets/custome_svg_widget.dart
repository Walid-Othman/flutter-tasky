import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_app/core/theme/theme_controller.dart';

class CustomeSvgwidget extends StatelessWidget {
  CustomeSvgwidget({
    super.key,
    required this.imgUrl,
    this.withColor = true,
    this.width,
    this.height,
  });
  CustomeSvgwidget.withoutColor({
    super.key,
    required this.imgUrl,
    this.width,
    this.height,
  }) : withColor = false;
  String imgUrl;
  bool withColor;
  int? width;
  int? height;
  @override
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      // ignore: prefer_null_aware_operators
      width: width != null ? width!.toDouble() : null,
      // ignore: prefer_null_aware_operators
      height: height != null ? height!.toDouble() : null,
      imgUrl,
      colorFilter: withColor
          ? ColorFilter.mode(
              ThemeController.isDark() ? Color(0xFFC6C6C6) : Color(0xFF3A4640),
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
