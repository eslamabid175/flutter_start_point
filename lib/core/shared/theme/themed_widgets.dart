import 'package:flutter/material.dart';
import 'theme_extensions.dart';

/// Custom themed container with consistent styling
class ThemedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final double? width;
  final double? height;
  final BoxDecoration? decoration;

  const ThemedContainer({
    required this.child,
    super.key,
    this.padding,
    this.margin,
    this.color,
    this.width,
    this.height,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extensions = context.themeExtensions;

    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: decoration ??
          BoxDecoration(
            color: color ?? theme.cardTheme.color,
            borderRadius: BorderRadius.circular(extensions.borderRadius ?? 8),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
      child: child,
    );
  }
}

/// Custom themed button with consistent styling
class ThemedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final IconData? icon;
  final bool isLoading;
  final ButtonType type;

  const ThemedButton({
    required this.onPressed,
    required this.text,
    super.key,
    this.icon,
    this.isLoading = false,
    this.type = ButtonType.elevated,
  });

  @override
  Widget build(BuildContext context) {
    final extensions = context.themeExtensions;

    final Widget buttonChild = isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: extensions.iconSize),
                const SizedBox(width: 8),
              ],
              Text(text),
            ],
          );

    switch (type) {
      case ButtonType.elevated:
        return SizedBox(
          height: extensions.buttonHeight,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            child: buttonChild,
          ),
        );
      case ButtonType.outlined:
        return SizedBox(
          height: extensions.buttonHeight,
          child: OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            child: buttonChild,
          ),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          child: buttonChild,
        );
    }
  }
}

enum ButtonType { elevated, outlined, text }

/// Custom themed text field with consistent styling
class ThemedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const ThemedTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final extensions = context.themeExtensions;

    return SizedBox(
      height: errorText != null
          ? (extensions.inputFieldHeight ?? 56) + 22
          : extensions.inputFieldHeight,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

/// Custom themed app bar with consistent styling
class ThemedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final double? elevation;
  final Color? backgroundColor;
  final TabBar? bottom;

  const ThemedAppBar({
    required this.title,
    super.key,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.elevation,
    this.backgroundColor,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) => AppBar(
        title: Text(title),
        actions: actions,
        leading: leading,
        centerTitle: centerTitle,
        elevation: elevation,
        backgroundColor: backgroundColor,
        bottom: bottom,
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Custom themed card with consistent styling
class ThemedCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final double? elevation;

  const ThemedCard({
    required this.child,
    super.key,
    this.onTap,
    this.padding,
    this.margin,
    this.color,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extensions = context.themeExtensions;

    Widget cardContent = Padding(
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );

    if (onTap != null) {
      cardContent = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(extensions.borderRadius ?? 12),
        child: cardContent,
      );
    }

    return Card(
      margin: margin,
      color: color,
      elevation: elevation,
      child: cardContent,
    );
  }
}
