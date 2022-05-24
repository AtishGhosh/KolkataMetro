import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
  scaffoldBackgroundColor: Colors.grey[200],
  backgroundColor: Colors.white,
  highlightColor: Colors.black,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
    },
  ),
);

ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  textTheme: GoogleFonts.montserratTextTheme(),
  scaffoldBackgroundColor: Colors.grey[900],
  backgroundColor: Colors.black,
  highlightColor: Colors.white,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
    },
  ),
);

final ValueNotifier<ThemeMode> systemThemeMode =
    ValueNotifier<ThemeMode>(ThemeMode.system);

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
                onTap: (() {
                  systemThemeMode.value = ThemeMode.system;
                }),
                mouseCursor: SystemMouseCursors.click,
                leading: setListTileIcon(
                  icon: const Icon(
                    Icons.brightness_auto,
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
                onTap: (() {
                  systemThemeMode.value = ThemeMode.light;
                }),
                mouseCursor: SystemMouseCursors.click,
                leading: setListTileIcon(
                  icon: const Icon(
                    Icons.brightness_high,
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
                onTap: (() {
                  systemThemeMode.value = ThemeMode.dark;
                }),
                mouseCursor: SystemMouseCursors.click,
                leading: setListTileIcon(
                  icon: const Icon(
                    Icons.brightness_high,
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
