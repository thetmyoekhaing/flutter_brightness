import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_brightness/screen_brightness.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final brightnessChannel = const MethodChannel("brightnessPlatform");
  late Future current;
  @override
  void initState() {
    current = brightnessChannel.invokeMethod('getBrightness');
    super.initState();
  }

  void toMax() async {
    try {
      await brightnessChannel
          .invokeMethod("setBrightness", {"brightness": 1.toDouble()});
    } on PlatformException catch (e) {
      throw "${e.message}";
    }
  }

  Future<void> toOriginal() async {
    final og = await current;
    try {
      await brightnessChannel.invokeMethod("setBrightness", {"brightness": og});
    } on PlatformException catch (e) {
      throw "${e.message}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text("To Max Brightness"),
                onPressed: () => toMax(),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: const Text("To Original Brightness"),
                onPressed: () async => await toOriginal(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
