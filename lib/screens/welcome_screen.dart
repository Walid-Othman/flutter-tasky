import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_app/core/widgets/custome_svg_widget.dart';
import 'package:to_do_app/core/widgets/custome_text_form_fild_widget.dart';
import 'package:to_do_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_app/Services/google_servic.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  final TextEditingController controller = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  Future getName(String userName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
  }

  Future chickToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final userToken = pref.getString('auth_token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 40,
                    bottom: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomeSvgwidget.withoutColor(
                        imgUrl: 'assets/images/logo.svg',
                        width: 42,
                        height: 42,
                      ),

                      SizedBox(width: 16),
                      Text(
                        "Tasky",
                        style: Theme.of(context).textTheme.displayMedium,

                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome To Tasky ",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(width: 8),
                    CustomeSvgwidget.withoutColor(
                      imgUrl: 'assets/images/hand.svg',
                      width: 28,
                      height: 28,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Your productivity journey starts here.',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 16),
                ),
                SizedBox(height: 24),
                CustomeSvgwidget.withoutColor(
                  imgUrl: 'assets/images/office.svg',
                  width: 215,
                  height: 204,
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),

                      CustomeTextFormFild(
                        controller: controller,
                        hintText: 'e.g.  Walid Othman',
                        title: 'Full Name',
                        validator: (value) {
                          return "please Enter your name";
                        },
                      ),

                      SizedBox(height: 24),

                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Color(0xFF15B86C),
                      //     foregroundColor: Color(0xFFFFFCFC),
                      //     fixedSize: Size(
                      //       MediaQuery.of(context).size.width,
                      //       40,
                      //     ),
                      //   ),
                      //   onPressed: () async {
                      //     if (_key.currentState?.validate() ?? false) {
                      //       await getName(controller.text);
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (BuildContext context) => HomeScreen(),
                      //         ),
                      //       );
                      //     }
                      //   },
                      //   child: Text(
                      //     "Let’s Get Started",
                      //     style: TextStyle(
                      //       fontSize: 18,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            45,
                          ),
                        ),
                        onPressed: () async {
                          // إظهار علامة تحميل (Loading)
                          showDialog(
                            context: context,
                            builder: (context) =>
                                Center(child: CircularProgressIndicator()),
                          );

                          // استدعاء السيرفيس
                          bool success = await GoogleAuthService()
                              .handleGoogleLogin();

                          // إغلاق علامة التحميل
                          Navigator.pop(context);

                          if (success) {
                            // الانتقال لصفحة الـ Home لو نجح
                            //  MaterialPageRoute(
                            //  builder: (BuildContext context) => HomeScreen(),
                            //                          );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          } else {
                            // إظهار رسالة خطأ
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("فشل تسجيل الدخول بجوجل")),
                            );
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Use google", style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
