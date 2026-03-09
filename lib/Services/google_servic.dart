import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/Services/prefrense_manger_service.dart';
import 'package:to_do_app/core/constants/storage_key.dart';

class GoogleAuthService {
  // تعريف جوجل ساين إن
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '568297408457-0lebr4tph8jso589bjodiaqrmm0sp8fj.apps.googleusercontent.com',
    scopes: ['email'],
  );

  Future<bool> handleGoogleLogin() async {
    try {
      // 1. إظهار نافذة حسابات جوجل للمستخدم
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false; // المستخدم كنسل العملية

      // 2. الحصول على الـ Access Token من جوجل
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? accessToken = googleAuth.accessToken;

      // 3. إرسال التوكن للـ API بتاعك (الـ Laravel)
      // ملاحظة: لو شغال إيموليتر أندرويد استخدم 10.0.2.2 بدلاً من 127.0.0.1
      final response = await http.post(
        Uri.parse('http://10.142.8.89:8000/api/google/callback'),
        headers: {'Accept': 'application/json'},
        body: {'access_token': accessToken}, // السيرفيس في لارفل مستني ده
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String name = data['user']?['user']?['name']?.toString() ?? "User";
        int userId = data['user']?['user']?['id'];
        String token = data['token']?.toString() ?? "";
        print("البيانات المستلمة من السيرفر: $data");
        // 4. حفظ الـ Token اللي لارفل بعته في ذاكرة الموبايل
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(StorageKey.autToken, token);
        await prefs.setString(StorageKey.userName, name);
        await prefs.setInt(StorageKey.userId, userId);

        print("the user is : ${data['user']} \n the token is ${data['token']}");
        return true; // نجاح العملية
      } else {
        print("سيرفر لارفل رجع خطأ: ${response.body}");
        return false;
      }
    } catch (e) {
      print("خطأ غير متوقع: $e");
      return false;
    }
  }
}
