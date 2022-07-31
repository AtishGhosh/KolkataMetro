import 'package:flutter/material.dart';
import 'package:kolkatametro/info.dart';
import 'package:kolkatametro/pages/home.dart';
import 'package:kolkatametro/theme.dart';
import 'package:dynamic_color/dynamic_color.dart';

// flutter run -d edge --web-renderer html

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initData();
    initTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: systemThemeMode,
      builder: ((context, value, _) {
        return DynamicColorBuilder(builder: ((
          ColorScheme? lightColorScheme,
          ColorScheme? darkColorScheme,
        ) {
          if (lightColorScheme == null || darkColorScheme == null) {
            return MaterialApp(
              title: 'Kolkata Metro',
              home: const Homepage(),
              debugShowCheckedModeBanner: false,
              themeMode: value,
              theme: lightThemeData,
              darkTheme: darkThemeData,
            );
          } else {
            return MaterialApp(
              title: 'Kolkata Metro',
              home: const Homepage(),
              debugShowCheckedModeBanner: false,
              themeMode: value,
              theme: lightThemeData.copyWith(colorScheme: lightColorScheme),
              darkTheme: darkThemeData.copyWith(colorScheme: darkColorScheme),
            );
          }
        }));
      }),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  AppBar homeAppBar({required BuildContext context}) {
    AppBar appBar = AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              right: 8.0,
            ),
            child: Image(
              image: AssetImage('assets/images/root/logo.png'),
              fit: BoxFit.contain,
              width: 34.0,
            ),
          ),
          Text(
            'Kolkata Metro',
            style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: 26.0,
            ),
          ),
        ],
      ),
      systemOverlayStyle: getSystemOverlayStyle(context),
    );

    return appBar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: homeAppBar(context: context),
      body: const HomePageBody(),
    );
  }
}
