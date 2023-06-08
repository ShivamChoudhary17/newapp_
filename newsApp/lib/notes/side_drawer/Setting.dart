import 'package:flutter/material.dart';
import '../../auth_/login_info.dart';
import '../color/colors.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late bool value;
  getSyncSet() async {
    LocalDataSaver.getSyncSet().then((valueFromDb) {
      setState(() {
        value = valueFromDb!;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSyncSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
          backgroundColor: bgColor, elevation: 0.0, title: Text("Settings")),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Sync",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Spacer(),
                Transform.scale(
                  scale: 1.3,
                  child: Switch.adaptive(
                      value: value,
                      onChanged: (switchValue) {
                        setState(() {
                          value = switchValue;
                          LocalDataSaver.saveSyncSet(switchValue);
                        });
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
