import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skateboard_onboarding/onboarding.dart';
import 'package:skateboard_onboarding/provider/indexNotifier.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (BuildContext context) => IndexNotifier(),
        child: MyOnboarding(),
      ),
    );
  }
}
