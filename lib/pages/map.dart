import 'package:flutter/material.dart';
import 'package:kolkatametro/theme.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class MetroMapButton extends StatelessWidget {
  const MetroMapButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MetroMap(),
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
            'Metro Map',
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
                'assets/images/home/map.png',
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
                  Colors.black.withOpacity(0.85),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MetroMap extends StatelessWidget {
  const MetroMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        toolbarHeight: 62,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Metro Map',
          style: TextStyle(
            color: Theme.of(context).highlightColor,
            fontSize: 25.0,
          ),
        ),
        leading: getAppBarBackButton(context),
        systemOverlayStyle: getSystemOverlayStyle(context),
      ),
      body: Center(
        child: ZoomOverlay(
          twoTouchOnly: true,
          child: Theme.of(context).brightness == Brightness.light
              ? Image.asset('assets/images/pages/map/map.png')
              : Image.asset('assets/images/pages/map/map-dark.png'),
        ),
      ),
    );
  }
}
