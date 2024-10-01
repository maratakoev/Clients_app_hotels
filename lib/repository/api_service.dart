import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/organization.dart';

class ApiService {
  final Dio _dio = Dio(); // Инициализация Dio
  final FlutterSecureStorage _storage =
      const FlutterSecureStorage(); // Инициализация Secure Storage

  // запрос списка отелей
  Future<OrganizationResponse> getHotels() async {
    String? token = await _storage.read(key: 'token'); // Получаем токен

    final response = await _dio.get(
      'https://app.successhotel.ru/api/client/organizations', // URL для списка отелей
      options: Options(
        headers: {
          'Authorization': 'Bearer $token', // Токен
          'User-Agent': 'HotelsApp/1.0.0', // Идентификация приложения
          'Accept': 'application/json', // Ожидаемый тип данных
        },
      ),
    );

    // Выводим ответ сервера в консоль
    print('Ответ от сервера: ${response.data}');

    // Парсим ответ в модель OrganizationResponse
    OrganizationResponse organizationResponse =
        OrganizationResponse.fromJson(response.data);

    // Возвращаем объект OrganizationResponse
    return organizationResponse;
  }

  // Метод для регистрации пользователя
  Future<Response> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String guard,
  }) async {
    const String registerUrl =
        'https://app.successhotel.ru/api/client/register';

    try {
      final Map<String, dynamic> registrationData = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'guard': guard,
      };

      final Response response =
          await _dio.post(registerUrl, data: registrationData);

      return response;
    } catch (e) {
      print('Произошла ошибка: $e');
      rethrow; // Пробрасываем ошибку дальше
    }
  }

  // Метод для входа пользователя
  Future<Response> loginUser({
    required String email,
    required String password,
  }) async {
    const String loginUrl = 'https://app.successhotel.ru/api/client/login';

    try {
      final Map<String, dynamic> loginData = {
        'email': email,
        'password': password,
      };

      final Response response = await _dio.post(loginUrl, data: loginData);
      print('Response from server: ${response.data}'); // Полный ответ

      // Проверка успешности логина
      if (response.data['success'] == true) {
        String token = response.data['token']; // Извлекаем токен
        await TokenStorage().saveToken(token); // Сохраняем токен
        print('Token saved: $token'); // Выводим в консоль
      } else {
        print('Login failed: ${response.data['message']}'); // В случае ошибки
      }

      return response;
    } catch (e) {
      print('Произошла ошибка: $e');
      rethrow; // Пробрасываем ошибку дальше
    }
  }
}

// Тут сохраним токен.
class TokenStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String _key = 'token'; // Ключ для хранения токена

  // Метод для сохранения токена
  Future<void> saveToken(String token) async {
    await _storage.write(key: _key, value: token);
  }

  // Метод для получения токена
  Future<String?> getToken() async {
    return await _storage.read(key: _key);
  }

  // Метод для удаления токена
  Future<void> deleteToken() async {
    await _storage.delete(key: _key);
  }

  // Новый метод для вывода токена в консоль
  Future<void> printToken() async {
    String? token = await getToken();
    if (token != null) {
      print('Токен: $token');
    } else {
      print('Токен не найден.');
    }
  }
}
