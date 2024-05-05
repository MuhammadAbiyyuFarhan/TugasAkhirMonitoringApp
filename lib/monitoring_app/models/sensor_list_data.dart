class SensorsListData {
  SensorsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.sensors,
    this.status = 'connected',
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? sensors;
  String status;

  static List<SensorsListData> tabIconsList = <SensorsListData>[
    SensorsListData(
      imagePath: 'assets/monitoring_app/proximity.png',
      titleTxt: 'E18-D80NK',
      status: 'connected',
      sensors: <String>['Proximity 1'],
      startColor: '#294B29',
      endColor: '#50623A',
    ),
    SensorsListData(
      imagePath: 'assets/monitoring_app/proximity.png',
      titleTxt: 'E18-D80NK',
      status: 'connected',
      sensors: <String>['Proximity 2'],
      startColor: '#789461',
      endColor: '#DBE7C9',
    ),
    SensorsListData(
      imagePath: 'assets/monitoring_app/tachometer.png',
      titleTxt: 'Tachometer',
      status: 'disconnected',
      sensors: <String>['Speed Sensor'],
      startColor: '#50623A',
      endColor: '#294B29',
    ),
    SensorsListData(
      imagePath: 'assets/monitoring_app/tachometer.png',
      titleTxt: 'Tachometer',
      status: 'connected',
      sensors: <String>['Speed Sensor'],
      startColor: '#DBE7C9',
      endColor: '#294B29',
    ),
    SensorsListData(
      imagePath: 'assets/monitoring_app/TCS3200.png',
      titleTxt: 'TCS3200',
      status: 'disconnected',
      sensors: <String>['Color Sensor'],
      startColor: '#294B29',
      endColor: '#50623A',
    ),
  ];
}
