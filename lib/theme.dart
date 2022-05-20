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
