import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

const String assetInfoPath = 'lines/info.xlsx';

class RouteStation {
  String name;
  String code;
  String duration;
  String platform;

  RouteStation(
      {required this.name,
      required this.code,
      required this.duration,
      required this.platform});
}

class Route {
  String departure;
  String departureCode;
  String arrival;
  String arrivalCode;
  String direction;
  double distance;
  String duration;
  int fare;
  List<RouteStation> stations;

  Route(
      {required this.departure,
      required this.departureCode,
      required this.arrival,
      required this.arrivalCode,
      required this.direction,
      required this.distance,
      required this.duration,
      required this.fare,
      required this.stations});
}

String getAssetFilePath({required String lineNumber}) =>
    'lines/' + lineNumber.replaceAll(' ', '').toLowerCase() + '.xlsx';

int getLineInt({required String lineNumber}) =>
    int.parse(lineNumber.replaceAll(RegExp(r'[^0-9]'), ''));

int getNumberOfLines({required var data}) => data.tables.length;

String setLineNumber({required var data, required String stationCode}) {
  var file = data;

  for (var table in file.tables.keys) {
    for (var row in file.tables[table].rows) {
      if (row[0] != null && stationCode == row[0].value) {
        return table;
      }
    }
  }

  String error = 'Error: Could not find LINE NUMBER for station $stationCode.';
  return error;
}

String getLineNumber(
    {required var data,
    required String departureCode,
    required String arrivalCode}) {
  String departureLine = setLineNumber(data: data, stationCode: departureCode);
  String arrivalLine = setLineNumber(data: data, stationCode: arrivalCode);

  if (departureLine == arrivalLine) {
    return departureLine;
  } else {
    String error =
        'Error: Could not find LINE NUMBER for stations $departureCode and $departureCode.';
    return error;
  }
}

int getStationIndex({required var data, required String stationCode}) {
  var file = data;

  for (var table in file.tables.keys) {
    for (var row in file.tables[table].rows) {
      if (row[0] != null && stationCode == row[0].value) {
        return row[0].rowIndex;
      }
    }
  }

  // String error = 'Error: Could not find STATION NUMBER for station $stationCode.';
  return 0;
}

String getRouteDirection(
    {required var data,
    required String departureCode,
    required String arrivalCode}) {
  int departureIndex = 0, arrivalIndex = 0;

  departureIndex = getStationIndex(data: data, stationCode: departureCode);
  arrivalIndex = getStationIndex(data: data, stationCode: arrivalCode);

  if (departureIndex > arrivalIndex) {
    return 'UP';
  } else if (departureIndex < arrivalIndex) {
    return 'DOWN';
  } else {
    String error =
        'Error: Could not find ROUTE DIRECTION for stations $departureCode and $departureCode.';
    return error;
  }
}

String getStationName({required var data, required String stationCode}) {
  var file = data;

  for (var table in file.tables.keys) {
    for (var row in file.tables[table].rows) {
      if (row[0] != null && stationCode == row[0].value) {
        return row[1].value;
      }
    }
  }

  String error = 'Error: Could not find STATION NAME for station $stationCode.';
  return error;
}

List<String> getLineStationList(
    {required var data, required String lineNumber}) {
  var file = data;
  List<String> list = [];

  for (var table in file.tables.keys) {
    if (table == lineNumber) {
      for (var row in file.tables[table].rows) {
        if (row[0] != null) {
          list.add(row[0].value);
        }
      }
      return list;
    }
  }

  return ['Error: STATION LIST not found for $lineNumber.'];
}

Future<String> getRouteInformation(
    {required String departureCode, required String arrivalCode}) async {
  ByteData data = await rootBundle.load(assetInfoPath);
  var lineInfo =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var file = Excel.decodeBytes(lineInfo);

  String departure = getStationName(data: file, stationCode: departureCode);
  String arrival = getStationName(data: file, stationCode: arrivalCode);
  String direction = getRouteDirection(
      data: file, departureCode: departureCode, arrivalCode: arrivalCode);
  String lineNumber = getLineNumber(
      data: file, departureCode: departureCode, arrivalCode: arrivalCode);

  return ('Departure: $departure\nArrival: $arrival\nDirection: $direction\nLine Number: ${getLineInt(lineNumber: lineNumber)}');
}

// Working on this RN

Future<String> getDistanceGraph() async {
  ByteData data = await rootBundle.load(assetInfoPath);
  var lineInfo =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var file = Excel.decodeBytes(lineInfo);

  List<String> stationList = [];

  for (var table in file.tables.keys) {
    for (var row in file.tables[table]!.rows) {
      if (row[0] != null) {
        if (!(stationList.contains(row[0]?.value))) {
          stationList.add(row[0]?.value);
        }
      }
    }
  }

  var stationGrid = List.generate(
      stationList.length, (i) => List.filled(stationList.length, 0.0),
      growable: false);

  for (int lineNumber = 1;
      lineNumber <= getNumberOfLines(data: file);
      lineNumber++) {
    String lineNumberPath = getAssetFilePath(lineNumber: 'Line $lineNumber');

    ByteData dataLine = await rootBundle.load(lineNumberPath);
    var fileLineInfo = dataLine.buffer
        .asUint8List(dataLine.offsetInBytes, dataLine.lengthInBytes);
    var fileLine = Excel.decodeBytes(fileLineInfo);

    int rowKey = 0;
    var table = fileLine.tables['Distance'];
    for (var row in table!.rows) {
      String? cellValue = row[0]?.value.toString();
      if (stationList.contains(cellValue) && rowKey + 2 < table.maxRows) {
        double distanceCellValue = table.rows[rowKey + 1][0]?.value;
        String nextStationCellValue = table.rows[rowKey + 2][0]?.value;

        int index1 = stationList.indexWhere((item) => item == cellValue);
        int index2 =
            stationList.indexWhere((item) => item == nextStationCellValue);

        stationGrid[index1][index2] = distanceCellValue;
        stationGrid[index2][index1] = distanceCellValue;
      }

      rowKey++;
    }

    for (int i = 0; i < stationList.length; i++) {
      for (int j = 0; j < stationList.length; j++) {
        if (i == j) {
          continue;
        } else if (stationGrid[i][j] != 0) {
          continue;
        } else {
          stationGrid[i][j] = double.infinity;
        }
      }
    }
  }

  return 'str';
}
