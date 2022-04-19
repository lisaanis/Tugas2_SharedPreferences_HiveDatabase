import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tugas2_sharedpreference_hivedb/feature/login_page.dart';
import 'package:tugas2_sharedpreference_hivedb/model/user_list_model.dart';
import 'package:tugas2_sharedpreference_hivedb/tools/common_submit_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage ({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final hiveDB = Hive.box<UserListModel>("user_list");

  TextEditingController username_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      body: Container(
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
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterButton(){
    return CommonSubmitButton(
        labelButton: "Register",
        submitCallback: (String){
          hiveDB.add(UserListModel(username: username_controller.text, password: password_controller.text));
          username_controller.clear();
          setState(() {});
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return LoginPage();
          }));
        }
    );
  }
}
