import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app/di.dart' as di;
import '../../../../../core/shared/commonWidgets/custtoms/appbar.dart';
import '../../../../../core/shared/theme/colors/app_colors.dart';
import '../../navigationController/navigation_bloc.dart';
import '../../navigationController/navigation_event.dart';
import '../../navigationController/navigation_state.dart';
import '../widgets/custom_bottom_nav_item.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  final bloc = di.sl<NavigationBloc>()..add(NavigateToPage(0));

  @override
  Widget build(BuildContext context) {
    // Get the current theme brightness to set system UI overlay style
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<NavigationBloc, NavigationState>(
      bloc: bloc,
      builder: (context, state) => PopScope(
        canPop: false,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            systemNavigationBarColor: context.colors.surface,
            systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
            statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
            statusBarColor: Colors.transparent,
            statusBarBrightness:
            isDarkMode ? Brightness.dark : Brightness.light,
          ),
          child: Scaffold(
            backgroundColor: context.colors.background,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(48.h),
              child: Builder(
                builder: (context) => AppBarWidget(
                  isSearch: false,
                  title: 'App Bar Title',
                  onMenuTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),
            key: widget.key,
            floatingActionButton: Container(
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(52.r),
                onTap: () {
                  di.sl<NavigationBloc>().add(NavigateToPage(2));
                },
                child: Container(
                  height: 56.r,
                  width: 56.r,
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(56.r),
                    boxShadow: [
                      BoxShadow(
                        color: context.colors.shadow,
                        blurRadius: 10.r,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 60.h,
                        width: 60.w,
                        child: CircleAvatar(
                          backgroundColor: context.colors.primary,
                          child: Icon(
                            Icons.smart_toy_outlined,
                            size: 24,
                            color: context.colors.onPrimary,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12.h,
                        right: 10.w,
                        child: Container(
                          height: 10.r,
                          width: 10.r,
                          decoration: BoxDecoration(
                            color: context.colors.warning,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            drawer: _buildDrawer(context),
            body: bloc.currentPage,
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              height: 70.h,
              elevation: 5,
              notchMargin: 10,
              clipBehavior: Clip.antiAlias,
              shape: const CircularNotchedRectangle(),
              color: context.colors.surface,
              child: buildCustomBottomNavigationBar(context, state),
            ),
          ),
        ),
      ),
    );
  }

  Widget? _buildDrawer(BuildContext context) {
    // Uncomment and update when ready to use
    return null;

    // return Drawer(
    //   backgroundColor: context.colors.surface,
    //   child: ListView(
    //     padding: EdgeInsets.zero,
    //     children: [
    //       UserAccountsDrawerHeader(
    //         decoration: BoxDecoration(
    //           color: context.colors.primary,
    //         ),
    //         accountName: Text(
    //           user?.displayName ?? 'Guest',
    //           style: TextStyle(color: context.colors.onPrimary),
    //         ),
    //         accountEmail: Text(
    //           user?.email ?? 'Not signed in',
    //           style: TextStyle(color: context.colors.onPrimary),
    //         ),
    //         currentAccountPicture: CircleAvatar(
    //           backgroundColor: context.colors.surface,
    //           backgroundImage: user?.photoURL != null
    //               ? NetworkImage(user!.photoURL!)
    //               : null,
    //           child: user?.photoURL == null
    //               ? Icon(Icons.person, color: context.colors.primary)
    //               : null,
    //         ),
    //       ),
    //       _buildDrawerItem(
    //         context,
    //         icon: Icons.book,
    //         title: 'my_courses'.tr(),
    //         onTap: () {
    //           Navigator.pop(context);
    //           push(NamedRoutes.i.myCourses);
    //         },
    //       ),
    //       _buildDrawerItem(
    //         context,
    //         icon: Icons.bookmark,
    //         title: 'bookmarks'.tr(),
    //         onTap: () {
    //           Navigator.pop(context);
    //           push(NamedRoutes.i.bookmarks);
    //         },
    //       ),
    //       _buildDrawerItem(
    //         context,
    //         icon: Icons.settings,
    //         title: 'settings'.tr(),
    //         onTap: () {
    //           Navigator.pop(context);
    //           push(NamedRoutes.i.settings);
    //         },
    //       ),
    //       _buildDrawerItem(
    //         context,
    //         icon: Icons.privacy_tip,
    //         title: 'privacy_policy'.tr(),
    //         onTap: () {
    //           push(NamedRoutes.i.privacyPolicy);
    //         },
    //       ),
    //       ListTile(
    //         leading: CustomIconImage(
    //           Assets.iconsAbout,
    //           color: context.colors.onSurface,
    //         ),
    //         title: Text(
    //           'about_us'.tr(),
    //           style: TextStyle(color: context.colors.textPrimary),
    //         ),
    //         onTap: () {
    //           push(NamedRoutes.i.aboutUs);
    //         },
    //       ),
    //       Divider(color: context.colors.divider),
    //       ListTile(
    //         leading: user == null
    //             ? CustomIconImage(
    //                 Assets.iconsGoogle,
    //                 color: context.colors.onSurface,
    //               )
    //             : Icon(Icons.logout, color: context.colors.error),
    //         title: Text(
    //           user == null ? 'login'.tr() : 'logout'.tr(),
    //           style: TextStyle(
    //             color: user == null
    //               ? context.colors.textPrimary
    //               : context.colors.error,
    //           ),
    //         ),
    //         onTap: () async {
    //           Navigator.pop(context);
    //           if (user == null) {
    //             context.read<AuthBloc>().add(SignInWithGoogleEvent());
    //           } else {
    //             try {
    //               await GoogleSignIn().signOut();
    //             } catch (_) {}
    //             context.read<AuthBloc>().add(LogOutEvent());
    //           }
    //         },
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget _buildDrawerItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
      }) {
    return ListTile(
      leading: Icon(icon, color: context.colors.onSurface),
      title: Text(
        title,
        style: TextStyle(color: context.colors.textPrimary),
      ),
      onTap: onTap,
    );
  }
}