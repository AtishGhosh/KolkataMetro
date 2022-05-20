import 'package:flutter/material.dart';
import 'package:kolkatametro/info.dart';
import 'package:kolkatametro/theme.dart';

class RoutesButton extends StatelessWidget {
  const RoutesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RouteList(),
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
            'Routes',
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
    );
  }
}

class RouteList extends StatefulWidget {
  const RouteList({Key? key}) : super(key: key);

  @override
  State<RouteList> createState() => _RouteListState();
}

class _RouteListState extends State<RouteList> {
  late Future<List<RouteInfo>> dataFuture;

  @override
  void initState() {
    super.initState();
    dataFuture = getRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 62,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'Metro Routes',
          style: TextStyle(
            color: Theme.of(context).highlightColor,
            fontSize: 25.0,
          ),
        ),
        leading: getAppBarBackButton(context),
        systemOverlayStyle: getSystemOverlayStyle(context),
      ),
      body: FutureBuilder(
        future: dataFuture,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          } else if (snapshot.hasData) {
            List<RouteInfo> routeData = snapshot.data as List<RouteInfo>;
            return ListView.builder(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
                left: 5.0,
                right: 5.0,
              ),
              itemCount: routeData.length,
              itemBuilder: (context, index) {
                return Card(
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoutePage(
                            routeName: routeData[index].name,
                            routeNumber: routeData[index].lineNumber,
                            routeColor: routeData[index].colorCode,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        mouseCursor: SystemMouseCursors.click,
                        leading: setListTileIcon(
                          icon: Icon(
                            Icons.brightness_1,
                            color: routeData[index].colorCode,
                          ),
                        ),
                        title: Text(
                          routeData[index].name,
                          style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontSize: 20.0,
                          ),
                        ),
                        subtitle: Text(
                          'Line ${routeData[index].lineNumber}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
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

class RoutePage extends StatefulWidget {
  final String routeName;
  final int routeNumber;
  final Color? routeColor;
  const RoutePage({
    Key? key,
    required this.routeName,
    required this.routeNumber,
    required this.routeColor,
  }) : super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  late Future<List<RouteStation>> dataFuture;

  @override
  void initState() {
    super.initState();
    dataFuture = getRouteStations(routeNumber: widget.routeNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 62,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.routeName,
              style: TextStyle(
                color: Theme.of(context).highlightColor,
                fontSize: 20.0,
              ),
            ),
            Text(
              'Line ${widget.routeNumber}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        leading: getAppBarBackButton(context),
        systemOverlayStyle: getSystemOverlayStyle(context),
      ),
      body: FutureBuilder(
        future: dataFuture,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          } else if (snapshot.hasData) {
            List<RouteStation> routeList = snapshot.data as List<RouteStation>;
            return ListView.builder(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
                left: 5.0,
                right: 5.0,
              ),
              itemCount: routeList.length,
              itemBuilder: (context, index) {
                List<Icon> connectionList = <Icon>[];
                for (Color? connectionColor in routeList[index].connections) {
                  connectionList.add(
                    Icon(
                      Icons.brightness_1,
                      color: connectionColor,
                    ),
                  );
                }
                return Card(
                  elevation: 0,
                  color: Theme.of(context).backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ),
                  ),
                  margin: const EdgeInsets.only(
                    top: 5.0,
                    bottom: 5.0,
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(
                        10.0,
                      ),
                      child: ListTile(
                        mouseCursor: SystemMouseCursors.click,
                        leading: setListTileIcon(
                          icon: Icon(
                            Icons.brightness_1,
                            color: widget.routeColor,
                          ),
                        ),
                        title: Text(
                          routeList[index].name,
                          style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontSize: 20.0,
                          ),
                        ),
                        subtitle: Text(
                          routeList[index].code,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                        trailing: routeList[index].connections.isNotEmpty
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
                );
              },
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