import 'package:flutter/material.dart';
import 'package:monitoring_app/monitoring_app/monitoring_app_theme.dart';
// import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductStatusView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const ProductStatusView({
    super.key,
    this.animationController,
    this.animation,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProductStatusViewState createState() => _ProductStatusViewState();
}

class _ProductStatusViewState extends State<ProductStatusView> {
  late DatabaseReference _databaseReference;
  String detectionCounter = 'Loading...'; // Initial value
  String bottleBlack = 'Loading...'; // Initial value
  String bottleWhite = 'Loading...'; // Initial value
  String bottleTimestamp = 'Loading...'; // Initial value

  @override
  void initState() {
    super.initState();
    // Initialize the database reference
    // ignore: deprecated_member_use
    _databaseReference = FirebaseDatabase.instance.reference();

    // Register a listener to listen for changes in the database
    _databaseReference.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          var data = event.snapshot.value as Map<Object?, Object?>?;
          // Use null-aware operators to safely access the values
          detectionCounter = data?['detectionCounter']?.toString() ?? 'Error';
          bottleBlack = data?['bottleBlack']?.toString() ?? 'Error';
          bottleWhite = data?['bottleWhite']?.toString() ?? 'Error';
          bottleTimestamp = data?['bottleTimestamp']?.toString() ?? 'Error';
        });
      } else {
        // Handle the case when sensor values cannot be obtained
        setState(() {
          detectionCounter = 'Error';
          bottleBlack = 'Error';
          bottleWhite = 'Error';
          bottleTimestamp = 'Error';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
          int bottleBlackValue = int.tryParse(bottleBlack) ?? 0;
          int bottleWhiteValue = int.tryParse(bottleWhite) ?? 0;
          int detectionCounterValue = int.tryParse(detectionCounter) ?? 0;
          int difference = 0;
          if (bottleWhiteValue + bottleBlackValue != 0) {
            difference = (100-((bottleWhiteValue + bottleBlackValue) / (detectionCounterValue) * 100)).round();
          }
          String differenceString;
          if (bottleWhiteValue + bottleBlackValue == detectionCounterValue) {
            differenceString = '0%';
          } else {
            differenceString = '$difference%';
          }

        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
              0.0,
              30 * (1.0 - widget.animation!.value),
              0.0,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 16,
                bottom: 18,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: MonitoringAppTheme.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(68.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: MonitoringAppTheme.grey.withOpacity(0.2),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 24,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 4,
                              bottom: 8,
                              top: 16,
                            ),
                            child: Text(
                              'Bottles in total',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: MonitoringAppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: -0.1,
                                color: MonitoringAppTheme.darkText,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 4,
                                      bottom: 3,
                                    ),
                                    child: Text(
                                      detectionCounter,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: MonitoringAppTheme.fontName,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 32,
                                        color:
                                            MonitoringAppTheme.nearlyDarkBlue,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      left: 8,
                                      bottom: 8,
                                    ),
                                    child: Text(
                                      'pcs',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: MonitoringAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        letterSpacing: -0.2,
                                        color:
                                            MonitoringAppTheme.nearlyDarkBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.access_time,
                                        color: MonitoringAppTheme.grey
                                            .withOpacity(0.5),
                                        size: 16,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 4.0,
                                        ),
                                        child: Text(
                                          bottleTimestamp,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                MonitoringAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: MonitoringAppTheme.grey
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 4,
                                      bottom: 14,
                                    ),
                                    child: Text(
                                      'Last Recorded',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: MonitoringAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        letterSpacing: 0.0,
                                        color:
                                            MonitoringAppTheme.nearlyDarkBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 8,
                        bottom: 8,
                      ),
                      child: Container(
                        height: 2,
                        decoration: const BoxDecoration(
                          color: MonitoringAppTheme.background,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 8,
                        bottom: 16,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  bottleWhite,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: MonitoringAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.2,
                                    color: MonitoringAppTheme.darkText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    'White Bottle',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: MonitoringAppTheme.fontName,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: MonitoringAppTheme.grey
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                        bottleBlack,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontFamily: MonitoringAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          letterSpacing: -0.2,
                                          color: MonitoringAppTheme.darkText,
                                        ),
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        'Black Bottle',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily:
                                              MonitoringAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: MonitoringAppTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      differenceString,
                                      style: const TextStyle(
                                        fontFamily: MonitoringAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: MonitoringAppTheme.darkText,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        'Difference',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily:
                                              MonitoringAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: MonitoringAppTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
