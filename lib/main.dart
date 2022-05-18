import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kolkatametro/pages/home.dart';

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
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
        scaffoldBackgroundColor: Colors.grey[200],
      ),
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
      backgroundColor: Colors.white,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Padding(
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
              color: Colors.black,
              fontSize: 26.0,
            ),
          ),
        ],
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
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
