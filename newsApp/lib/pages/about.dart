/*
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  LinearGradient gradient = const LinearGradient(
      colors: [Colors.black, Colors.grey, Colors.blueGrey],
      begin: Alignment.bottomRight,
      end: Alignment.topLeft);
  @override
  Widget build(BuildContext context) {
    _launchUrl(String url) async {
      if (await canLaunchUrl(url as Uri)) {
        launchUrl(url as Uri);
      } else {
        ScaffoldMessenger.of(_scaffoldKey as BuildContext).showSnackBar(const SnackBar(content:Text('Error. Could not log out')));

      }
    }

    return Container(
      height: 720,
      padding: const EdgeInsets.only(top: 10.0, bottom: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //Center(child: Chip(label: Text("APP INFO",style: TextStyle
          //(fontSize: 15.0),))),
          //Spacer(),
          const Chip(elevation: 12.0,autofocus: true,
            label: Text("BY  :  Shivam Choudhary",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600
            )),
            avatar: Icon(Icons.android),
          ),
          const Spacer(),
          Row(
            children: <Widget>[
              IconButton(
                  icon: const Icon(
                    MdiIcons.facebook,
                    size: 40.0,
                    color: Colors.blue
                  ),
                  onPressed: () {
                    _launchUrl("https://www.facebook.com/shivamkumar.kumar.549668");
                  }),
              const Spacer(),
              IconButton(
                  icon: const Icon(
                    MdiIcons.instagram,
                    size: 40.0,
                    color: Color.fromRGBO(138, 58, 185, 4),
                  ),
                  onPressed: () {
                    _launchUrl("https://www.instagram.com/shivamchoudhary3690/");
                  }),
              const Spacer(),
              IconButton(
                  icon: const Icon(
                    MdiIcons.twitter,
                    size: 40.0,
                    color: Colors.lightBlue
                  ),
                  onPressed: () {
                    _launchUrl("https://twitter.com/S_Choudhary0369");
                  }),
              const Spacer(),
              IconButton(
                  icon: const Icon(
                    MdiIcons.github,
                    size: 40.0,
                      color: Colors.black87
                  ),
                  onPressed: () {
                    _launchUrl("https://github.com/ShivamChoudhary17");
                  }),
              const Spacer(),
              IconButton(
                  icon: const Icon(
                    MdiIcons.linkedin,
                    size: 40.0,
                      color: Colors.blue
                  ),
                  onPressed: () {
                    _launchUrl(
                        "https://www.linkedin.com/in/theshivamchoudhary/");
                  })
            ],
          ),
          const Spacer(),
          GestureDetector(
            child: const Chip(
              label: Text("  TECHNOLOGY USED   :   FLUTTER",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400
                  )),
              avatar: FlutterLogo(),
            ),
            onTap: () {
              _launchUrl("https://flutter.dev/");
            },
          ),
        ],
      ),
    );
  }
}
*/
