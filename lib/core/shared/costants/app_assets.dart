class AppAssets {
  // Private constructor to prevent instantiation
  AppAssets._();

  // ============= BASE PATHS =============
  static const String _basePath = 'assets';
  static const String _imagesPath = '$_basePath/images';
  static const String _iconsPath = '$_basePath/icons';
  static const String _animationsPath = '$_basePath/animations';
  static const String _fontsPath = '$_basePath/fonts';
  static const String _audioPath = '$_basePath/audio';
  static const String _videoPath = '$_basePath/video';
  static const String _dataPath = '$_basePath/data';
  static const String _documentsPath = '$_basePath/documents';

  // ============= IMAGES =============
  // Logos
  static const String logo = '$_imagesPath/logo.png';
  static const String logoLight = '$_imagesPath/logo_light.png';
  static const String logoDark = '$_imagesPath/logo_dark.png';
  static const String logoTransparent = '$_imagesPath/logo_transparent.png';
  static const String logoRounded = '$_imagesPath/logo_rounded.png';
  static const String logoSquare = '$_imagesPath/logo_square.png';
  static const String logoHorizontal = '$_imagesPath/logo_horizontal.png';
  static const String logoVertical = '$_imagesPath/logo_vertical.png';

  // Backgrounds
  static const String backgroundDefault = '$_imagesPath/bg_default.png';
  static const String backgroundGradient = '$_imagesPath/bg_gradient.png';
  static const String backgroundPattern = '$_imagesPath/bg_pattern.png';
  static const String backgroundAuth = '$_imagesPath/bg_auth.png';
  static const String backgroundOnboarding = '$_imagesPath/bg_onboarding.png';
  static const String backgroundSplash = '$_imagesPath/bg_splash.png';

  // Placeholders
  static const String placeholderImage = '$_imagesPath/placeholder_image.png';
  static const String placeholderAvatar = '$_imagesPath/placeholder_avatar.png';
  static const String placeholderBanner = '$_imagesPath/placeholder_banner.png';
  static const String placeholderThumbnail = '$_imagesPath/placeholder_thumbnail.png';
  static const String placeholderProduct = '$_imagesPath/placeholder_product.png';

  // Illustrations
  static const String illustrationEmpty = '$_imagesPath/illustration_empty.png';
  static const String illustrationError = '$_imagesPath/illustration_error.png';
  static const String illustrationNoInternet = '$_imagesPath/illustration_no_internet.png';
  static const String illustrationNotFound = '$_imagesPath/illustration_not_found.png';
  static const String illustrationSuccess = '$_imagesPath/illustration_success.png';
  static const String illustrationWelcome = '$_imagesPath/illustration_welcome.png';
  static const String illustrationMaintenance = '$_imagesPath/illustration_maintenance.png';
  static const String illustrationComingSoon = '$_imagesPath/illustration_coming_soon.png';

  // Onboarding
  static const String onboarding1 = '$_imagesPath/onboarding_1.png';
  static const String onboarding2 = '$_imagesPath/onboarding_2.png';
  static const String onboarding3 = '$_imagesPath/onboarding_3.png';

  // Auth
  static const String authHeader = '$_imagesPath/auth_header.png';
  static const String authBackground = '$_imagesPath/auth_background.png';
  static const String authLogo = '$_imagesPath/auth_logo.png';

  // Profile
  static const String defaultAvatar = '$_imagesPath/default_avatar.png';
  static const String defaultCover = '$_imagesPath/default_cover.png';
  static const String profileBackground = '$_imagesPath/profile_bg.png';

  // ============= ICONS =============
  // Social Media Icons
  static const String iconGoogle = '$_iconsPath/ic_google.png';
  static const String iconFacebook = '$_iconsPath/ic_facebook.png';
  static const String iconTwitter = '$_iconsPath/ic_twitter.png';
  static const String iconLinkedin = '$_iconsPath/ic_linkedin.png';
  static const String iconInstagram = '$_iconsPath/ic_instagram.png';
  static const String iconYoutube = '$_iconsPath/ic_youtube.png';
  static const String iconWhatsapp = '$_iconsPath/ic_whatsapp.png';
  static const String iconTelegram = '$_iconsPath/ic_telegram.png';
  static const String iconSnapchat = '$_iconsPath/ic_snapchat.png';
  static const String iconTiktok = '$_iconsPath/ic_tiktok.png';
  static const String iconApple = '$_iconsPath/ic_apple.png';
  static const String iconGithub = '$_iconsPath/ic_github.png';

  // Navigation Icons
  static const String iconHome = '$_iconsPath/ic_home.png';
  static const String iconSearch = '$_iconsPath/ic_search.png';
  static const String iconNotification = '$_iconsPath/ic_notification.png';
  static const String iconProfile = '$_iconsPath/ic_profile.png';
  static const String iconSettings = '$_iconsPath/ic_settings.png';
  static const String iconMenu = '$_iconsPath/ic_menu.png';
  static const String iconBack = '$_iconsPath/ic_back.png';
  static const String iconClose = '$_iconsPath/ic_close.png';
  static const String iconFilter = '$_iconsPath/ic_filter.png';
  static const String iconSort = '$_iconsPath/ic_sort.png';

  // Action Icons
  static const String iconAdd = '$_iconsPath/ic_add.png';
  static const String iconEdit = '$_iconsPath/ic_edit.png';
  static const String iconDelete = '$_iconsPath/ic_delete.png';
  static const String iconShare = '$_iconsPath/ic_share.png';
  static const String iconDownload = '$_iconsPath/ic_download.png';
  static const String iconUpload = '$_iconsPath/ic_upload.png';
  static const String iconSave = '$_iconsPath/ic_save.png';
  static const String iconCopy = '$_iconsPath/ic_copy.png';
  static const String iconPrint = '$_iconsPath/ic_print.png';
  static const String iconRefresh = '$_iconsPath/ic_refresh.png';

  // Status Icons
  static const String iconSuccess = '$_iconsPath/ic_success.png';
  static const String iconError = '$_iconsPath/ic_error.png';
  static const String iconWarning = '$_iconsPath/ic_warning.png';
  static const String iconInfo = '$_iconsPath/ic_info.png';
  static const String iconPending = '$_iconsPath/ic_pending.png';
  static const String iconCompleted = '$_iconsPath/ic_completed.png';
  static const String iconCancelled = '$_iconsPath/ic_cancelled.png';

  // Feature Icons
  static const String iconCamera = '$_iconsPath/ic_camera.png';
  static const String iconGallery = '$_iconsPath/ic_gallery.png';
  static const String iconLocation = '$_iconsPath/ic_location.png';
  static const String iconCalendar = '$_iconsPath/ic_calendar.png';
  static const String iconClock = '$_iconsPath/ic_clock.png';
  static const String iconPhone = '$_iconsPath/ic_phone.png';
  static const String iconEmail = '$_iconsPath/ic_email.png';
  static const String iconMessage = '$_iconsPath/ic_message.png';
  static const String iconChat = '$_iconsPath/ic_chat.png';
  static const String iconVideo = '$_iconsPath/ic_video.png';
  static const String iconMicrophone = '$_iconsPath/ic_microphone.png';
  static const String iconVolume = '$_iconsPath/ic_volume.png';
  static const String iconMusic = '$_iconsPath/ic_music.png';
  static const String iconDocument = '$_iconsPath/ic_document.png';
  static const String iconFolder = '$_iconsPath/ic_folder.png';
  static const String iconFile = '$_iconsPath/ic_file.png';
  static const String iconAttachment = '$_iconsPath/ic_attachment.png';
  static const String iconLink = '$_iconsPath/ic_link.png';
  static const String iconQrCode = '$_iconsPath/ic_qr_code.png';
  static const String iconBarcode = '$_iconsPath/ic_barcode.png';
  static const String iconScan = '$_iconsPath/ic_scan.png';
  static const String iconFingerprint = '$_iconsPath/ic_fingerprint.png';
  static const String iconFaceId = '$_iconsPath/ic_face_id.png';
  static const String iconLock = '$_iconsPath/ic_lock.png';
  static const String iconUnlock = '$_iconsPath/ic_unlock.png';
  static const String iconSecurity = '$_iconsPath/ic_security.png';
  static const String iconShield = '$_iconsPath/ic_shield.png';
  static const String iconVerified = '$_iconsPath/ic_verified.png';

  // Payment Icons
  static const String iconVisa = '$_iconsPath/ic_visa.png';
  static const String iconMastercard = '$_iconsPath/ic_mastercard.png';
  static const String iconPaypal = '$_iconsPath/ic_paypal.png';
  static const String iconStripe = '$_iconsPath/ic_stripe.png';
  static const String iconCash = '$_iconsPath/ic_cash.png';
  static const String iconWallet = '$_iconsPath/ic_wallet.png';
  static const String iconCreditCard = '$_iconsPath/ic_credit_card.png';

  // ============= ANIMATIONS (Lottie/Rive) =============
  static const String animationLoading = '$_animationsPath/loading.json';
  static const String animationSuccess = '$_animationsPath/success.json';
  static const String animationError = '$_animationsPath/error.json';
  static const String animationEmpty = '$_animationsPath/empty.json';
  static const String animationNoInternet = '$_animationsPath/no_internet.json';
  static const String animationSearch = '$_animationsPath/search.json';
  static const String animationNotFound = '$_animationsPath/not_found.json';
  static const String animationWelcome = '$_animationsPath/welcome.json';
  static const String animationCelebration = '$_animationsPath/celebration.json';
  static const String animationHeart = '$_animationsPath/heart.json';
  static const String animationLike = '$_animationsPath/like.json';
  static const String animationStar = '$_animationsPath/star.json';
  static const String animationConfetti = '$_animationsPath/confetti.json';
  static const String animationSplash = '$_animationsPath/splash.json';
  static const String animationTyping = '$_animationsPath/typing.json';
  static const String animationUpload = '$_animationsPath/upload.json';
  static const String animationDownload = '$_animationsPath/download.json';
  static const String animationSync = '$_animationsPath/sync.json';
  static const String animationScan = '$_animationsPath/scan.json';
  static const String animationPayment = '$_animationsPath/payment.json';
  static const String animationDelivery = '$_animationsPath/delivery.json';

  // ============= FONTS =============
  static const String fontPrimary = 'Roboto';
  static const String fontSecondary = 'OpenSans';
  static const String fontHeading = 'Montserrat';
  static const String fontBody = 'Lato';
  static const String fontMonospace = 'RobotoMono';
  static const String fontHandwriting = 'DancingScript';
  static const String fontDisplay = 'Bebas Neue';

  // ============= AUDIO =============
  static const String audioClick = '$_audioPath/click.mp3';
  static const String audioSuccess = '$_audioPath/success.mp3';
  static const String audioError = '$_audioPath/error.mp3';
  static const String audioNotification = '$_audioPath/notification.mp3';
  static const String audioMessage = '$_audioPath/message.mp3';
  static const String audioRingtone = '$_audioPath/ringtone.mp3';
  static const String audioAlert = '$_audioPath/alert.mp3';
  static const String audioTap = '$_audioPath/tap.mp3';
  static const String audioSwipe = '$_audioPath/swipe.mp3';
  static const String audioRefresh = '$_audioPath/refresh.mp3';
  static const String audioPop = '$_audioPath/pop.mp3';
  static const String audioWhoosh = '$_audioPath/whoosh.mp3';
  static const String audioDing = '$_audioPath/ding.mp3';
  static const String audioChime = '$_audioPath/chime.mp3';
  static const String audioBeep = '$_audioPath/beep.mp3';

  // ============= VIDEO =============
  static const String videoIntro = '$_videoPath/intro.mp4';
  static const String videoOnboarding = '$_videoPath/onboarding.mp4';
  static const String videoTutorial = '$_videoPath/tutorial.mp4';
}
//// main.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'core/observers/bloc_observer.dart';
// import 'core/observers/route_observer.dart';
// import 'core/observers/lifecycle_observer.dart';
//
// void main() {
//   // Initialize observers
//   Bloc.observer = AppBlocObserver();
//   AppLifecycleObserver().initialize();
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: AppStrings.appName,
//       theme: ThemeData(
//         primarySwatch: AppColors.primarySwatch,
//         scaffoldBackgroundColor: AppColors.scaffold,
//         appBarTheme: AppBarTheme(
//           elevation: AppDimensions.cardElevationS,
//           backgroundColor: AppColors.primary,
//         ),
//       ),
//       navigatorObservers: [
//         AppRouteObserver(),
//         routeObserver,
//       ],
//       home: SplashScreen(),
//     );
//   }
// }