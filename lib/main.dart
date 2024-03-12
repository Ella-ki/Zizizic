import 'package:flutter/material.dart';
import 'package:zizizic/signPage.dart';
import 'login.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'mainPage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'tour_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE place(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, tel TEXT , zipcode TEXT , address TEXT , mapx Number , mapy Number , imagePath TEXT)",
        );
      },
      version: 1,
    );
  }


  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase(); // build 할때 initDatabase() 함수를 호출합니다
    return MaterialApp(
      title: '모두의 여행',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/sign': (context) => SignPage(),
        '/main': (context) => MainPage(),
      },);}
}