import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../util/constants.dart';

class HomeButton extends StatelessWidget {
  HomeButton({super.key, required this.name, required this.icon, required this.page, required this.color});

  String name;
  IconData icon;
  Widget page;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 1,
      shadowColor: whitish,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child: InkWell(
          onTap: (){

            Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          },
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 30,
                    child: Icon(icon, size: 30, color: Colors.white,),
                  backgroundColor: Colors.white24,
                ),
                const SizedBox(height: 8,),
                Text(name,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}
