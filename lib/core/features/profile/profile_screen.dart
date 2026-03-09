import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/Services/git_user_data.dart';
import 'package:to_do_app/Services/prefrense_manger_service.dart';
import 'package:to_do_app/Services/profile_service.dart';
import 'package:to_do_app/core/components/custome_svg_widget.dart';
import 'package:to_do_app/core/constants/storage_key.dart';
import 'package:to_do_app/main.dart';
import 'package:to_do_app/models/profile_model.dart';
import 'package:to_do_app/core/features/profile/user_details_screen.dart';
import 'package:to_do_app/core/features/welcome/welcome_screen.dart';
import 'package:to_do_app/core/theme/theme_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }


  String userName = "Gust";
  String userDescraption = "";
  String imageFromDB = "";
  File? _fileImage;
  ImagePicker imagePicker = ImagePicker();

  bool isLoading = false;
  var userId;

  _showDiloge(context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        alignment: Alignment.center,
        title: Text(
          "Chose Image Source",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        children: [
          // Text("Show diloge",style:Theme.of(context).textTheme.displaySmall)
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await imagePicker.pickImage(
                source: ImageSource.camera,
              );
              _updateImageRequst(image);
            },
            child: Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 20),
                Text(
                  'Camera',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 20),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await imagePicker.pickImage(
                source: ImageSource.gallery,
              );
              _updateImageRequst(image);
            },
            child: Row(
              children: [
                Icon(Icons.photo_library),
                SizedBox(width: 20),
                Text(
                  'Gallery',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 20),
                ),
              ],
            ),
          ),
          // SimpleDialogOption(onPressed: (){}, child:  Text("Show diloge",style:Theme.of(context).textTheme.displaySmall),)
        ],
      ),
    );
  }

  Future _updateImageRequst(image) async {
    if (image == null) {
      return;
    } else {
      setState(() {
        imageFromDB = image.path;
      });
    }

    final model = ProfileModel(
      profileId: userId,
      userDiscription: userDescraption,
      userName: userName,
      image: image.path,
    );

    final bool response = await ProfileService().updateProfile(model);
    if (response) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Imgage Updated Successfully")));
    } else
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Falid to update image")));
  }

  ImageProvider _getProfileImage() {
    if (imageFromDB.startsWith('http')) {
      return NetworkImage(imageFromDB);
    } else if (imageFromDB.isNotEmpty) {
      // لو المستخدم لسه مختار صورة من الموبايل، هنعرضها كملف
      return FileImage(File(imageFromDB));
    } else {
      // الصورة الافتراضية
      return const AssetImage('assets/images/personTwo.webp');
    }
  }

  Future _loadSettings() async {
    userId = PrefrenseManger().getInt(StorageKey.userId);
    isLoading = true;
    final response = await GitUserData().loadSettings();
    if (!mounted) return;
    setState(() {
      if (response != null) {
        userDescraption = response.userDiscription;
        userName = response.userName;
        imageFromDB = response.image ?? "";
        isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    "My Profile",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(fontSize: 20),
                    // textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: _getProfileImage(),
                        backgroundColor: Colors.transparent,
                        radius: 60,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                _showDiloge(context);
                              },
                              child: Icon(Icons.camera_alt),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  userName,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(fontSize: 20),
                ),

                Text(
                  userDescraption,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Profile info',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium!.copyWith(fontSize: 20),
                        ),

                        SizedBox(height: 18),

                        ListTile(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserDetailsScreen(),
                              ),
                            );

                            if (result != null && result) {
                              _loadSettings();
                              ;
                            }
                          },
                          contentPadding: EdgeInsets.zero,
                          title: Text("User Details"),
                          leading: CustomeSvgwidget(
                            imgUrl: 'assets/images/profile.svg',
                          ),

                          trailing: Icon(Icons.arrow_forward),
                        ),
                        SizedBox(height: 10),
                        Divider(thickness: 1),
                        SizedBox(height: 10),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CustomeSvgwidget(
                            imgUrl: "assets/images/dark.svg",
                          ),

                          title: Text("Dark Mode"),
                          trailing: ValueListenableBuilder<ThemeMode>(
                            valueListenable: ThemeController.themeNotifier,
                            builder: (context, value, child) {
                              return Switch(
                                value:
                                    ThemeController.themeNotifier.value ==
                                    ThemeMode.dark,
                                onChanged: (value) async {
                                  await ThemeController.toggleTheme();
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(thickness: 1),
                        ListTile(
                          onTap: () async {
                            setState(() {
                              
                              PrefrenseManger().remove(StorageKey.autToken);
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => WelcomeScreen(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            });
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: CustomeSvgwidget(
                            imgUrl: "assets/images/logOut.svg",
                          ),

                          title: Text("Log Out"),
                          trailing: Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
