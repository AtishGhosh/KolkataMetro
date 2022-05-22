import 'package:flutter/material.dart';
import 'package:kolkatametro/info.dart';
import 'package:kolkatametro/theme.dart';

class SearchStationsPage extends StatefulWidget {
  const SearchStationsPage({Key? key, required this.searchList})
      : super(key: key);
  final List<RouteStation> searchList;

  @override
  State<SearchStationsPage> createState() => _SearchStationsPageState();
}

class _SearchStationsPageState extends State<SearchStationsPage> {
  late TextEditingController controller;
  late List<RouteStation> searchList;
  late FocusNode searchFocusNode;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    searchList = widget.searchList;
    searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void searchStations(String query) {
      final suggestions = widget.searchList.where((station) {
        final stationName = station.name.toLowerCase();
        final stationCode = station.code.toLowerCase();
        final input = query.toLowerCase();

        if (stationCode.contains(input)) {
          return stationCode.contains(input);
        }
        return stationName.contains(input);
      }).toList();

      setState(() => searchList = suggestions);
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 62.0,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Container(
          alignment: Alignment.centerLeft,
          child: TextField(
            onChanged: searchStations,
            autofocus: true,
            focusNode: searchFocusNode,
            controller: controller,
            style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: 25.0,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: ' Search Station',
            ),
          ),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            onPressed: (() {
              controller.value = TextEditingValue.empty;
              searchStations('');
              searchFocusNode.requestFocus();
            }),
            icon: Icon(
              Icons.close,
              color: Theme.of(context).highlightColor,
            ),
          ),
        ],
        leading: getAppBarBackButton(context),
        systemOverlayStyle: getSystemOverlayStyle(context),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        itemCount: searchList.length,
        itemBuilder: ((context, index) {
          final station = searchList[index];
          List<Widget> connectionList = <Widget>[];
          for (Color? connection in station.connections) {
            connectionList.add(
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.brightness_1,
                    color: connection,
                  ),
                  Text(
                    station.lineNumber.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
            );
          }
          return Card(
            margin: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            elevation: 0,
            color: Theme.of(context).backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: ListTile(
              onTap: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  16.0,
                ),
              ),
              contentPadding: const EdgeInsets.only(
                top: 5.0,
                bottom: 5.0,
                left: 20.0,
                right: 20.0,
              ),
              title: Text(
                station.name,
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(
                station.code,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              trailing: station.connections.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: connectionList,
                    )
                  : null,
            ),
          );
        }),
      ),
    );
  }
}
