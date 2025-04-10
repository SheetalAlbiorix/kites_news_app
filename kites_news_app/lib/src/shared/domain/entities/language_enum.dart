
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
      default:
        return "1";
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
      default:
        return "en_US";
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

      default:
        return S.of(navigatorKey.currentContext!).english;
    }
  }
}
