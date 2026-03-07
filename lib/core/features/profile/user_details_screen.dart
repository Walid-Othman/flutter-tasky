import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/Services/profile_service.dart';
import 'package:to_do_app/core/widgets/custome_text_form_fild_widget.dart';
import 'package:to_do_app/models/profile_model.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreen();
}

class _UserDetailsScreen extends State<UserDetailsScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController userName = TextEditingController();
  final TextEditingController userDiscription = TextEditingController();
  bool isLoding = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Deatails"), toolbarHeight: 50),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomeTextFormFild(
                controller: userName,
                hintText: "Enter your name",
                title: "user name",
                maxLength: 30,
                validator: (value) {
                  return ' Plese Enter your name';
                },
              ),
              SizedBox(height: 10),

              Expanded(
                child: CustomeTextFormFild(
                  controller: userDiscription,
                  hintText: "Enter your discription ",
                  title: 'UserDiscription',
                  maxLines: 4,
                  maxLength: 100,
                  validator: (value) {
                    return "plese Enter your discription";
                  },
                ),
              ),

              // TEXT FORM FIELD FOR DESCRIPTION ENDS HERE
              ElevatedButton(
                onPressed: () async {
                  final pref = await SharedPreferences.getInstance();
                  final userId = pref.getInt('user_id');
                  if (_key.currentState?.validate() ?? false) {
                    final model = ProfileModel(
                      userDiscription: userDiscription.text,
                      userName: userName.text,
                      profileId: userId,
                    );
                    isLoding = true;
                    bool success = await ProfileService().updateProfile(model);
                    if (success) {
                      print('Saved successfuly');
                      Navigator.of(context).pop(true);
                      setState(() {
                        isLoding = false;
                      });
                    } else {
                      print("some thing went wrong in updated");
                    }
                  }
                },
                child: Text("Come Chagne"),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
              ),
              if (isLoding) Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
