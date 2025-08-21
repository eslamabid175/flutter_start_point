import 'package:flutter/material.dart';

import '../theme/colors/app_colors.dart';

class MyTextApp extends StatelessWidget {
  final String title;
  final Color? color;
  final double? size;
  final double? letterSpace;
  final double? wordSpace;
  final String? fontFamily;
  final TextAlign? align;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final int? maxLines;

  final IconData? icon;
  final ImageProvider? image;
  final Color? iconColor;
  final double? iconSize;
  final double? imageSize;

  final VoidCallback? onTap;

  const MyTextApp({
    required this.title,
    super.key,
    this.color,
    this.size,
    this.align,
    this.fontFamily,
    this.decoration,
    this.letterSpace,
    this.wordSpace,
    this.overflow,
    this.fontWeight,
    this.icon,
    this.image,
    this.iconColor,
    this.iconSize,
    this.imageSize,
    this.onTap,
    this.maxLines,
  });

  // Named constructor for bold text
  MyTextApp.bold({
    required this.title,
    required BuildContext context,
    super.key,
    Color? color,
    this.size = 18,
    this.align = TextAlign.center,
    this.fontFamily,
    this.decoration = TextDecoration.none,
    this.letterSpace,
    this.wordSpace,
    this.overflow = TextOverflow.ellipsis,
    this.icon,
    this.image,
    this.iconColor,
    this.iconSize,
    this.imageSize,
    this.maxLines,
  })  : fontWeight = FontWeight.bold,
        color = color ?? context.colors.textPrimary,
        onTap = null;

  // Named constructor for app themed text
  MyTextApp.app({
    required this.title,
    required BuildContext context,
    super.key,
    Color? color,
    this.size = 18,
    this.align = TextAlign.start,
    this.fontFamily,
    this.decoration = TextDecoration.none,
    this.letterSpace,
    this.wordSpace,
    this.overflow = TextOverflow.ellipsis,
    this.icon,
    this.image,
    this.iconColor,
    this.iconSize,
    this.imageSize,
    this.maxLines,
  })  : fontWeight = FontWeight.bold,
        color = color ?? context.colors.primary,
        onTap = null;

  // Named constructor for small text
  MyTextApp.small({
    required this.title,
    required BuildContext context,
    super.key,
    Color? color,
    this.size = 12,
    this.align = TextAlign.start,
    this.fontFamily,
    this.decoration = TextDecoration.none,
    this.letterSpace,
    this.wordSpace,
    this.overflow = TextOverflow.clip,
    this.icon,
    this.image,
    this.iconColor,
    this.iconSize,
    this.imageSize,
    this.maxLines,
  })  : fontWeight = FontWeight.normal,
        color = color ?? context.colors.textSecondary,
        onTap = null;

  // Named constructor for headings
  MyTextApp.heading({
    required this.title,
    required BuildContext context,
    super.key,
    Color? color,
    this.size = 24,
    this.align = TextAlign.center,
    this.fontFamily,
    this.decoration = TextDecoration.none,
    this.letterSpace = 1.2,
    this.wordSpace,
    this.overflow = TextOverflow.ellipsis,
    this.icon,
    this.image,
    this.iconColor,
    this.iconSize,
    this.imageSize,
    this.maxLines,
  })  : fontWeight = FontWeight.bold,
        color = color ?? context.colors.textPrimary,
        onTap = null;

  // Named constructor for navigable text
  MyTextApp.nav({
    required this.title,
    required this.onTap,
    required BuildContext context,
    super.key,
    Color? color,
    this.size = 16,
    this.align = TextAlign.start,
    this.fontFamily,
    this.decoration = TextDecoration.underline,
    this.letterSpace,
    this.wordSpace,
    this.overflow = TextOverflow.ellipsis,
    this.icon,
    this.image,
    this.iconColor,
    this.iconSize,
    this.imageSize,
    this.maxLines,
  })  : fontWeight = FontWeight.normal,
        color = color ?? context.colors.primary;

  @override
  Widget build(BuildContext context) {
    final textColor = color ?? context.colors.textPrimary;
    final effectiveIconColor = iconColor ?? textColor;

    return onTap != null
        ? InkWell(
      onTap: onTap,
      child: _buildTextRow(context, textColor, effectiveIconColor),
    )
        : _buildTextRow(context, textColor, effectiveIconColor);
  }

  MyTextApp copyWith({
    String? title,
    Color? color,
    double? size,
    TextAlign? align,
    String? fontFamily,
    TextDecoration? decoration,
    double? letterSpace,
    double? wordSpace,
    TextOverflow? overflow,
    FontWeight? fontWeight,
    IconData? icon,
    ImageProvider? image,
    Color? iconColor,
    double? iconSize,
    double? imageSize,
    VoidCallback? onTap,
    int? maxLines,
  }) =>
      MyTextApp(
        title: title ?? this.title,
        color: color ?? this.color,
        size: size ?? this.size,
        align: align ?? this.align,
        fontFamily: fontFamily ?? this.fontFamily,
        decoration: decoration ?? this.decoration,
        letterSpace: letterSpace ?? this.letterSpace,
        wordSpace: wordSpace ?? this.wordSpace,
        overflow: overflow ?? this.overflow,
        fontWeight: fontWeight ?? this.fontWeight,
        icon: icon ?? this.icon,
        image: image ?? this.image,
        iconColor: iconColor ?? this.iconColor,
        iconSize: iconSize ?? this.iconSize,
        imageSize: imageSize ?? this.imageSize,
        onTap: onTap ?? this.onTap,
        maxLines: maxLines ?? this.maxLines,
      );

