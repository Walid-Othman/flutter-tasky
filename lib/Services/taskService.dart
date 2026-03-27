import 'package:dio/dio.dart';
import 'package:to_do_app/Services/ip_config.dart';
import 'package:to_do_app/Services/prefrense_manger_service.dart';
import 'package:to_do_app/core/constants/storage_key.dart';
import '../models/task_model.dart';

class TaskService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://${IpConfig.ipConfig}:8000/api',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  );

  TaskService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final String token =
              PrefrenseManger().getString(StorageKey.autToken) ?? "";

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            // 1. الوصول لـ SharedPreferences لحذف التوكن

            await PrefrenseManger().remove(StorageKey.autToken);

            print("غير مصرح به (401): تم حذف التوكن والتوجه لتسجيل الدخول.");

            // 2. التوجيه لصفحة تسجيل الدخول (Login)
            // ملاحظة: navigatorKey يجب أن يكون معرفاً في MaterialApp كما شرحنا سابقاً
            // navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
          }

          return handler.next(e);
        },
      ),
    );
  }

  Future<List<TaskModel>> getTasks() async {
    try {
      final response = await _dio.get('/tasks');

      List<dynamic> data = response.data['data'];
      return data.map((task) => TaskModel.fromJson(task)).toList();
    } on DioException catch (e) {
      print("Somethig went wrong in systerm: ${e.message}");
      return [];
    }
  }

  Future<bool> addTask(TaskModel task) async {
    try {
      final response = await _dio.post("/tasks", data: task.toMap());
      return response.statusCode == 200 || response.statusCode == 201;
    } on DioException catch (e) {
      print("Somthing went wrong in system ${e.message}");
      return false;
    }
  }

  Future<bool> upDateTask(TaskModel task) async {
    try {
      final response = await _dio.put(
        '/tasks/${task.taskId}',
        data: task.toMap(),
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      print("Something went wrong : ${e.message}");
      return false;
    }
  }

  Future<bool> deleteTask(int taskId) async {
    try {
      final response = await _dio.delete('/tasks/$taskId');
      return response.statusCode == 200;
    } on DioException catch (e) {
      print("something went wrong : ${e.message}");
      return false;
    }
  }
}
