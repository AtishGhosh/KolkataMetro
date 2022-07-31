import 'package:flutter/material.dart';
import 'package:kolkatametro/info.dart';
import 'package:kolkatametro/pages/routes.dart';
import 'package:kolkatametro/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class StationInformation extends StatelessWidget {
  final RouteStation routeStation;

  const StationInformation({
    Key? key,
    required this.routeStation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          routeStation.code,
          style: TextStyle(
            color: Theme.of(context).highlightColor,
            fontSize: 25.0,
          ),
        ),
        leading: getAppBarBackButton(context),
        systemOverlayStyle: getSystemOverlayStyle(context),
      ),
      body: Builder(
        builder: ((context) {
          Widget header = Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(
                  20.0,
                ),
                bottomRight: Radius.circular(
                  20.0,
                ),
              ),
            ),
            padding: const EdgeInsets.only(
              top: 28.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: routeStation.area != ''
                      ? const EdgeInsets.only(
                          bottom: 10.0,
                        )
                      : EdgeInsets.zero,
                  child: Text(
                    routeStation.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 34.0,
                  ),
                  child: routeStation.area != ''
                      ? Text(
                          routeStation.area + ' area',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        )
                      : Container(),
                ),
                Card(
                  elevation: 0,
                  color: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 10.0,
                  ),
                  child: ListTile(
                    onTap: () => launchUrl(
                      Uri.parse(routeStation.mapLink),
                      mode: LaunchMode.externalApplication,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 20.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        16.0,
                      ),
                    ),
                    mouseCursor: SystemMouseCursors.click,
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map,
                          color: Theme.of(context).backgroundColor,
                        ),
                      ],
                    ),
                    title: Text(
                      'Get Map Location',
                      style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                        fontSize: 18.0,
                      ),
                    ),
                    subtitle: Text(
                      '${(routeStation.latitude).toStringAsFixed(3)}°N, ${(routeStation.longitude).toStringAsFixed(3)}°S',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
          return ListView(
            children: [
              header,
              Padding(
                padding: const EdgeInsets.only(
                  left: 14.0,
                  top: 14.0,
                ),
                child: Text(
                  routeStation.connections.length > 1 ? 'Lines' : 'Line',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).highlightColor,
                  ),
                ),
              ),
              getStationInfoLines(
                context: context,
                connections: routeStation.connections,
              ),
            ],
          );
        }),
      ),
    );
  }

  Column getStationInfoLines({
    required BuildContext context,
    required List<Color?> connections,
  }) {
    List<Widget> stationInfoLinesColumn = [];
    for (Color? connection in connections) {
      stationInfoLinesColumn.add(Card(
        elevation: 0,
        color: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16.0,
          ),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        child: ListTile(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoutePage(
                routeName: routeNames[routeColorCodes.indexOf(connection)],
                routeNumber: routeColorCodes.indexOf(connection) + 1,
                routeColor: connection,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 20.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16.0,
            ),
          ),
          mouseCursor: SystemMouseCursors.click,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.brightness_1,
                color: connection,
              ),
            ],
          ),
          title: Text(
            routeNames[routeColorCodes.indexOf(connection)],
            style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: 18.0,
            ),
          ),
          subtitle: Text(
            'Line ${routeColorCodes.indexOf(connection) + 1}',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: stationInfoLinesColumn,
    );
  }
}
