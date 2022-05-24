import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String assetInfoPath = 'assets/lines/info.xlsx';

List<String> routeNames = <String>[
  'North-South Corridor',
  'East-West Corridor',
];

List<Color?> routeColorCodes = <Color?>[
  Colors.blue[700],
  Colors.green[700],
];

late Excel excelData;

Future<void> initData() async {
  ByteData data = await rootBundle.load(assetInfoPath);
  var lineInfo =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  excelData = Excel.decodeBytes(lineInfo);
}

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

List<RouteInfo> getRoutes() {
  var file = excelData;

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
  int lineNumber;
  List<Color?> connections;
  RouteStation({
    required this.name,
    required this.code,
    required this.connections,
    required this.lineNumber,
  });
}

List<RouteStation> getRouteStations({required int routeNumber}) {
  var file = excelData;

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
        lineNumber: routeNumber,
      ));
    }
  }

  return stationList;
}

List<RouteStation> getStationsList() {
  var file = excelData;

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
            lineNumber: int.parse(table.replaceAll(RegExp(r'[^0-9]'), '')),
          ));
        }
      }
    }
  }

  return stationList;
}
