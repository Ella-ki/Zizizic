import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  final DatabaseReference? databaseReference;
  final String? id;

  const SettingPage({super.key, this.databaseReference, this.id});

  @override
  State<StatefulWidget> createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  bool pushCheck = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정하기'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Text(
                  '푸시 알림',
                  style: TextStyle(fontSize: 20),
                ),
                Switch(
                    value: pushCheck,
                    onChanged: (value) {
                      setState(() {
                        pushCheck = value;
                      });
                      _setData(value);
                    })
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            MaterialButton(
              onPressed: () {
                showsDialog(context);
                // Navigator.of(context)
                //     .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
              },
              child: const Text('로그아웃', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(
              height: 50,
            ),
            MaterialButton(
              onPressed: () {
                AlertDialog dialog = AlertDialog(
                  title: const Text('아이디 삭제'),
                  content: const Text('아이디를 삭제하시겠습니까?'),
                  actions: <Widget>[
                    MaterialButton(
                        onPressed: () {
                          print(widget.id);
                          widget.databaseReference!
                              .child('user')
                              .child(widget.id!)
                              .remove();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/', (Route<dynamic> route) => false);
                        },
                        child: const Text('예')),
                    MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('아니요')),
                  ],
                );
                showDialog(
                    context: context,
                    builder: (context) {
                      return dialog;
                    });
              },
              child: const Text('회원 탈퇴', style: TextStyle(fontSize: 20)),
            ),
              Container(
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }

  void _setData(bool value) async {
    var key = "push";
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
  }

  void _loadData() async {
    var key = "push";
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var value = pref.getBool(key);
      if (value == null) {
        setState(() {
          pushCheck = true;
        });
      } else {
        setState(() {
          pushCheck = value;
        });
      }
    });
  }

  void showsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const ListTile(
          title: Text("축하합니다"),
          subtitle: Text("모두의 여행앱을 완성했어요"),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
