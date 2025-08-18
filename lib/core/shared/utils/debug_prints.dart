import 'package:flutter/foundation.dart';

void printWarning(Object obj) {
  if (kDebugMode) {
    print('\x1B[33m$obj\x1B[0m');
  }
}

void printError(Object obj) {
  if (kDebugMode) {
    print('\x1B[31m$obj\x1B[0m');
  }
}

void printInfo(Object obj) {
  if (kDebugMode) {
    print('\x1B[34m$obj\x1B[0m');
  }
}

void printDone(Object obj) {
  if (kDebugMode) {
    print('\x1B[32m$obj\x1B[0m');
  }
}
void debugPrintSynchronously(String message) {
  debugPrint('🔍 $message');
}

//printWarning("تحذير: الاتصال بالإنترنت ضعيف");
// printError("خطأ: فشل في تحميل البيانات");
// printInfo("معلومة: بدأ التحميل...");
// printDone("تم التحميل بنجاح ✅");
// debugPrintSynchronously("هذا طباعة متزامنة للمساعدة في تتبع الأخطاء");