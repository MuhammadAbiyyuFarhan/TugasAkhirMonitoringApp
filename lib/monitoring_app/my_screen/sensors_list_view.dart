import 'dart:async';


import 'package:firebase_database/firebase_database.dart';
import 'package:monitoring_app/monitoring_app/monitoring_app_theme.dart';
import 'package:monitoring_app/monitoring_app/models/sensor_list_data.dart';
import 'package:monitoring_app/main.dart';
import 'package:flutter/material.dart';


//import '../../main.dart';


class SensorsListView extends StatefulWidget {
  const SensorsListView(
      {super.key, this.mainScreenAnimationController, this.mainScreenAnimation});

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  // ignore: library_private_types_in_public_api
  _SensorsListViewState createState() => _SensorsListViewState();
}

class _SensorsListViewState extends State<SensorsListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<SensorsListData> sensorsListData = SensorsListData.tabIconsList;
  // ignore: deprecated_member_use
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  String proximity1Value = 'Loading...';
  String proximity2Value = 'Loading...';

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _initializeData();
    super.initState();
  }

 Future<void> _initializeData() async {
  await getDataFromFirebase();
  setState(() {
    // Update status based on proximity values
    for (var sensor in sensorsListData) {
      if (sensor.sensors!.contains('Proximity 1')) {
        sensor.status = proximity1Value;
      } else if (sensor.sensors!.contains('Proximity 2')) {
        sensor.status = proximity2Value;
      }
    }
  });
}

  Future<void> getDataFromFirebase() async {
  try {
    // Fetch data from Firebase using real-time listener
    _databaseReference.onValue.listen((event) {
      final snapshot = event.snapshot;

      final dynamic value = snapshot.value;

      if (value != null && value is Map<dynamic, dynamic>) {
        setState(() {
          proximity1Value = value['proximity1']?.toString() ?? 'Error';
          proximity2Value = value['proximity2']?.toString() ?? 'Error';

          // Update status based on proximity values
          for (var sensor in sensorsListData) {
            if (sensor.sensors!.contains('Proximity 1')) {
              sensor.status = proximity1Value;
            } else if (sensor.sensors!.contains('Proximity 2')) {
              sensor.status = proximity2Value;
            }
          }
        });
      }
    });
  } catch (error) {
    setState(() {
      proximity1Value = 'Error';
      proximity2Value = 'Error';
    });
  }
}


  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: SizedBox(
              height: 216,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: sensorsListData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                      sensorsListData.length > 10 ? 10 : sensorsListData.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return SensorsView(
                    sensorsListData: sensorsListData[index],
                    animation: animation,
                    animationController: animationController!,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class SensorsView extends StatelessWidget {
  const SensorsView(
      {super.key, this.sensorsListData, this.animationController, this.animation});

  final SensorsListData? sensorsListData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: SizedBox(
              width: 130,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 32, left: 8, right: 8, bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: HexColor(sensorsListData!.endColor)
                                  .withOpacity(0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        gradient: LinearGradient(
                          colors: <HexColor>[
                            HexColor(sensorsListData!.startColor),
                            HexColor(sensorsListData!.endColor),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(54.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 54, left: 16, right: 16, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              sensorsListData!.titleTxt,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: MonitoringAppTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 0.2,
                                color: MonitoringAppTheme.white,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      sensorsListData!.sensors!.join('\n'),
                                      style: const TextStyle(
                                        fontFamily: MonitoringAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 8,
                                        letterSpacing: 0.2,
                                        color: MonitoringAppTheme.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // ignore: unrelated_type_equality_checks
                            sensorsListData?.status != 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        sensorsListData!.status.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: MonitoringAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 8,
                                          letterSpacing: 0.2,
                                          color: MonitoringAppTheme.white,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 4, bottom: 3),
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                            fontFamily:
                                                MonitoringAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            letterSpacing: 0.2,
                                            color: MonitoringAppTheme.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: MonitoringAppTheme.nearlyWhite,
                                      shape: BoxShape.circle,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: MonitoringAppTheme.nearlyBlack
                                                .withOpacity(0.4),
                                            offset: const Offset(8.0, 8.0),
                                            blurRadius: 8.0),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Icon(
                                        Icons.add,
                                        color: HexColor(sensorsListData!.endColor),
                                        size: 24,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: MonitoringAppTheme.nearlyWhite.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 8,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(sensorsListData!.imagePath),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
