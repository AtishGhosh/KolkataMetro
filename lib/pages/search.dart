import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kolkatametro/theme.dart';

class SearchStationsPage extends StatefulWidget {
  const SearchStationsPage({Key? key}) : super(key: key);

  @override
  State<SearchStationsPage> createState() => _SearchStationsPageState();
}

class _SearchStationsPageState extends State<SearchStationsPage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
            ),
            child: AppBar(
              backgroundColor:
                  Theme.of(context).backgroundColor.withOpacity(0.8),
              elevation: 0,
              title: Container(
                alignment: Alignment.centerLeft,
                child: TextField(
                  autofocus: true,
                  controller: controller,
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: ' Search Station',
                  ),
                ),
              ),
              leading: getAppBarBackButton(context),
              systemOverlayStyle: getSystemOverlayStyle(context),
            ),
          ),
        ),
        preferredSize: const Size.fromHeight(62.0),
      ),
    );
  }
}
