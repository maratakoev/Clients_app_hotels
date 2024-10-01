import 'package:flutter/material.dart';
import 'reg_form.dart';
import 'styles.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 253, 255, 1),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 102),
            Image.asset('assets/images/logo.png'),
            const SizedBox(height: 60),
            Image.asset('assets/images/imagethird.png'),
            const SizedBox(height: 102),
            const TitleThird(),
            const SizedBox(height: 102),
            const Button()
          ],
        ),
      ),
    );
  }
}

class TitleThird extends StatelessWidget {
  const TitleThird({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 297,
      child: Text(
        'Оплачивайте прямо в приложении',
        textAlign: TextAlign.center,
        softWrap: true,
        style: commonTextStyle,
      ),
    );
  }
}

class Button extends StatefulWidget {
  const Button({super.key});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
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
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegForm()));
        },
        child: const Text(
          'Поехали',
          style: buttonTextStyle,
        ),
      ),
    );
  }
}
