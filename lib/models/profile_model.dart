import 'package:flutter/foundation.dart';

class ProfileModel {
  ProfileModel({
    required this.userDiscription,
    required this.userName,
    this.profileId,
    this.image,
  });
 final String userName;
 final String userDiscription;
 final int? profileId;
 final String? image;

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return ProfileModel(
      profileId: data['id'],
      userName: data['user'] != null
          ? data['user']['name']
          : (data['name'] ?? ""),
      userDiscription: data['description'] ?? "",
      image: data['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': userName, 'description': userDiscription};
  }
}
