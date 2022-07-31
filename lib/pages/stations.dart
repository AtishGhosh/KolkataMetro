import 'package:flutter/material.dart';
import 'package:kolkatametro/info.dart';
import 'package:kolkatametro/pages/search.dart';
import 'package:kolkatametro/pages/stationinfo.dart';
import 'package:kolkatametro/theme.dart';

class StationsButton extends StatelessWidget {
  const StationsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const StationsPage(),
        ),
      ),
      child: GridTile(
        footer: const Padding(
          padding: EdgeInsets.only(
            bottom: 6.0,
            left: 10.0,
          ),
          child: Text(
            'Stations',
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
    );
  }
}

class StationsPage extends StatefulWidget {
  const StationsPage({Key? key}) : super(key: key);

  @override
  State<StationsPage> createState() => _StationsPageState();
}

class _StationsPageState extends State<StationsPage> {
  List<RouteStation> routeStationList = [];

  @override
  void initState() {
    super.initState();
    routeStationList = getStationsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'Metro Stations',
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
          {
            routeStationList.sort((a, b) => a.name.compareTo(b.name));
            List<Widget> routeStationBuild = <Widget>[
              Container(
                margin: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(
                      20.0,
                    ),
                    bottomRight: Radius.circular(
                      20.0,
                    ),
                  ),
                  color: Theme.of(context).backgroundColor,
                ),
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 20.0,
                  left: 20,
                  right: 20,
                ),
                child: AspectRatio(
                  aspectRatio: 3,
                  child: InkWell(
                    onTap: () {},
                    child: GridTile(
                      footer: const Padding(
                        padding: EdgeInsets.only(
                          bottom: 6.0,
                          left: 10.0,
                        ),
                        child: Text(
                          'Find Nearest Station',
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
                              'assets/images/pages/stations/nearest.png',
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
            ];
            for (int index = 0; index < routeStationList.length; index++) {
              List<Widget> connectionList = <Widget>[];
              for (Color? connection in routeStationList[index].connections) {
                connectionList.add(
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.brightness_1,
                        color: connection,
                      ),
                      Text(
                        routeStationList[index].lineNumber.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                );
              }
              routeStationBuild.add(
                Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 5.0,
                  ),
                  elevation: 0,
                  color: Theme.of(context).backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ListTile(
                    onTap: (() => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StationInformation(
                              routeStation: getStationInformation(
                                stationCode: routeStationList[index].code,
                              ),
                            ),
                          ),
                        )),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        16.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    title: Text(
                      routeStationList[index].name,
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontSize: 18.0,
                      ),
                    ),
                    subtitle: Text(
                      routeStationList[index].code,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    trailing: routeStationList[index].connections.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: connectionList,
                          )
                        : null,
                  ),
                ),
              );
            }
            return ListView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 10,
              ),
              children: routeStationBuild,
            );
          }
        }),
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              20.0,
            ),
            topRight: Radius.circular(
              20.0,
            ),
          ),
        ),
        padding: const EdgeInsets.all(
          7.5,
        ),
        child: ListTile(
          onTap: (() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchStationsPage(
                  searchList: routeStationList,
                ),
              ),
            );
          }),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                20.0,
              ),
              topRight: Radius.circular(
                20.0,
              ),
            ),
          ),
          leading: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          title: const Text(
            'Search Metro Station',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
