import 'package:monitoring_app/monitoring_app/list_view/conveyor.dart';
import 'package:monitoring_app/monitoring_app/list_view/proximity.dart';
import 'package:monitoring_app/monitoring_app/list_view/tachometer.dart';
import 'package:monitoring_app/monitoring_app/list_view/tcs3200.dart';
// import 'package:monitoring_app/monitoring_app/my_screen/sensors_detail.dart';
import 'package:flutter/material.dart';
import '../monitoring_app_theme.dart';

class AreaListView extends StatefulWidget {
  const AreaListView(
      {super.key, this.mainScreenAnimationController, this.mainScreenAnimation, required Null Function() onTap, required Null Function() onProximityTap, required Null Function() onConveyorTap, required Null Function() onTCS3200Tap, required Null Function() onTachometerTap});

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  @override
  // ignore: library_private_types_in_public_api
  _AreaListViewState createState() => _AreaListViewState();
}

class _AreaListViewState extends State<AreaListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<String> areaListData = <String>[
    'assets/monitoring_app/proximity.png',
    'assets/monitoring_app/tachometer.png',
    'assets/monitoring_app/TCS3200.png',
    'assets/monitoring_app/conveyor.png',
  ];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
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
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: GridView(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    childAspectRatio: 1.2,
                  ),
                  children: List<Widget>.generate(
                    areaListData.length,
                    (int index) {
                      final int count = areaListData.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController!,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      animationController?.forward();
                      return AreaView(
                        imagepath: areaListData[index],
                        animation: animation,
                        animationController: animationController!,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AreaView extends StatelessWidget {
  const AreaView({
    super.key,
    this.imagepath,
    this.animationController,
    this.animation,
  });

  final String? imagepath;
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
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: MonitoringAppTheme.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: MonitoringAppTheme.grey.withOpacity(0.4),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  splashColor: MonitoringAppTheme.nearlyDarkBlue.withOpacity(0.2),
                 // Inside the onTap callback of InkWell in AreaView widget

onTap: () {
  // Determine which screen to navigate based on the imagepath
  switch (imagepath) {
    case 'assets/monitoring_app/proximity.png':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProximityDetailScreen()),
      );
      break;
    case 'assets/monitoring_app/conveyor.png':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ConveyorDetailScreen()),
      );
      break;
    case 'assets/monitoring_app/tachometer.png':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TachometerDetailScreen()),
      );
      break;
    case 'assets/monitoring_app/TCS3200.png':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TCS3200DetailScreen()),
      );
      break;
    default:
      // Handle default case if necessary
      break;
      }
    },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            imagepath!,
                            width: 80,  // Sesuaikan dengan nilai yang diinginkan
                            height: 100, // Sesuaikan dengan nilai yang diinginkan
                            fit: BoxFit.contain, // Menyesuaikan gambar agar tidak overflow, tapi masih overflow :(
                          ),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
