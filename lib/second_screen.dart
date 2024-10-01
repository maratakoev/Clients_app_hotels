import 'package:flutter/material.dart';
import './third_screen.dart';
import 'styles.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
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
            Image.asset('assets/images/imagesecond.png'),
            const SizedBox(height: 102),
            const TitleSecond(),
            const SizedBox(height: 102),
            const Button()
          ],
        ),
      ),
    );
  }
}

class TitleSecond extends StatelessWidget {
  const TitleSecond({super.key});

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
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))))),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ThirdScreen()));
        },
        child: const Text(
          'Хорошо',
          style: buttonTextStyle,
        ),
      ),
    );
  }
}
