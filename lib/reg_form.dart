import './login_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'styles.dart';
import './repository/api_service.dart';

class RegForm extends StatefulWidget {
  const RegForm({super.key});

  @override
  State<RegForm> createState() => _RegFormState();
}

class _RegFormState extends State<RegForm> {
  final _formKey = GlobalKey<FormState>();

  // Создаем контроллеры для каждого поля ввода
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Метод для проверки совпадения паролей

  // Освобождаем ресурсы контроллеров при удалении виджета
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 253, 255, 1),
      body: Form(
        key: _formKey,
        child: ListView(children: [
          Column(
            children: [
              const SizedBox(height: 87),
              NameInput(controller: nameController),
              const SizedBox(height: 24),
              SurnameInput(controller: surnameController),
              const SizedBox(height: 24),
              MailInput(controller: emailController),
              const SizedBox(height: 24),
              PasswordInput(controller: passwordController),
              const SizedBox(height: 24),
              ConfirmPasswordInput(
                controller: confirmPasswordController,
                passwordController: passwordController,
              ),
              const SizedBox(height: 24),
              const AuthScreenText(),
              const SizedBox(height: 24),
              Button(
                  firstNameController: nameController,
                  lastNameController: surnameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController),
              const SizedBox(height: 34),
              const LogInText(),
            ],
          ),
        ]),
      ),
    );
  }
}

class NameInput extends StatefulWidget {
  final TextEditingController controller;
  const NameInput({super.key, required this.controller});

  @override
  State<NameInput> createState() => _NameInputState();
}

class _NameInputState extends State<NameInput> {
  // Метод для валидации имени
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите имя';
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
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(255, 255, 255, 1),
              prefixIcon: Image.asset('assets/images/room.png'),
              hintText: 'Имя',
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
            validator: _validateName, // Добавлена валидация имени
          ),
        ),
      ),
    );
  }
}

class SurnameInput extends StatefulWidget {
  final TextEditingController controller;
  const SurnameInput({super.key, required this.controller});

  @override
  State<SurnameInput> createState() => _SurnameInputState();
}

class _SurnameInputState extends State<SurnameInput> {
  // Метод для валидации фамилии
  String? _validateSurname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите фамилию';
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
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(255, 255, 255, 1),
              prefixIcon: Image.asset('assets/images/room.png'),
              hintText: 'Фамилия',
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
            validator: _validateSurname, // Добавлена валидация фамилии
          ),
        ),
      ),
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

class ConfirmPasswordInput extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController controller;

  const ConfirmPasswordInput({
    super.key,
    required this.controller,
    required this.passwordController,
  });

  @override
  State<ConfirmPasswordInput> createState() => _ConfirmPasswordInputState();
}

class _ConfirmPasswordInputState extends State<ConfirmPasswordInput> {
  bool _obscureText = true; // Для переключения видимости пароля

  // Функция для переключения видимости пароля
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Логика валидации для подтверждения пароля
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, подтвердите пароль';
    } else if (value != widget.passwordController.text) {
      // Доступ через widget
      return 'Пароли не совпадают'; // Исправлено сообщение
    }
    return null; // Возвращаем null, если валидация прошла успешно
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
              hintText: 'Подтверждение пароля',
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
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: const Color.fromRGBO(180, 180, 180, 1),
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
            validator:
                _validateConfirmPassword, // Используем метод для валидации
          ),
        ),
      ),
    );
  }
}

class AuthScreenText extends StatelessWidget {
  const AuthScreenText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 251,
      height: 55,
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(
            fontFamily: 'Philosopher',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.85,
            height: 1.2,
            color: Color.fromRGBO(59, 59, 59, 1),
          ),
          children: [
            TextSpan(text: 'Нажимая зарегистрироваться я соглашаюсь с'),
            TextSpan(
              text: ' правилами сервиса',
              style: TextStyle(
                color: Color.fromRGBO(27, 194, 122, 1),
              ),
            ),
            TextSpan(text: ' и '),
            TextSpan(
              text: 'политикой конфиденциальности',
              style: TextStyle(
                color: Color.fromRGBO(27, 194, 122, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Button extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const Button({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  ButtonState createState() => ButtonState(); // Измените здесь на ButtonState
}

class ButtonState extends State<Button> {
  // Измените на ButtonState
  bool _isLoading = false; // Состояние загрузки

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
        onPressed:
            _isLoading ? null : _registerUser, // Используем отдельный метод
        child: _isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : const Text('Зарегистрироваться', style: buttonTextStyle),
      ),
    );
  }

  Future<void> _registerUser() async {
    if (Form.of(context).validate()) {
      setState(() {
        _isLoading = true; // Устанавливаем состояние загрузки
      });

      final apiService = ApiService();
      // Собираем данные из контроллеров
      final firstName = widget.firstNameController.text;
      final lastName = widget.lastNameController.text;
      final email = widget.emailController.text;
      final password = widget.passwordController.text;
      final confirmPassword = widget.confirmPasswordController.text;

      try {
        // Отправляем запрос на регистрацию и получаем ответ
        var response = await apiService.registerUser(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          guard: "client",
        );

        // Проверяем, смонтирован ли виджет перед использованием контекста
        if (!mounted) return;

        // Обрабатываем ответ от сервера
        if (response.data['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                response.data['message'],
                style: buttonTextStyle,
              ),
            ),
          );

          // Задержка на 2 секунды перед переходом на другой экран
          Future.delayed(const Duration(seconds: 2), () {
            if (!mounted) return; // Проверка на mounted
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginForm(),
              ),
            );
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                response.data['error'],
                style: buttonTextStyle,
              ),
            ),
          );
        }
      } catch (e) {
        // Проверка на mounted перед использованием контекста
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text(style: buttonTextStyle, 'Ошибка сети: $e')),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false; // Сбрасываем состояние загрузки
          });
        }
      }
    }
  }
}

class LogInText extends StatelessWidget {
  const LogInText({super.key});

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
            const TextSpan(text: 'Уже есть аккаунт?'),
            TextSpan(
                text: ' \n Нажмите сюда!',
                style: const TextStyle(
                  color: Color.fromRGBO(27, 194, 122, 1),
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginForm()));
                  }),
          ],
        ),
      ),
    );
  }
}
