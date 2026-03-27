import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/Services/ip_config.dart';
import 'package:to_do_app/Services/prefrense_manger_service.dart';
import 'package:to_do_app/core/constants/storage_key.dart';
import 'package:to_do_app/models/profile_model.dart';

class ProfileService {
  late Dio _dio;
  final String basUrl = 'http://${IpConfig.ipConfig}:8000/api/';
  ProfileService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: basUrl,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = PrefrenseManger().getString(StorageKey.autToken);
          options.headers['Accept'] = 'application/json';
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          print("API Error: ${e.response?.statusCode} - ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  Future<ProfileModel?> getProfileDate(int profileId) async {
    try {
      Response response = await _dio.get('profile/$profileId');
      if (response.statusCode == 200) {
        print(response);
        return ProfileModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error featching Profile data");
      return null;
    }
  }

  Future<bool> updateProfile(ProfileModel profile) async {
    try {
      // 1. تحويل المودل لـ Map
      Map<String, dynamic> dataMap = profile.toMap();

      // 2. إضافة حقل الخدعة (Method Overriding)
      dataMap['_method'] = 'PUT';

      // 3. التعامل مع الصورة (لازم تحولها لـ MultipartFile عشان تتبعت)
      if (profile.image != null && profile.image!.isNotEmpty) {
        dataMap['image'] = await MultipartFile.fromFile(
          profile.image!,
          filename: profile.image!.split('/').last,
        );
      }

      // 4. تحويل الـ Map لـ FormData (إلزامي طالما فيه صور وملفات)
      FormData formData = FormData.fromMap(dataMap);

      // 5. إرسال الريكوست مع التأكد من الـ URL (استخدام الـ ID)
      Response response = await _dio.post(
        'profile/${profile.profileId}', // التعديل هنا لبعث الرقم مش الكلاس نفسه
        data: formData, // نبعث الـ formData اللي جواه الخدعة والصور
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }

      return false;
    } catch (e) {
      print("Error updating profile: $e");
      return false;
    }
  }
}
