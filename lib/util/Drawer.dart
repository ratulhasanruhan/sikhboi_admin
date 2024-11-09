import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ButtonData.dart';


class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Image.asset(
                'assets/logo.png',
                height: 100,
              ),
            ),
          ),
          ListView.builder(
            primary: false,
            shrinkWrap:   true,
            itemCount: buttonList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index){
              return ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => buttonList[index].page));
                },
                leading: Icon(buttonList[index].icon, size: 30,),
                title: Text(buttonList[index].name,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
