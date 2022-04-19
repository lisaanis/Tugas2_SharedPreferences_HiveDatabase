import 'package:hive/hive.dart';

part 'user_list_model.g.dart';

@HiveType(typeId: 1)
class UserListModel extends HiveObject{

  UserListModel({required this.username, required this.password});

  @HiveField(0)
  String username;
  @HiveField(1)
  String password;

  @override
  String toString() {
    return 'UserListModel{name: $username, password: $password}';
  }
}