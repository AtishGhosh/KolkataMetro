import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
      theme: ThemeData.light(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
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
      toolbarHeight: 72.0,
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              right: 5.0,
            ),
            child: Image(
              image: AssetImage('assets/images/root/logo.png'),
              fit: BoxFit.contain,
              width: 40.0,
            ),
          ),
          Text(
            'Kolkata Metro',
            style: GoogleFonts.montserrat().copyWith(
              color: Colors.black,
              fontSize: 26.0,
            ),
          )
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

  Widget getBodyWidgetList({required BuildContext context}) {
    Widget body = ListView(
      scrollDirection: Axis.vertical,
      children: [
        const Image(
          image: AssetImage('assets/images/home/metro.png'),
          fit: BoxFit.cover,
          height: 240.0,
        ),
        Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              margin: const EdgeInsets.only(
                top: 10.0,
                bottom: 2.5,
                left: 10.0,
                right: 10.0,
              ),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    mouseCursor: SystemMouseCursors.click,
                    leading: Icon(
                      Icons.adjust,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    title: Text(
                      'Choose Departure Station',
                      style: GoogleFonts.montserrat().copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              margin: const EdgeInsets.only(
                top: 2.5,
                bottom: 10.0,
                left: 10.0,
                right: 10.0,
              ),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    mouseCursor: SystemMouseCursors.click,
                    leading: Icon(
                      Icons.brightness_1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    title: Text(
                      'Choose Arrival Station',
                      style: GoogleFonts.montserrat().copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            MaterialButton(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Get Route and Fare',
                  style: GoogleFonts.montserrat().copyWith(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
              disabledColor: Colors.grey,
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 12.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                padding: const EdgeInsets.all(28.0),
                childAspectRatio: 1,
                mainAxisSpacing: 28.0,
                crossAxisSpacing: 28.0,
                children: [
                  InkWell(
                    onTap: () {},
                    child: GridTile(
                      footer: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 6.0,
                          left: 10.0,
                        ),
                        child: Text(
                          'Stations',
                          style: GoogleFonts.montserrat().copyWith(
                            color: Colors.white,
                            fontSize: 26.0,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/home/station.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0),
                                Colors.black.withOpacity(0.8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: GridTile(
                      footer: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 6.0,
                          left: 10.0,
                        ),
                        child: Text(
                          'Routes',
                          style: GoogleFonts.montserrat().copyWith(
                            color: Colors.white,
                            fontSize: 26.0,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/home/route.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0),
                                Colors.black.withOpacity(0.8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: GridTile(
                      footer: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 6.0,
                          left: 10.0,
                        ),
                        child: Text(
                          'Timings',
                          style: GoogleFonts.montserrat().copyWith(
                            color: Colors.white,
                            fontSize: 26.0,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/home/timing.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0),
                                Colors.black.withOpacity(0.8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: GridTile(
                      footer: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 6.0,
                          left: 10.0,
                        ),
                        child: Text(
                          'Helplines',
                          style: GoogleFonts.montserrat().copyWith(
                            color: Colors.white,
                            fontSize: 26.0,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/home/helpline.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0),
                                Colors.black.withOpacity(0.8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 28.0,
                  right: 28.0,
                ),
                child: AspectRatio(
                  aspectRatio: 2.2,
                  child: InkWell(
                    onTap: () {},
                    child: GridTile(
                      footer: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 6.0,
                          left: 10.0,
                        ),
                        child: Text(
                          'Metro Map',
                          style: GoogleFonts.montserrat().copyWith(
                            color: Colors.white,
                            fontSize: 26.0,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/home/map.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0),
                                Colors.black.withOpacity(0.85),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                padding: const EdgeInsets.all(28.0),
                childAspectRatio: 1,
                mainAxisSpacing: 28.0,
                crossAxisSpacing: 28.0,
                children: [
                  InkWell(
                    onTap: () {},
                    child: GridTile(
                      footer: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 6.0,
                          left: 10.0,
                        ),
                        child: Text(
                          'Cards',
                          style: GoogleFonts.montserrat().copyWith(
                            color: Colors.white,
                            fontSize: 26.0,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/home/card.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0),
                                Colors.black.withOpacity(0.8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: GridTile(
                      footer: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 6.0,
                          left: 10.0,
                        ),
                        child: Text(
                          'Activities',
                          style: GoogleFonts.montserrat().copyWith(
                            color: Colors.white,
                            fontSize: 26.0,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/home/now-in-kolkata.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0),
                                Colors.black.withOpacity(0.8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 28.0,
                  right: 28.0,
                  bottom: 28.0,
                ),
                child: AspectRatio(
                  aspectRatio: 2.2,
                  child: InkWell(
                    onTap: () {},
                    child: GridTile(
                      footer: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 6.0,
                          left: 10.0,
                        ),
                        child: Text(
                          'Information',
                          style: GoogleFonts.montserrat().copyWith(
                            color: Colors.white,
                            fontSize: 26.0,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/home/info.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0),
                                Colors.black.withOpacity(0.85),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );

    return body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          72.0,
        ),
        child: homeAppBar(context: context),
      ),
      body: getBodyWidgetList(context: context),
    );
  }
}
