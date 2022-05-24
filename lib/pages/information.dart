import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kolkatametro/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationButton extends StatelessWidget {
  const InformationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 28.0,
        right: 28.0,
        bottom: 28.0,
      ),
      child: AspectRatio(
        aspectRatio: 2.2,
        child: InkWell(
          onTap: (() => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InformationPage(),
                ),
              )),
          child: GridTile(
            footer: const Padding(
              padding: EdgeInsets.only(
                bottom: 6.0,
                left: 10.0,
              ),
              child: Text(
                'Information',
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
                    'assets/images/home/info.png',
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
        ),
      ),
    );
  }
}

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 62.0,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'Information',
          style: TextStyle(
            color: Theme.of(context).highlightColor,
            fontSize: 25.0,
          ),
        ),
        leading: getAppBarBackButton(context),
        systemOverlayStyle: getSystemOverlayStyle(context),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          bottom: 12.5,
        ),
        children: [
          Container(
            color: Theme.of(context).backgroundColor,
            child: GridView.count(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 18,
                right: 27.5,
                left: 27.5,
              ),
              mainAxisSpacing: 28.0,
              crossAxisSpacing: 28.0,
              childAspectRatio: 1,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: [
                InkWell(
                  onTap: (() {}),
                  child: GridTile(
                    footer: const Padding(
                      padding: EdgeInsets.only(
                        bottom: 6.0,
                        left: 10.0,
                      ),
                      child: Text(
                        'Terms & Conditions',
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
                            'assets/images/pages/information/terms.png',
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
                ),
                InkWell(
                  onTap: (() {}),
                  child: GridTile(
                    footer: const Padding(
                      padding: EdgeInsets.only(
                        bottom: 6.0,
                        left: 10.0,
                      ),
                      child: Text(
                        'Privacy Policy',
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
                            'assets/images/pages/information/privacy-policy.png',
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
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 10.0,
            ),
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 28.0,
              left: 27.5,
              right: 27.5,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(
                  20.0,
                ),
                bottomRight: Radius.circular(
                  20.0,
                ),
              ),
              color: Theme.of(context).backgroundColor,
            ),
            child: AspectRatio(
              aspectRatio: 2.2,
              child: InkWell(
                onTap: (() {}),
                child: GridTile(
                  footer: const Padding(
                    padding: EdgeInsets.only(
                      bottom: 6.0,
                      left: 10.0,
                    ),
                    child: Text(
                      'About Kolkata Metro',
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
                          'assets/images/pages/information/about.png',
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
              ),
            ),
          ),
          Card(
            elevation: 0,
            color: Theme.of(context).backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 20.0,
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  16.0,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 20.0,
              ),
              onTap: (() {}),
              mouseCursor: SystemMouseCursors.click,
              leading: setListTileIcon(
                icon: const Icon(
                  Icons.brightness_medium,
                ),
              ),
              title: Text(
                'Dark Mode Setting',
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontSize: 16.0,
                ),
              ),
              subtitle: const Text(
                'Set your theme preference',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Card(
            elevation: 0,
            color: Theme.of(context).backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 20.0,
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  16.0,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 20.0,
              ),
              onTap: (() => launchUrl(
                    Uri.parse(
                      'https://mtp.indianrailways.gov.in/',
                    ),
                  )),
              mouseCursor: SystemMouseCursors.click,
              leading: setListTileIcon(
                icon: const Icon(
                  Icons.web,
                ),
              ),
              title: Text(
                'Kolkata Metro Website',
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontSize: 16.0,
                ),
              ),
              subtitle: const Text(
                'mtp.indianrailways.gov.in',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Card(
            elevation: 0,
            color: Theme.of(context).backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 20.0,
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  16.0,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 20.0,
              ),
              onTap: (() => launchUrl(
                    Uri.parse(
                      'https://twitter.com/metrorailwaykol',
                    ),
                  )),
              mouseCursor: SystemMouseCursors.click,
              leading: setListTileIcon(
                icon: const Icon(
                  FontAwesomeIcons.twitter,
                ),
              ),
              title: Text(
                'Twitter',
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontSize: 18.0,
                ),
              ),
              subtitle: const Text(
                '@metrorailwaykol',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Card(
            elevation: 0,
            color: Theme.of(context).backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 20.0,
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  16.0,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 20.0,
              ),
              onTap: (() => launchUrl(
                    Uri.parse(
                      'https://en.wikipedia.org/wiki/Kolkata_Metro',
                    ),
                  )),
              mouseCursor: SystemMouseCursors.click,
              leading: setListTileIcon(
                icon: const Icon(
                  FontAwesomeIcons.wikipediaW,
                ),
              ),
              title: Text(
                'Wikipedia',
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontSize: 18.0,
                ),
              ),
              subtitle: const Text(
                '/Kolkata_Metro',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
