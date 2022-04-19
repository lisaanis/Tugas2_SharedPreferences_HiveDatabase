import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas2_sharedpreference_hivedb/feature/dashboard_page.dart';
import 'package:tugas2_sharedpreference_hivedb/feature/register_page.dart';
import 'package:tugas2_sharedpreference_hivedb/model/user_list_model.dart';
import 'package:tugas2_sharedpreference_hivedb/tools/common_submit_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage ({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Box<UserListModel> hiveDB = Hive.box<UserListModel>("user_list");

  final Future<SharedPreferences> _myPref = SharedPreferences.getInstance();

  TextEditingController username_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Container(
        key: _formKey,
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              controller: username_controller,
              decoration: const InputDecoration(
                hintText: 'Username',
                ),
                validator: (value) {
                  if (value == null) {
                    return "Username kosong";
                  } else
                    return null;
                }
              ),
            TextFormField(
              controller: password_controller,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              obscureText: true,
                validator: (value) {
                  if (value == null) {
                    return "Password kosong";
                  } else
                    return null;
                }
            ),
            SizedBox(height: 5),
            _buildLoginButton(),
            SizedBox(height: 10),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton(){
    return CommonSubmitButton(
        labelButton: "Login",
        submitCallback: (value){

          _prosesLogin();
        }
    );
  }

  Widget _buildRegisterButton(){
    return CommonSubmitButton(
        labelButton: "Register",
        submitCallback: (value){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return RegisterPage();
          }));
        }
    );
  }

  void _prosesLogin() async {
    String currentUsername = username_controller.value.text;
    String currentPassword = password_controller.value.text;

    for(int i=0; i<hiveDB.length; i++) {
      final user = hiveDB.getAt(i);
      if(currentUsername == user!.username) {
        if(currentPassword == user.password) {
          SharedPreferences getPref = await _myPref;
          await getPref.setBool("loginStatus", true);

          Hive.box('logindata').put('loginStatus', true);
          Hive.box('logindata').put('username', currentUsername);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (builder) => DashboardPage()
          ));
        }
      }
    }
  }

}