  Widget _buildTextRow(BuildContext context, Color textColor, Color iconColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          Icon(
            icon,
            color: iconColor,
            size: iconSize ?? size ?? 16,
          ),
        if (image != null)
          Image(
            image: image!,
            width: imageSize ?? 24,
            height: imageSize ?? 24,
          ),
        if (icon != null || image != null) const SizedBox(width: 8.0),
        Flexible(
          child: Text(
            title,
            textAlign: align ?? TextAlign.start,
            style: TextStyle(
              color: textColor,
              fontSize: size,
              letterSpacing: letterSpace,
              wordSpacing: wordSpace,
              decoration: decoration ?? TextDecoration.none,
              fontWeight: fontWeight ?? FontWeight.normal,
              fontFamily: fontFamily ?? 'Roboto',
            ),
            overflow: overflow,
            maxLines: maxLines,
          ),
        ),
      ],
    );
  }
}

// Extension for easier usage without passing context
extension MyTextAppExtension on BuildContext {
  MyTextApp textBold({
    required String title,
    Color? color,
    double? size,
    TextAlign? align,
    String? fontFamily,
    TextDecoration? decoration,
    double? letterSpace,
    double? wordSpace,
    TextOverflow? overflow,
    IconData? icon,
    ImageProvider? image,
    Color? iconColor,
    double? iconSize,
    double? imageSize,
    int? maxLines,
  }) {
    return MyTextApp.bold(
      context: this,
      title: title,
      color: color,
      size: size,
      align: align,
      fontFamily: fontFamily,
      decoration: decoration,
      letterSpace: letterSpace,
      wordSpace: wordSpace,
      overflow: overflow,
      icon: icon,
      image: image,
      iconColor: iconColor,
      iconSize: iconSize,
      imageSize: imageSize,
      maxLines: maxLines,
    );
  }

  MyTextApp textApp({
    required String title,
    Color? color,
    double? size,
    TextAlign? align,
    String? fontFamily,
    TextDecoration? decoration,
    double? letterSpace,
    double? wordSpace,
    TextOverflow? overflow,
    IconData? icon,
    ImageProvider? image,
    Color? iconColor,
    double? iconSize,
    double? imageSize,
    int? maxLines,
  }) {
    return MyTextApp.app(
      context: this,
      title: title,
      color: color,
      size: size,
      align: align,
      fontFamily: fontFamily,
      decoration: decoration,
      letterSpace: letterSpace,
      wordSpace: wordSpace,
      overflow: overflow,
      icon: icon,
      image: image,
      iconColor: iconColor,
      iconSize: iconSize,
      imageSize: imageSize,
      maxLines: maxLines,
    );
  }

  MyTextApp textSmall({
    required String title,
    Color? color,
    double? size,
    TextAlign? align,
    String? fontFamily,
    TextDecoration? decoration,
    double? letterSpace,
    double? wordSpace,
    TextOverflow? overflow,
    IconData? icon,
    ImageProvider? image,
    Color? iconColor,
    double? iconSize,
    double? imageSize,
    int? maxLines,
  }) {
    return MyTextApp.small(
      context: this,
      title: title,
      color: color,
      size: size,
      align: align,
      fontFamily: fontFamily,
      decoration: decoration,
      letterSpace: letterSpace,
      wordSpace: wordSpace,
      overflow: overflow,
      icon: icon,
      image: image,
      iconColor: iconColor,
      iconSize: iconSize,
      imageSize: imageSize,
      maxLines: maxLines,
    );
  }

  MyTextApp textHeading({
    required String title,
    Color? color,
    double? size,
    TextAlign? align,
    String? fontFamily,
    TextDecoration? decoration,
    double? letterSpace,
    double? wordSpace,
    TextOverflow? overflow,
    IconData? icon,
    ImageProvider? image,
    Color? iconColor,
    double? iconSize,
    double? imageSize,
    int? maxLines,
  }) {
    return MyTextApp.heading(
      context: this,
      title: title,
      color: color,
      size: size,
      align: align,
      fontFamily: fontFamily,
      decoration: decoration,
      letterSpace: letterSpace,
      wordSpace: wordSpace,
      overflow: overflow,
      icon: icon,
      image: image,
      iconColor: iconColor,
      iconSize: iconSize,
      imageSize: imageSize,
      maxLines: maxLines,
    );
  }

  MyTextApp textNav({
    required String title,
    required VoidCallback onTap,
    Color? color,
    double? size,
    TextAlign? align,
    String? fontFamily,
    TextDecoration? decoration,
    double? letterSpace,
    double? wordSpace,
    TextOverflow? overflow,
    IconData? icon,
    ImageProvider? image,
    Color? iconColor,
    double? iconSize,
    double? imageSize,
    int? maxLines,
  }) {
    return MyTextApp.nav(
      context: this,
      title: title,
      onTap: onTap,
      color: color,
      size: size,
      align: align,
      fontFamily: fontFamily,
      decoration: decoration,
      letterSpace: letterSpace,
      wordSpace: wordSpace,
      overflow: overflow,
      icon: icon,
      image: image,
      iconColor: iconColor,
      iconSize: iconSize,
      imageSize: imageSize,
      maxLines: maxLines,
    );
  }
}