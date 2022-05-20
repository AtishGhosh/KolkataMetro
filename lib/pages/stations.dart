import 'package:flutter/material.dart';
import 'package:kolkatametro/info.dart';
import 'package:kolkatametro/theme.dart';

class StationsButton extends StatelessWidget {
  const StationsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StationsPage(),
          ),
        );
      },
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
  late Future<List<RouteStation>> routeStationListFuture;

  @override
  void initState() {
    super.initState();
    routeStationListFuture = getStationsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 62,
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
      body: FutureBuilder(
        future: routeStationListFuture,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          } else if (snapshot.hasData) {
            List<RouteStation> routeStationList =
                snapshot.data as List<RouteStation>;
            // someObjects.sort((a, b) => a.someProperty.compareTo(b.someProperty));
            routeStationList.sort((a, b) => a.name.compareTo(b.name));
            List<Widget> routeStationBuild = <Widget>[];
            for (int index = 0; index < routeStationList.length; index++) {
              List<Icon> connectionList = <Icon>[];
              for (Color? connection in routeStationList[index].connections) {
                connectionList.add(Icon(
                  Icons.brightness_1,
                  color: connection,
                ));
              }
              routeStationBuild.add(Card(
                elevation: 0,
                color: Theme.of(context).backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                margin: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 5.0,
                  left: 10.0,
                  right: 10.0,
                ),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      4.0,
                    ),
                    child: ListTile(
                      mouseCursor: SystemMouseCursors.click,
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
                ),
              ));
            }
            return ListView(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
                left: 5.0,
                right: 5.0,
              ),
              children: routeStationBuild,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}
