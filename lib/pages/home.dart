import 'package:flutter/material.dart';
import 'package:kolkatametro/pages/helplines.dart';
import 'package:kolkatametro/pages/information.dart';
import 'package:kolkatametro/pages/map.dart';
import 'package:kolkatametro/pages/routes.dart';
import 'package:kolkatametro/pages/stations.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        const Image(
          image: AssetImage('assets/images/home/metro.png'),
          fit: BoxFit.cover,
          height: 200.0,
        ),
        Column(
          children: [
            Card(
              elevation: 0,
              color: Theme.of(context).backgroundColor,
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
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: const Text(
                      'Choose Departure Station',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 0,
              color: Theme.of(context).backgroundColor,
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
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: const Text(
                      'Choose Arrival Station',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            MaterialButton(
              elevation: 0,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Get Route and Fare',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  36.0,
                ),
              ),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 12.0),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.only(
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
                  const StationsButton(),
                  const RoutesButton(),
                  InkWell(
                    onTap: () {},
                    child: GridTile(
                      footer: const Padding(
                        padding: EdgeInsets.only(
                          bottom: 6.0,
                          left: 10.0,
                        ),
                        child: Text(
                          'Timings',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
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
                  const HelplinesButton(),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 28.0,
                  right: 28.0,
                ),
                child: AspectRatio(
                  aspectRatio: 2.2,
                  child: MetroMapButton(),
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
                      footer: const Padding(
                        padding: EdgeInsets.only(
                          bottom: 6.0,
                          left: 10.0,
                        ),
                        child: Text(
                          'Cards',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
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
                      footer: const Padding(
                        padding: EdgeInsets.only(
                          bottom: 6.0,
                          left: 10.0,
                        ),
                        child: Text(
                          'Activities',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
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
              const InformationButton(),
            ],
          ),
        )
      ],
    );
  }
}
