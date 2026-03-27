import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Services/prefrense_manger_service.dart';
import 'package:to_do_app/Services/profile_service.dart';
import 'package:to_do_app/core/constants/storage_key.dart';
import 'package:to_do_app/models/profile_model.dart';

class ProfileController with ChangeNotifier {
  bool isLoading = false;
  ProfileModel? profile;
  String userName = "Gust";
  String userDescraption = "";
  String imageFromDB = "";
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  int userId = PrefrenseManger().getInt(StorageKey.userId);
  void getProfile() async {
    if (profile == null) {
      isLoading = true;
    }
    try {
      int userId = PrefrenseManger().getInt(StorageKey.userId);
      final result = await ProfileService().getProfileDate(userId);
      if (result != null) {
        profile = result;
        userName = result.userName;
        userDescraption = result.userDiscription;
        imageFromDB = result.image ?? "";
        name.text = result.userName;
        description.text = result.userDiscription;
      }
    } catch (e) {
      debugPrint("Error fetching profile: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future updateImageRequst(image) async {
    if (image == null) {
      return;
    } else {
      imageFromDB = image.path;
      notifyListeners();
    }

    final model = ProfileModel(
      profileId: userId,
      userDiscription: userDescraption,
      userName: userName,
      image: image.path,
    );

    final bool response = await ProfileService().updateProfile(model);
    notifyListeners();
    return response;
  }

  Future logOut() async {
    try {
      final response = PrefrenseManger().remove(StorageKey.autToken);
      return response;
    } catch (e) {
      debugPrint("Faild to log out : $e");
    }
    notifyListeners();
  }

  Future updateProfile() async {
    try {
      final model = ProfileModel(
        userName: name.text,
        userDiscription: description.text,
        profileId: userId);
      final response = await ProfileService().updateProfile(model);
      userDescraption = description.text;
      userName = name.text;
      notifyListeners();

      return response;
    } catch (e) {
      debugPrint("Faild to update Prfile data : $e");
    } finally {
      notifyListeners();
    }
  }
  @override
  void dispose() {
    name.dispose();
    description.dispose();
    super.dispose();
  }
}
