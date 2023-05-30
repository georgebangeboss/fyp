import 'package:flutter/material.dart';
import 'package:fyp/routes.dart';
import 'package:fyp/styles.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhiteBackground,
      body: Center(
        child: SizedBox(
          height: 700,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/nakuja.jpeg',
                    height: 130,
                    width: 130,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: inputDecor.copyWith(
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      labelText: 'ip:port',
                    ),
                    onFieldSubmitted: (ip) {
                      Navigator.popAndPushNamed(context, RouteManager.home,
                          arguments: ip);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
