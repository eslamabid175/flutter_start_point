import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app/di.dart' as di;
import '../../../../../core/shared/commonWidgets/custtoms/appbar.dart';
import '../../../../../core/shared/theme/app_colors.dart';
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
  Widget build(BuildContext context) =>
      BlocBuilder<NavigationBloc, NavigationState>(
        bloc: bloc,
        builder: (context, state) => WillPopScope(
          onWillPop: () => Future.value(false),
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
            ),
            child: Scaffold(
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
              //     extendBody: true,
              floatingActionButton: Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                  // color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(52.r),
                  onTap: () {
                    state.currentIndex == 2;
                    di.sl<NavigationBloc>().add(NavigateToPage(2));
                  },
                  child: Container(
                    height: 56.r,
                    width: 56.r,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(56.r),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Theme.of(context).shadowColor.withOpacity(0.3),
                            blurRadius: 10.r,
                            offset: const Offset(0, 6),
                          )
                        ]),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 60.h,
                          width: 60.w,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            child:
                                const Icon(Icons.smart_toy_outlined, size: 24),
                          ),
                        ),
                        Positioned(
                          top: 12.h,
                          right: 10.w,
                          child: Container(
                            height: 10.r,
                            width: 10.r,
                            decoration: BoxDecoration(
                                color: AppColors.yellowColor,
                                borderRadius: BorderRadius.circular(10.r)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // drawer: Drawer(
              //   child: ListView(
              //     padding: EdgeInsets.zero,
              //     children: [
              //       UserAccountsDrawerHeader(
              //         accountName: Text(user?.displayName ?? 'Guest'),
              //         accountEmail: Text(user?.email ?? 'Not signed in'),
              //         currentAccountPicture: CircleAvatar(
              //           backgroundImage: user?.photoURL != null
              //               ? NetworkImage(user!.photoURL!)
              //               : null,
              //           child: user?.photoURL == null
              //               ? const Icon(Icons.person)
              //               : null,
              //         ),
              //       ),
              //       ListTile(
              //         leading: const Icon(Icons.book),
              //         title: Text('my_courses'.tr()),
              //         onTap: () {
              //           Navigator.pop(context); // Close drawer
              //           push(NamedRoutes.i.myCourses);
              //         },
              //       ),
              //       ListTile(
              //         leading: const Icon(Icons.bookmark),
              //         title: Text('bookmarks'.tr()),
              //         onTap: () {
              //           Navigator.pop(context); // Close drawer
              //           push(NamedRoutes.i.bookmarks);
              //         },
              //       ),
              //       ListTile(
              //         leading: const Icon(Icons.settings),
              //         title: Text('settings'.tr()),
              //         onTap: () {
              //           Navigator.pop(context); // Close drawer
              //           push(NamedRoutes.i.settings);
              //         },
              //       ),
              //       ListTile(
              //         leading: const Icon(Icons.privacy_tip),
              //         title: Text('privacy_policy'.tr()),
              //         onTap: () {
              //           push(NamedRoutes.i.privacyPolicy);
              //         },
              //       ),
              //       ListTile(
              //         leading: CustomIconImage(Assets.iconsAbout),
              //         title: Text('about_us'.tr()),
              //         onTap: () {
              //           push(NamedRoutes.i.aboutUs);
              //         },
              //       ),
              //       const Divider(),
              //       ListTile(
              //         leading: user == null
              //             ? CustomIconImage(Assets.iconsGoogle)
              //             : const Icon(Icons.logout),
              //         title:
              //             Text(user == null ? 'login'.tr() : 'logout'.tr()),
              //         onTap: () async {
              //           Navigator.pop(context); // Close drawer
              //           if (user == null) {
              //             context
              //                 .read<AuthBloc>()
              //                 .add(SignInWithGoogleEvent());
              //           } else {
              //             try {
              //               await GoogleSignIn().signOut();
              //             } catch (_) {}
              //             context.read<AuthBloc>().add(LogOutEvent());
              //             // No need to setState or pushAndRemoveUntil, StreamBuilder will update UI
              //           }
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              body: bloc.currentPage,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomAppBar(
                height: 70.h,
                elevation: 5,
                notchMargin: 10,
                clipBehavior: Clip.antiAlias,
                shape: const CircularNotchedRectangle(),
                child: buildCustomBottomNavigationBar(context, state),
              ),
            ),
          ),
        ),
      );
}
