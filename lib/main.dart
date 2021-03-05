import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workerbase_challenge/screen/history_screen.dart';
import 'package:workerbase_challenge/screen/scanner_screen.dart';

import 'bloc/database_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR-Code Scanner',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => DatabaseBloc(),
        child: HomePage(),
      ),
    );
  }
}
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  Widget build(buildContext){
    return Scaffold(
      body: show(index),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[900],
        ),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: index,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.white54,
            selectedItemColor: Colors.white,
            onTap: ((int x){
              setState(() {
                index = x;
                show(index);
              });
            }),
            items: [
              new BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner),
                label: 'Scanner',
              ),
              new BottomNavigationBarItem(icon: Icon(Icons.history),
                label: 'History',
              ),
            ]),
      ),
    );
  }
}
Widget show(int index){
  switch(index){
    case 0: return ScannerScreen();
    break;
    case 1: return HistoryScreen();
    break;
  }
}