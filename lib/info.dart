import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String assetInfoPath = 'assets/lines/info.xlsx';

List<String> routeNames = <String>[
  'North-South Corridor',
  'East-West Corridor',
];

List<Color?> routeColorCodes = <Color?>[
  Colors.blue[800],
  Colors.green[700],
];

class RouteInfo {
  String name;
  int lineNumber;
  Color? colorCode;
  RouteInfo({
    required this.name,
    required this.lineNumber,
    required this.colorCode,
  });
}

Future<List<RouteInfo>> getRoutes() async {
  ByteData data = await rootBundle.load(assetInfoPath);
  var lineInfo =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var file = Excel.decodeBytes(lineInfo);

  List<RouteInfo> routeList = [];

  for (int routeNumber = 0;
      routeNumber < file.tables.keys.length;
      routeNumber++) {
    routeList.add(
      RouteInfo(
        name: routeNames[routeNumber],
        lineNumber: routeNumber + 1,
        colorCode: routeColorCodes[routeNumber],
      ),
    );
  }

  return routeList;
}

class RouteStation {
  String name;
  String code;
  List<Color?> connections;
  RouteStation({
    required this.name,
    required this.code,
    required this.connections,
  });
}

Future<List<RouteStation>> getRouteStations({required int routeNumber}) async {
  ByteData data = await rootBundle.load(assetInfoPath);
  var lineInfo =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var file = Excel.decodeBytes(lineInfo);

  List<RouteStation> stationList = [];

  for (var row in file.tables['Line $routeNumber']!.rows) {
    List<Color?> connections = [];
    int routeCounter = 0;

    for (var table in file.tables.keys) {
      routeCounter += 1;
      if (table == 'Line $routeNumber') {
        continue;
      }

      for (var connectionrow in file.tables[table]!.rows) {
        if (connectionrow[0] != null) {
          if (connectionrow[0]?.value == row[0]?.value) {
            connections.add(routeColorCodes[routeCounter - 1]);
          }
        }
      }
    }

    if (row[0] != null) {
      stationList.add(RouteStation(
        name: row[1]?.value,
        code: row[0]?.value,
        connections: connections,
      ));
    }
  }

  return stationList;
}

Future<List<RouteStation>> getStationsList() async {
  ByteData data = await rootBundle.load(assetInfoPath);
  var lineInfo =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var file = Excel.decodeBytes(lineInfo);

  List<RouteStation> stationList = <RouteStation>[];

  for (var table in file.tables.keys) {
    for (var row in file.tables[table]!.rows) {
      if (row[0] != null) {
        if (!(stationList.contains(row[0]?.value))) {
          List<Color?> connections = <Color?>[];
          int routeCounter = 0;

          for (var table in file.tables.keys) {
            routeCounter += 1;

            for (var connectionrow in file.tables[table]!.rows) {
              if (connectionrow[0] != null) {
                if (connectionrow[0]?.value == row[0]?.value) {
                  connections.add(routeColorCodes[routeCounter - 1]);
                }
              }
            }
          }

          stationList.add(RouteStation(
            name: row[1]?.value,
            code: row[0]?.value,
            connections: connections,
          ));
        }
      }
    }
  }

  return stationList;
}
