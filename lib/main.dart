import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'homepage.dart';
import 'just_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: JustProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          backgroundColor: Colors.white70,
          primarySwatch: Colors.grey,
        ),
        home: HomePage(),
      ),
    );
  }
}