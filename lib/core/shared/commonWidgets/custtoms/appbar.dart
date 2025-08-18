import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';
import '../../utils/extensions/extensions.dart';
import 'app_text.dart';
import 'custom_image.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget(
      {required this.isSearch,
      super.key,
      this.onTap,
      this.svgIcon,
      this.title,
      this.onMenuTap});

  final void Function()? onTap;
  final String? svgIcon;
  final String? title;
  final bool? isSearch;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) => AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        toolbarHeight: 48.h,
        leadingWidth: onMenuTap != null ? 48.w : 130.w,
        leading: onMenuTap != null
            ? IconButton(
                icon: Icon(Icons.menu,
                    color: Theme.of(context).appBarTheme.iconTheme?.color ??
                        AppColors.primaryText),
                onPressed: onMenuTap,
              )
            : CustomImage(
                'assets/images/sa_logo.png',
                height: 48.h,
                width: 130.w,
              ).withPadding(start: 20.w),
        title: MyTextApp.bold(
          title: title ?? '',
        ).center,
        actions: [
          isSearch == true
              ? GestureDetector(
                  onTap: onTap,
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w, left: 16.w),
                    child: CustomImage(
                      svgIcon ?? '',
                      height: 24.h,
                      width: 24.w,
                      color: Theme.of(context).appBarTheme.iconTheme?.color ??
                          AppColors.primaryText,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      );
}
