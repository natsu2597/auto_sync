import 'package:flutter/material.dart';

String uri = 'http://192.168.42.248:3000';


class GlobalVariables{
  static const appBarGradient = LinearGradient(
                colors: [
                  Color.fromARGB(255, 194, 255, 255),
                  Color.fromARGB(255, 158, 226, 226)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              );
  static const backgroundColor = Color.fromRGBO(226, 248, 242, 1);
  static const secondaryColor = Color.fromRGBO(112, 183, 180, 1);
  static const Color greyBackgroundCOlor = Color(0xffebecee);
}