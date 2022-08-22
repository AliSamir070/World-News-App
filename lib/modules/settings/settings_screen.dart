import 'package:flutter/material.dart';

import '../../home_screen.dart';

class SettingsScreen extends StatelessWidget {
  static String route = "Settings";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/background.png'),fit: BoxFit.cover)
          ),
        ),
        Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 34),
                    child: Text(
                      "News App!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    runSpacing: 10,
                    children: [
                      ListTile(
                        leading: Icon(
                            Icons.list
                        ),
                        onTap: (){
                          Navigator.pushReplacementNamed(context, HomeScreen.route);
                        },
                        title: Text(
                          'Categories',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        selected: false,
                        selectedColor: Colors.white,
                        selectedTileColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      ListTile(
                        leading: Icon(
                            Icons.settings
                        ),
                        title: Text(
                          'Settings',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        onTap: (){
                          Navigator.pushReplacementNamed(context, SettingsScreen.route);
                        },
                        selected: true,
                        selectedColor: Colors.white,
                        selectedTileColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            toolbarHeight: height*0.1,
            title: Text(
                'Settings'
            ),
          ),
          body: Container(),
        ),
      ],
    );
  }
}
