import 'package:hotels_clients_app/auth_screen_second.dart';
import 'package:hotels_clients_app/reg_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'styles.dart';
import './repository/api_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 253, 255, 1),
      body: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 87),
                  MailInput(controller: emailController),
                  const SizedBox(height: 24),
                  PasswordInput(controller: passwordController),
                  const SizedBox(height: 24),
                  ButtonIn(
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                  const SizedBox(height: 64),
                  const RegFormText(),
                ],
              )
            ],
          )),
    );
  }
}

class MailInput extends StatefulWidget {
  final TextEditingController controller;
  const MailInput({super.key, required this.controller});

  @override
  State<MailInput> createState() => _MailInputState();
}

class _MailInputState extends State<MailInput> {
  final _emailController = TextEditingController();

  // Регулярное выражение для проверки правильности email
  final String _emailPattern = r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$';

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Метод валидации email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите почту';
    }
    final regExp = RegExp(_emailPattern);
    if (!regExp.hasMatch(value)) {
      return 'Некорректный формат почты';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 325,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(255, 255, 255, 1),
              prefixIcon: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset('assets/images/mail.png')),
              hintText: 'Почта',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(244, 244, 244, 1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(244, 244, 244, 1),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 238, 134, 126),
                  width: 2.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 240, 127, 119),
                  width: 2.0,
                ),
              ),
              hintStyle: dropDownButtonText,
            ),
            validator: _validateEmail, // Валидация email
          ),
        ),
      ),
    );
  }
}

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  const PasswordInput({super.key, required this.controller});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true; // Добавлено для переключения видимости пароля

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? _validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Пароль должен содержать не менее 6 символов';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 325,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: TextFormField(
            controller: widget.controller,
            obscureText:
                _obscureText, // Используем переменную для скрытия текста
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(255, 255, 255, 1),
              prefixIcon: SizedBox(
                  width: 40, child: Image.asset('assets/images/password.png')),
              hintText: 'Пароль',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(244, 244, 244, 1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(244, 244, 244, 1),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 238, 134, 126),
                  width: 2.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 240, 127, 119),
                  width: 2.0,
                ),
              ),
              hintStyle: dropDownButtonText,
              suffixIcon: IconButton(
                // Добавлено для переключения видимости пароля
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: const Color.fromRGBO(180, 180, 180, 1),
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
            validator: _validatePassword,
          ),
        ),
      ),
    );
  }
}

class RegFormText extends StatelessWidget {
  const RegFormText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 251,
      height: 55,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            fontFamily: 'Philosopher',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.85,
            height: 1.2,
            color: Color.fromRGBO(59, 59, 59, 1),
          ),
          children: [
            const TextSpan(text: 'Для регистрации нового личного кабинета'),
            TextSpan(
                text: ' нажмите сюда.',
                style: const TextStyle(
                  color: Color.fromRGBO(27, 194, 122, 1),
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegForm()));
                  }),
          ],
        ),
      ),
    );
  }
}

class ButtonIn extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const ButtonIn(
      {super.key,
      required this.emailController,
      required this.passwordController});

  @override
  State<ButtonIn> createState() => ButtonInState();
}

class ButtonInState extends State<ButtonIn> {
  final ApiService _apiService = ApiService(); // Создайте экземпляр ApiService
  final TokenStorage _tokenStorage =
      TokenStorage(); // Создаем экземпляр TokenStorage

  bool _isLoading = false; // Переменная для отслеживания состояния загрузки

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      height: 57,
      decoration: commonButtonStyle,
      child: TextButton(
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
        ),
        onPressed: () async {
          // Проверяем, если форма валидна
          if (Form.of(context).validate()) {
            setState(() {
              _isLoading = true; // Включаем индикатор загрузки
            });

            String email = widget.emailController.text;
            String password = widget.passwordController.text;

            try {
              final response =
                  await _apiService.loginUser(email: email, password: password);

              // Проверяем, успешен ли ответ от сервера
              if (response.data['success'] == true) {
                // Сохраняем токен в безопасное хранилище
                final token = response.data['token'];
                await _tokenStorage.saveToken(token);
                await TokenStorage().printToken();

                // Переходим на следующий экран с анимацией
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AuthScreenSecond()),
                );
              } else {
                String errorMessage =
                    response.data['error'] ?? 'Неизвестная ошибка';
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                          style: buttonTextStyle, 'Ошибка: $errorMessage')),
                );
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                        style: buttonTextStyle, 'Ошибка: ${e.toString()}')),
              );
            } finally {
              setState(() {
                _isLoading = false; // Выключаем индикатор загрузки
              });
            }
          }
        },
        // Если идет загрузка, показываем CircularProgressIndicator, иначе - текст кнопки
        child: _isLoading
            ? const CircularProgressIndicator(
                color: Colors.white, // Цвет спиннера
              )
            : const Text('Войти', style: buttonTextStyle),
      ),
    );
  }
}
