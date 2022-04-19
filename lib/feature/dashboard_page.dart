import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tugas2_sharedpreference_hivedb/feature/login_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final hiveDB = Hive.box('login');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (builder) => LoginPage()
                )
            );
          },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: Center(
        child: Row(
          children: [
            Text('Hello, ${hiveDB.get('username')}',
            style: TextStyle(
              fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}
