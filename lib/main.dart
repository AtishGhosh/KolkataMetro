import 'package:flutter/material.dart';
import 'package:kolkatametro/pages/home.dart';
import 'package:kolkatametro/theme.dart';

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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kolkata Metro',
      home: const Homepage(),
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: darkThemeData,
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
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 62,
      backgroundColor: Theme.of(context).backgroundColor,
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
      appBar: homeAppBar(context: context),
      body: const HomePageBody(),
    );
  }
}
