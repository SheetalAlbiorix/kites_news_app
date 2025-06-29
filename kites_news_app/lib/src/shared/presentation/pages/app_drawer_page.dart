import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../../../core/helper/helper.dart';
import '../../../core/translations/l10n.dart';
import '../../data/data_sources/app_shared_prefs.dart';
import '../../domain/entities/language_enum.dart';

class AppDrawerPage extends StatefulWidget {
  const AppDrawerPage({Key? key}) : super(key: key);

  @override
  State<AppDrawerPage> createState() => _AppDrawerPageState();
}

class _AppDrawerPageState extends State<AppDrawerPage> {
  LanguageEnum selectedLanguage = Helper.getLang();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: kToolbarHeight,
          ),

          // Language
          Text(
            S.of(context).language,
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          // Arabic language
          Theme(
            data: ThemeData(unselectedWidgetColor: Theme.of(context).iconTheme.color),
            child: RadioListTile(
              activeColor: selectedLanguage != LanguageEnum.ar
                  ? Theme.of(context).iconTheme.color
                  : Theme.of(context).cardColor,
              contentPadding: EdgeInsets.zero,
              title: Text(
                S.of(context).arabic,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              value: LanguageEnum.values[0],
              groupValue: selectedLanguage,
              onChanged: (value) {
                selectedLanguage = value!;

                context.read<AppNotifier>().setLocale(context, selectedLanguage);
                // setState(() {
                //   App.setLocale(context, selectedLanguage);
                // });
              },
            ),
          ),

          // English language
          Theme(
            data: ThemeData(unselectedWidgetColor: Theme.of(context).iconTheme.color),
            child: RadioListTile(
              activeColor: selectedLanguage != LanguageEnum.en
                  ? Theme.of(context).iconTheme.color
                  : Theme.of(context).cardColor,
              contentPadding: EdgeInsets.zero,
              title: Text(
                S.of(context).english,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              value: LanguageEnum.values[1],
              groupValue: selectedLanguage,
              onChanged: (value) {
                selectedLanguage = value!;
                context.read<AppNotifier>().setLocale(context, selectedLanguage);
              },
            ),
          ),

          // Theme
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Helper.isDarkTheme() ? S.of(context).dark_skin : S.of(context).light_skin,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Switch(
                activeColor: Theme.of(context).cardColor,
                value: Helper.isDarkTheme(),
                onChanged: (value) {
                  if (value) {
                    // Dark
                    sl<AppSharedPrefs>().setDarkTheme(true);
                  } else {
                    // Light
                    sl<AppSharedPrefs>().setDarkTheme(false);
                  }
                  context.read<AppNotifier>().toggleTheme();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
