import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kolkatametro/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class HelplinesButton extends StatelessWidget {
  const HelplinesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Helplines(),
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
            'Helplines',
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
                'assets/images/home/helpline.png',
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

class Helpline extends StatelessWidget {
  const Helpline({
    Key? key,
    required this.url,
    required this.iconData,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String url;
  final IconData iconData;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
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
          launchUrl(Uri.parse(url));
        },
        borderRadius: BorderRadius.circular(16.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            mouseCursor: SystemMouseCursors.click,
            leading: setListTileIcon(
              icon: Icon(
                iconData,
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).highlightColor,
                fontSize: 16.0,
              ),
            ),
            subtitle: Text(
              subtitle,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            trailing: setListTileIcon(
              icon: const Icon(
                Icons.call,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Helplines extends StatelessWidget {
  const Helplines({Key? key}) : super(key: key);

  List<Helpline> getHelplines() {
    return [
      const Helpline(
        url: 'tel:102',
        iconData: FontAwesomeIcons.truckMedical,
        title: 'Ambulance',
        subtitle: '102',
      ),
      const Helpline(
        url: 'tel:101',
        iconData: FontAwesomeIcons.fire,
        title: 'Fire Station',
        subtitle: '101',
      ),
      const Helpline(
        url: 'tel:100',
        iconData: Icons.security,
        title: 'Police Control Room',
        subtitle: '100',
      ),
      const Helpline(
        url: 'tel:182',
        iconData: Icons.security_outlined,
        title: 'Metro Security',
        subtitle: '182',
      ),
      const Helpline(
        url: 'tel:+91-90070-41908',
        iconData: FontAwesomeIcons.personDress,
        title: 'Women Helpline',
        subtitle: '+91 90070 41908',
      ),
      const Helpline(
        url: 'tel:+91-90070-41789',
        iconData: FontAwesomeIcons.trainSubway,
        title: 'Metro Helpline',
        subtitle: '+91 90070 41789',
      ),
      const Helpline(
        url: 'tel:+91-33-2214-3230',
        iconData: FontAwesomeIcons.buildingShield,
        title: 'Lal Bazar Police HQ',
        subtitle: '+91 33 2214 3230',
      ),
      const Helpline(
        url: 'tel:+91-33-2226-3959',
        iconData: FontAwesomeIcons.building,
        title: 'Metro Railway HQ',
        subtitle: '+91 33 2226 3959',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 62.0,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'Helplines',
          style: TextStyle(
            color: Theme.of(context).highlightColor,
            fontSize: 25.0,
          ),
        ),
        leading: getAppBarBackButton(context),
        systemOverlayStyle: getSystemOverlayStyle(context),
      ),
      body: Builder(
        builder: ((context) => ListView(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10.0,
                left: 5.0,
                right: 5.0,
              ),
              children: getHelplines(),
            )),
      ),
    );
  }
}
