import 'package:flutter/material.dart';
import 'package:sikhboi_admin/screen/EnglishChat.dart';
import 'package:sikhboi_admin/screen/Notices.dart';
import 'package:sikhboi_admin/screen/PremiumLive.dart';
import 'package:sikhboi_admin/screen/FreeLive.dart';
import '../Model/button_data_model.dart';

List<ButtonDataModel> buttonList = [
  ButtonDataModel(
    name: 'Free Live',
    icon: Icons.live_tv,
    page: FreeLive(),
  ),
  ButtonDataModel(
    name: 'Premium Live',
    icon: Icons.video_camera_front_outlined,
    page: PremiumLive(),
  ),
  ButtonDataModel(
    name: 'English Chat',
    icon: Icons.chat_outlined,
    page: EnglishChat(),
  ),
  ButtonDataModel(
    name: 'Notice',
    icon: Icons.warning_rounded,
    page: Notices(),
  ),

];