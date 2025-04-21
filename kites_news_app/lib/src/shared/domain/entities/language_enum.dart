import '../../../../main.dart';
import '../../../core/translations/l10n.dart';

enum LanguageEnum {
  ar, // Arabic
  en, // English
  sp, // Spanish
}

extension LanguageEnumExtension on LanguageEnum {
  String get local {
    switch (this) {
      case LanguageEnum.ar:
        return "ar";

      case LanguageEnum.en:
        return "en";
      case LanguageEnum.sp:
        return "sp";
    }
  }

  String get localHeader {
    switch (this) {
      case LanguageEnum.ar:
        return "ar_AE";

      case LanguageEnum.en:
        return "en_US";
      case LanguageEnum.sp:
        return "es_ES";
    }
  }

  String get langName {
    switch (this) {
      case LanguageEnum.ar:
        return S.of(navigatorKey.currentContext!).arabic;

      case LanguageEnum.en:
        return S.of(navigatorKey.currentContext!).english;
      case LanguageEnum.sp:
        return S.of(navigatorKey.currentContext!).spanish;
    }
  }
}
