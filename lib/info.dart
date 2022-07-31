import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String assetInfoPath = 'assets/lines/info.xlsx';

List<String> routeNames = <String>[
  'North-South Corridor',
  'East-West Corridor',
];

List<Color?> routeColorCodes = <Color?>[
  Colors.blue[700],
  Colors.green[700],
];

List<String> routeMapLinks = <String>[
  'https://goo.gl/maps/7UsoYg5uQsGpsNfQA',
  'https://goo.gl/maps/ctMuTAuNr3XWkMPv5',
];

late Excel excelData;

late SharedPreferences prefs;

Future<void> initData() async {
  ByteData data = await rootBundle.load(assetInfoPath);
  var lineInfo =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  excelData = Excel.decodeBytes(lineInfo);
  prefs = await SharedPreferences.getInstance();
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
  String area;
  double latitude;
  double longitude;
  String mapLink;
  RouteStation({
    required this.name,
    required this.code,
    required this.connections,
    required this.area,
    required this.lineNumber,
    required this.latitude,
    required this.longitude,
    required this.mapLink,
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
        area: row[2]?.value ?? '',
        latitude: double.parse(row[3]?.value.toString() ?? '0'),
        longitude: double.parse(row[4]?.value.toString() ?? '0'),
        mapLink: row[5]?.value,
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
            area: row[2]?.value ?? '',
            latitude: double.parse(row[3]?.value.toString() ?? '0'),
            longitude: double.parse(row[4]?.value.toString() ?? '0'),
            mapLink: row[5]?.value,
          ));
        }
      }
    }
  }

  return stationList;
}

RouteStation getStationInformation({required String stationCode}) {
  List<RouteStation> stationsList = getStationsList();

  for (RouteStation stationInfo in stationsList) {
    if (stationInfo.code == stationCode) {
      return stationInfo;
    }
  }

  return RouteStation(
      name: '',
      code: '',
      connections: [],
      area: '',
      lineNumber: 1,
      latitude: 0,
      longitude: 0,
      mapLink: '');
}
