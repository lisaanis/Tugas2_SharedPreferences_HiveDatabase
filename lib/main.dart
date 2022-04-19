import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tugas2_sharedpreference_hivedb/feature/login_page.dart';
import 'package:tugas2_sharedpreference_hivedb/model/user_list_model.dart';
late Box hiveDB;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserListModelAdapter());
  await Hive.openBox<UserListModel>("user_list");
  hiveDB = await Hive.openBox('logindata');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
