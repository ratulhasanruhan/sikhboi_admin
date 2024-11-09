import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:sikhboi_admin/util/constants.dart';
import '../util/ButtonData.dart';
import '../util/Drawer.dart';
import '../widget/HomeButton.dart';
import 'ProfilePage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sikhboi Admin'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            icon: Icon(FeatherIcons.userCheck),
          ),
        ],
      ),
      drawer: HomeDrawer(),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
          primary: false,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: buttonList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: kIsWeb ? 5 : 3,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index){
            return HomeButton(
              name: buttonList[index].name,
              icon: buttonList[index].icon,
              page: buttonList[index].page,
              color: colorList[Random().nextInt(colorList.length)],
            );
          }
      ),
    );
  }
}
