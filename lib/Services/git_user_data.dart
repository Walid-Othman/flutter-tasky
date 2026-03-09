import 'package:to_do_app/Services/prefrense_manger_service.dart';
import 'package:to_do_app/Services/profile_service.dart';
import 'package:to_do_app/core/constants/storage_key.dart';

class GitUserData {
  Future loadSettings() async {
    final userId = PrefrenseManger().getInt(StorageKey.userId) ?? 0;

    final response = await ProfileService().getProfileDate(userId!);

    if (response != null) {
      return response;
    }
  }
}
