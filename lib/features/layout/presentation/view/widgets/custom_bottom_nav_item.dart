import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_boilerplate/app/di.dart' as di;
import '../../../../../core/shared/commonWidgets/custtoms/custom_image.dart';
import '../../../../../core/shared/utils/extensions/extensions.dart';
import '../../../../../generated/assets.gen.dart';
import '../../navigationController/navigation_bloc.dart';
import '../../navigationController/navigation_event.dart';
import '../../navigationController/navigation_state.dart';

BottomNavigationBarItem buildBottomNavigationBarItem(
        {required String icon, required bool isActive, String? label}) =>
    BottomNavigationBarItem(
      label: label ?? '',
      icon: Container(
        decoration: BoxDecoration(
          // color: isActive ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 9.8),
        child: Image(
          image: AssetImage(icon),
          width: 25,
        ),
      ),
      activeIcon: Container(
        decoration: BoxDecoration(
          // color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 9.8),
        child: Image(
          image: AssetImage(icon),
          width: 25,
        ),
      ),
    );

Widget buildNavItem({
  required BuildContext context,
  required int index,
  required String icon,
  required String tittle,
  required bool isActive,
}) =>
    Expanded(
      child: GestureDetector(
        onTap: () => di.sl<NavigationBloc>().add(NavigateToPage(index)),
        // child: Icon(
        //   icon,
        //   color: isActive == true ? AppColors.accentColor : Colors.grey,
        // ),
        child: Column(
          children: [
            CustomImage(
              icon,
              width: 22.w,
              // fit: BoxFit.contain,
              color: isActive == true
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).disabledColor,
            ).withPadding(vertical: 3.h),
            Text(
              tittle,
              maxLines: 1,
              style: TextStyle(
                fontSize: 10.sp,
                color: isActive
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).disabledColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );

class BottomNavItem extends StatelessWidget {
  final String? imageData;
  final String? tittle;
  final VoidCallback? onTap;
  final bool isSelected;
  final int index;
  const BottomNavItem(
      {super.key,
      this.imageData,
      this.tittle,
      this.onTap,
      this.index = 0,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) => Expanded(
        child: InkWell(
          // onTap: onTap,
          onTap: () => di.sl<NavigationBloc>().add(NavigateToPage(index)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imageData!,
                colorFilter: ColorFilter.mode(
                  isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).disabledColor,
                  BlendMode.srcIn,
                ),
                width: 20.w,
              ).withPadding(vertical: 3.h),
              Text(
                tittle!,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).disabledColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
}

Widget buildCustomBottomNavigationBar(
        BuildContext context, NavigationState state) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildNavItem(
          context: context,
          tittle: 'Home',
          index: 0,
          icon: state.currentIndex == 0
              ? Assets.icons.homeSvg.path
              : Assets.icons.homeActive.path,
          isActive: state.currentIndex == 0,
        ),
        buildNavItem(
          tittle: 'Category',
          context: context,
          index: 1,
          icon: state.currentIndex == 1
              ? Assets.icons.categorySvg.path
              : Assets.icons.categoryActive.path,
          isActive: state.currentIndex == 1,
        ),
        const Expanded(
          child: SizedBox(),
        ),
        buildNavItem(
          context: context,
          tittle: 'Wishlist',
          index: 3,
          icon: state.currentIndex == 3
              ? Assets.icons.wishlistSvg.path
              : Assets.icons.wishlistActive.path,
          isActive: state.currentIndex == 3,
        ),
        buildNavItem(
          context: context,
          tittle: 'Profile',
          index: 4,
          icon: state.currentIndex == 4
              ? Assets.icons.profilePng.path
              : Assets.icons.profileActive.path,
          isActive: state.currentIndex == 4,
        ),
      ],
    );
