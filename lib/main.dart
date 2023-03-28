import 'package:flutter/material.dart';
import 'home/home.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF39A552),
        appBarTheme: AppBarTheme(
          color:  Color(0xFF39A552),
        )
      ),
      routes: {
        Home.route_name:(_)=>Home(),
      //  DetailsScreen.route_name:(_)=>DetailsScreen(id),
      },
      initialRoute: Home.route_name,

    );
  }
}


