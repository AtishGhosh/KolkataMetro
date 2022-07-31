import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

const String assetInfoPath = 'assets/lines/info.xlsx';

int getNumberOfLines({required var data}) => data.tables.length;

String getAssetFilePath({required String lineNumber}) =>
    'assets/lines/' + lineNumber.replaceAll(' ', '').toLowerCase() + '.xlsx';

int minDistancePosition(
    {required List<double> distances, required List<bool> stationSet}) {
  int minIndex = 0;
  double min = double.infinity;

  for (int i = 0; i < distances.length; i++) {
    if (stationSet[i] == false && distances[i] <= min) {
      min = distances[i];
      minIndex = i;
    }
  }

  return minIndex;
}

Future<List<String>> getDistanceGraph(
    {required String departureCode, required String arrivalCode}) async {
  if (departureCode == '' && arrivalCode == '') {
    return ['Error: No Input Station Code Received'];
  } else if (departureCode == '') {
    return ['Error: Departure Station Code Not Received'];
  } else if (arrivalCode == '') {
    return ['Error: Arrival Station Code Not Received'];
  }

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

  if ((!stationList.contains(departureCode)) &&
      (!stationList.contains(arrivalCode))) {
    return [
      'Error : Departure Station Code ' +
          departureCode +
          ' and Arrival Station Code ' +
          arrivalCode +
          ' Not Found'
    ];
  } else if (!stationList.contains(departureCode)) {
    return ['Error : Departure Station Code ' + departureCode + ' Not Found'];
  } else if (!stationList.contains(arrivalCode)) {
    return ['Error : Arrival Station Code ' + arrivalCode + ' Not Found'];
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

  int departureStationIndex = stationList.indexOf(departureCode);
  int arrivalStationIndex = stationList.indexOf(arrivalCode);

  List<double> distances = List.generate(
      stationList.length, (index) => double.infinity,
      growable: false);
  List<bool> stationSet =
      List.generate(stationList.length, (index) => false, growable: false);
  List<int> closestStations = List.generate(
      stationList.length, (index) => stationList.length,
      growable: false);

  distances[departureStationIndex] = 0;
  closestStations[departureStationIndex] = 0;

  for (int count = 0; count < stationList.length - 1; count++) {
    int? minDistanceIndex =
        minDistancePosition(distances: distances, stationSet: stationSet);
    stationSet[minDistanceIndex] = true;

    for (int i = 0; i < stationList.length; i++) {
      if (!stationSet[i] &&
          distances[minDistanceIndex] != double.infinity &&
          distances[minDistanceIndex] + stationGrid[minDistanceIndex][i] <
              distances[i]) {
        distances[i] =
            distances[minDistanceIndex] + stationGrid[minDistanceIndex][i];
        closestStations[i] = minDistanceIndex;
      }
    }
  }

  if (closestStations[departureStationIndex] == stationList.length ||
      closestStations[arrivalStationIndex] == stationList.length) {
    return ['Error: No Route Found'];
  }

  // for (int i = 0; i < stationList.length; i++) {
  //   // print('$i : ${stationList[i]} : ${distances[i].toStringAsFixed(3)} : ${closestStations[i]}');
  // }

  List<String> routeStationList = [stationList[arrivalStationIndex]];

  while (routeStationList[routeStationList.length - 1] !=
      stationList[departureStationIndex]) {
    routeStationList.add(stationList[closestStations[
        stationList.indexOf(routeStationList[routeStationList.length - 1])]]);
  }
  routeStationList = List.from(routeStationList.reversed);

  return routeStationList;
}
