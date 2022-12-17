import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/styles/AppStyle.dart';

import 'modules/settings/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  static String route = "home_screen";
  List<String> categoriesTitles = ["Sports" , "Politics" , "Health" , "Business" , "Entertain" , "Science"];
  List<bool> categoriesDirections = [false , true, false , true, false , true];
  List<String> categoriesIcons = [
    "assets/images/sports.png","assets/images/Politics.png",
    "assets/images/health.png","assets/images/bussines.png",
    "assets/images/environment.png","assets/images/science.png"
  ];
  List<Color> categoriesColors = [
    AppStyle.lightSportsColor,AppStyle.lightPoliticsColor,
    AppStyle.lightHealthColor,AppStyle.lightBusinessColor,
    AppStyle.lightEnvironmentColor,AppStyle.lightScienceColor,
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(

      children:[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/background.png'),fit: BoxFit.cover)
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
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
                        selected: true,
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
                        selected: false,
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
                'News App'
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Pick your category of internet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1/1.12,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20
                    ),
                    itemBuilder: (context , index){
                      return CategoryItem(title: categoriesTitles[index],
                                          image: categoriesIcons[index],
                                          isLeft: categoriesDirections[index],
                                          ItemColor: categoriesColors[index]
                      );
                    },
                    physics: BouncingScrollPhysics(),
                    itemCount: 6,
                  ),
                ),
              ),
            ],
          )
        ),
      ],
    );
  }
}
