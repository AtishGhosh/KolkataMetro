import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kolkatametro/info.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget setListTileIcon({required Icon icon}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Icon>[icon],
  );
}

SystemUiOverlayStyle getSystemOverlayStyle(BuildContext context) {
  return SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness:
        Theme.of(context).brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
    statusBarIconBrightness: Theme.of(context).brightness == Brightness.light
        ? Brightness.dark
        : Brightness.light,
  );
}

IconButton getAppBarBackButton(BuildContext context) {
  return IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: Icon(
      Icons.arrow_back,
      color: Theme.of(context).highlightColor,
    ),
  );
}

ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  textTheme: GoogleFonts.montserratTextTheme(),
  backgroundColor: Colors.white,
  highlightColor: Colors.black,
  scaffoldBackgroundColor: Colors.grey[200],
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
    },
  ),
);

ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  textTheme: GoogleFonts.montserratTextTheme(),
  backgroundColor: Colors.black,
  highlightColor: Colors.white,
  scaffoldBackgroundColor: Colors.grey[900],
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
    },
  ),
);

final ValueNotifier<ThemeMode> systemThemeMode =
    ValueNotifier<ThemeMode>(ThemeMode.system);

Future<void> initTheme() async {
  final themePrefs = await SharedPreferences.getInstance();
  final int? themePreference = themePrefs.getInt('theme');
  if (themePreference == 2) {
    systemThemeMode.value = ThemeMode.dark;
  } else if (themePreference == 1) {
    systemThemeMode.value = ThemeMode.light;
  } else {
    systemThemeMode.value = ThemeMode.system;
  }
}

Future<void> showThemeDialog({required BuildContext context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Set Theme Setting',
          style: TextStyle(
            color: Theme.of(context).highlightColor,
          ),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 0,
              color: Theme.of(context).backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 5.0,
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 20.0,
                ),
                onTap: (() async {
                  await prefs.setInt('theme', 0);
                  systemThemeMode.value = ThemeMode.system;
                  Navigator.of(context).pop();
                }),
                mouseCursor: SystemMouseCursors.click,
                leading: setListTileIcon(
                  icon: Icon(
                    Icons.brightness_auto,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  'System',
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: 18.0,
                  ),
                ),
                trailing: Icon(
                  Icons.check_circle,
                  color: systemThemeMode.value == ThemeMode.system
                      ? Colors.green
                      : Colors.transparent,
                ),
              ),
            ),
            Card(
              elevation: 0,
              color: Theme.of(context).backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 5.0,
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 20.0,
                ),
                onTap: (() async {
                  await prefs.setInt('theme', 1);
                  systemThemeMode.value = ThemeMode.light;
                  Navigator.of(context).pop();
                }),
                mouseCursor: SystemMouseCursors.click,
                leading: setListTileIcon(
                  icon: Icon(
                    Icons.brightness_high,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  'Light',
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: 18.0,
                  ),
                ),
                trailing: Icon(
                  Icons.check_circle,
                  color: systemThemeMode.value == ThemeMode.light
                      ? Colors.green
                      : Colors.transparent,
                ),
              ),
            ),
            Card(
              elevation: 0,
              color: Theme.of(context).backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 5.0,
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 20.0,
                ),
                onTap: (() async {
                  await prefs.setInt('theme', 2);
                  systemThemeMode.value = ThemeMode.dark;
                  Navigator.of(context).pop();
                }),
                mouseCursor: SystemMouseCursors.click,
                leading: setListTileIcon(
                  icon: Icon(
                    Icons.brightness_low,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  'Dark',
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: 18.0,
                  ),
                ),
                trailing: Icon(
                  Icons.check_circle,
                  color: systemThemeMode.value == ThemeMode.dark
                      ? Colors.green
                      : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
