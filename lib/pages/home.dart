import 'package:flutter/material.dart';
import 'package:kolkatametro/info.dart';
import 'package:kolkatametro/pages/cards.dart';
import 'package:kolkatametro/pages/helplines.dart';
import 'package:kolkatametro/pages/information.dart';
import 'package:kolkatametro/pages/map.dart';
import 'package:kolkatametro/pages/routes.dart';
import 'package:kolkatametro/pages/search.dart';
import 'package:kolkatametro/pages/stations.dart';
import 'package:kolkatametro/pages/activities.dart';
import 'package:kolkatametro/pages/timings.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  RouteStation? departureRouteStation;
  RouteStation? arrivalRouteStation;

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
                onTap: (() async {
                  RouteStation selectedDepartureStation = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChooseDepartureStation(),
                    ),
                  );
                  setState(() {
                    departureRouteStation = selectedDepartureStation;
                  });
                }),
                borderRadius: BorderRadius.circular(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    mouseCursor: SystemMouseCursors.click,
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.adjust,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                    title: (departureRouteStation != null
                        ? Text(
                            departureRouteStation!.name,
                            style: TextStyle(
                              color: Theme.of(context).highlightColor,
                            ),
                          )
                        : const Text(
                            'Choose Departure Station',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )),
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Get Route and Fare',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).backgroundColor,
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
                children: const [
                  StationsButton(),
                  RoutesButton(),
                  TimingsButton(),
                  HelplinesButton(),
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
                children: const [
                  CardsButton(),
                  ActivitiesButton(),
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
