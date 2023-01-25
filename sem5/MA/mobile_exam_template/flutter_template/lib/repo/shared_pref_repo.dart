import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepo {
  static late Future<SharedPreferences> _future;
  static const String ownerName = "ownerName";

  SharedPrefsRepo() {
    _future = SharedPreferences.getInstance();
  }

  Stream<String?> getOwnerName() {
    return _future.then((sp) => sp.getString(ownerName)).asStream();
  }

  Stream<bool> setOwnerName(String name) {
    return _future.then((sp) => sp.setString(ownerName, name)).asStream();
  }

}
