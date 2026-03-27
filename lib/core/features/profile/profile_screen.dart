import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/Controllers/profile_controller.dart';
import 'package:to_do_app/core/components/custome_alert_dialog.dart';
import 'package:to_do_app/core/components/custome_svg_widget.dart';
import 'package:to_do_app/core/enums/action_enum.dart';
import 'package:to_do_app/core/features/profile/user_details_screen.dart';
import 'package:to_do_app/core/features/welcome/welcome_screen.dart';
import 'package:to_do_app/core/theme/theme_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  ImageProvider _getProfileImageProvider(String image) {
    // if (image.isEmpty) {
    //   return const AssetImage('assets/images/personTwo.webp');
    // }

    if (image.startsWith('http')) {
      // كسر الـ Cache بإضافة timestamp للرابط
      return NetworkImage(image);
    }

    return FileImage(File(image));
  }
  // File? _fileImage;

  final ImagePicker imagePicker = ImagePicker();

  final bool isLoading = false;

  void _showDiloge(BuildContext rootContext) {
    showDialog(
      // context: context,
      context: rootContext,
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
              if(image == null ) return ; 
              // _updateImageRequst(image);
              // if (!mounted) return;
              ProfileController controller = rootContext
                  .read<ProfileController>();
              bool response = await controller.updateImageRequst(image);
              if (response) {
                ScaffoldMessenger.of(rootContext).showSnackBar(
                  SnackBar(content: Text("Imgage Updated Successfully")),
                );
              } else {
                ScaffoldMessenger.of(rootContext).showSnackBar(
                  SnackBar(content: Text("Falid to update image")),
                );
              }
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
              if(image == null) return ;
              // _updateImageRequst(image);
              // if (!mounted) return;
              ProfileController controller = rootContext
                  .read<ProfileController>();
              bool response = await controller.updateImageRequst(image);
              if (response) {
                ScaffoldMessenger.of(rootContext).showSnackBar(
                  SnackBar(content: Text("Imgage Updated Successfully")),
                );
              } else {
                ScaffoldMessenger.of(rootContext).showSnackBar(
                  SnackBar(content: Text("Falid to update image")),
                );
              }
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

  // Future _updateImageRequst(image) async {
  @override
  Widget build(BuildContext context) {
    print("this is profile:${context.watch<ProfileController>().profile}");
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
                      Selector<ProfileController, String>(
                        selector: (context, controller) =>
                            controller.imageFromDB,
                        builder: (_, imageFromDB, _) {
                          return CircleAvatar(
                            backgroundImage: _getProfileImageProvider(
                              imageFromDB,
                            ),
                            backgroundColor: Colors.transparent,
                            radius: 60,
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 35.w,
                          height: 35.h,
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
                    ],
                  ),
                ),
                SizedBox(height: 6),
                Selector<ProfileController, String>(
                  selector: (context, controller) => controller.userName,
                  builder: (context, userName, child) {
                    return Text(
                      userName,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(fontSize: 20),
                    );
                  },
                ),

                Selector<ProfileController, String>(
                  selector: (context, controller) => controller.userDescraption,
                  builder: (_, userDescraption, _) {
                    return Text(
                      userDescraption,
                      style: Theme.of(context).textTheme.titleSmall,
                    );
                  },
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
                              // _loadSettings();
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
                          final rootContext = context ;
                            (
                              child: showDialog(
                                context: context,
                                 builder: (context)=>
                                CustomeAlertDialog(
                                  actionName: "LogOut",
                                  title: " Log Out ",
                                  content: 'Are you sure you want to log out?',
                                  actionType: ActionEnum.delete,
                                  onPress: () async {
                                    bool response = await rootContext
                                        .read<ProfileController>()
                                        .logOut();
                                    if (response) {
                                      Navigator.of( rootContext).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (rootContext) => WelcomeScreen(),
                                        ),
                                        (Route<dynamic> reoute) => false,
                                      );
                                    }
                                  },
                                ),
                              ),
                            );
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
