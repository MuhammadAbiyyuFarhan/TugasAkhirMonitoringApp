// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/monitoring_app/home.png',
      selectedImagePath: 'assets/monitoring_app/home.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/monitoring_app/lightbulb.png',
      selectedImagePath: 'assets/monitoring_app/lightbulb.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/monitoring_app/history.png',
      selectedImagePath: 'assets/monitoring_app/history.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/monitoring_app/person.png',
      selectedImagePath: 'assets/monitoring_app/person.png',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
