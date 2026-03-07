import 'package:to_do_app/Services/prefrense_manger_service.dart';
import 'package:to_do_app/Services/profile_service.dart';

class GitUserData {
  Future loadSettings() async {
    final userId = PrefrenseManger().getInt('user_id') ?? 0;

    final response = await ProfileService().getProfileDate(userId!);

    if (response != null) {
      return response;
    }
  }
}
