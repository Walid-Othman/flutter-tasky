
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/Controllers/profile_controller.dart';
import 'package:to_do_app/core/components/custome_text_form_fild_widget.dart';

class UserDetailsScreen extends StatelessWidget {
   UserDetailsScreen({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // late TextEditingController userName ;
  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = context.watch<ProfileController>();
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
                controller: controller.name,
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
                  controller: controller.description,
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
                  // final userId = PrefrenseManger().getInt(StorageKey.userId);

                  if (_key.currentState?.validate() ?? false) {
                    isLoding = true;
                    final bool response = await context
                        .read<ProfileController>()
                        .updateProfile();
                    if (response) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Profile updated successfully')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Faild to update profile data')),
                      );
                    }

                    Navigator.of(context).pop(true);
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
