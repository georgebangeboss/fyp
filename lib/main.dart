import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/routes.dart';
import 'package:fyp/styles.dart';
import 'package:fyp/utils.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: RouteManager.splash,
      onGenerateRoute: RouteManager.generateRoute,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: genTxt,
        ),
        primarySwatch: Colors.blue,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(8.0),
            foregroundColor: Colors.white60,
            backgroundColor: colorPrimaryVariant,
            elevation: 3.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: colorWhiteBackground,
          foregroundColor: colorPrimary,
        ),
        scaffoldBackgroundColor: colorBackground,
      ),
      navigatorKey: GlobalKey<NavigatorState>(),
      scaffoldMessengerKey: GlobalKey<ScaffoldMessengerState>(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.ipAddressPort});

  final String ipAddressPort;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double? _latitude;
  double? _longitude;
  bool _isPrimaryFired = false;
  bool _isSecondaryFired = false;
  bool _isSeparated = false;
  bool _isMotorEjectionOn = false;

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 3), (_) async {
      await getFlightStatus();
    });
    super.initState();
  }

  Future getFlightStatus() async {
    var client = http.Client();
    try {
      var uri = Uri.http(widget.ipAddressPort, '/flightData');

      var response = await client.get(uri);
      print(response.body);

      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      setState(() {
        _latitude = double.parse(decodedResponse['latitude']);
        _longitude = double.parse(decodedResponse['longitude']);
        _isPrimaryFired = decodedResponse['primary'] as String == "1";
        _isSecondaryFired = decodedResponse['secondary'] as String == "1";
        _isSeparated = decodedResponse['separated'] as String == "1";
        _isMotorEjectionOn = decodedResponse['motor'] as String == "1";
      });
    } on Exception catch (_) {
      createSnackBar(
          context: context,
          text: "Something went wrong, maybe wrong ip or port");
    } finally {
      client.close;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Text(
                    "Primary Ejection Fired",
                    style: genTxt.copyWith(fontSize: 16),
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      _isPrimaryFired ? "Yes" : "No",
                      style: genTxt.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Text(
                    "Motor Ejection Status",
                    style: genTxt.copyWith(fontSize: 16),
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      _isMotorEjectionOn ? "On" : "Off",
                      style: genTxt.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Text(
                    "Remote Ejection Fired",
                    style: genTxt.copyWith(fontSize: 16),
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      _isSecondaryFired ? "Yes" : "No",
                      style: genTxt.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Text(
                    "Successful Separation",
                    style: genTxt.copyWith(fontSize: 16),
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      _isSeparated ? "Yes" : "No",
                      style: genTxt.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Text(
                    "Latitude",
                    style: genTxt.copyWith(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      (_latitude != 0 && _latitude != null)
                          ? _latitude.toString()
                          : '--',
                      style: genTxt.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Text(
                    "Longitude",
                    style: genTxt.copyWith(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      (_longitude != 0 && _longitude != null)
                          ? _longitude.toString()
                          : '--',
                      style: genTxt.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () async {
                    var client = http.Client();
                    try {
                      var uri = Uri.http(widget.ipAddressPort, '/eject');

                      var response = await client.get(uri);
                      print(response.body);
                    } on Exception catch (_) {
                      createSnackBar(
                          context: context,
                          text: "Something went wrong, maybe wrong ip or port");
                    } finally {
                      client.close;
                    }
                  },
                  child: Text("Eject Chute"),
                ),
                TextButton(
                  onPressed: () async {
                    var client = http.Client();
                    try {
                      var uri = Uri.http(widget.ipAddressPort, '/cancelMotor');

                      var response = await client.get(uri);
                      print(response.body);
                    } on Exception catch (_) {
                      createSnackBar(
                          context: context,
                          text: "Something went wrong, maybe wrong ip or port");
                    } finally {
                      client.close;
                    }
                  },
                  child: Text("Cancel Timer Ejection"),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            OutlinedButton(
              onPressed: () async {
                if (_latitude != null && _longitude != null) {
                  MapUtils.openMap(_latitude!, _longitude!);
                } else {
                  createSnackBar(
                      context: context, text: "No GPS readings available");
                }
              },
              child: Text("Find Rocket"),
            ),
          ],
        ),
      ),
    );
  }
}
