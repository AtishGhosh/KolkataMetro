import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class MetroMap extends StatelessWidget {
  const MetroMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Metro Map',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Center(
        child: ZoomOverlay(
          twoTouchOnly: true,
          child: Image.asset('assets/images/map/map.png'),
        ),
      ),
    );
  }
}
