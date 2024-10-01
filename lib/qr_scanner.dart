import './auth_screen_second.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'styles.dart';

class BarcodeScannerSimple extends StatefulWidget {
  const BarcodeScannerSimple({super.key});

  @override
  State<BarcodeScannerSimple> createState() => _BarcodeScannerSimpleState();
}

class _BarcodeScannerSimpleState extends State<BarcodeScannerSimple> {
  Barcode? _barcode;
  Color cornerColor = Colors.white;
  bool buttonActive = false; // Состояние кнопки

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });

      if (_barcode != null) {
        // Изменяем цвет углов
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              cornerColor = Colors.green; // Изменяем цвет углов
              buttonActive = true; // Активируем кнопку
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(250, 253, 255, 1),
        centerTitle: true,
        title: const Text('Сканировать QR', style: scannerTextStyle),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      backgroundColor: const Color.fromRGBO(250, 253, 255, 1),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    MobileScanner(
                      onDetect: _handleBarcode,
                    ),
                  ],
                ),
              ),
              // Обозначение углов
              Positioned(
                top: 50,
                left: 95,
                child: Container(
                  height: 31,
                  width: 34,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 6.0, color: cornerColor),
                      left: BorderSide(width: 6.0, color: cornerColor),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 95,
                child: Container(
                  height: 31,
                  width: 34,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 6.0, color: cornerColor),
                      right: BorderSide(width: 6.0, color: cornerColor),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                left: 95,
                child: Container(
                  height: 31,
                  width: 34,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 6.0, color: cornerColor),
                      left: BorderSide(width: 6.0, color: cornerColor),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                right: 95,
                child: Container(
                  height: 31,
                  width: 34,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 6.0, color: cornerColor),
                      right: BorderSide(width: 6.0, color: cornerColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SizedBox(
            width: 265,
            height: 64,
            child: Text(
              textAlign: TextAlign.center,
              style: scannerTextStyle,
              'Forrest Terrace Hotel, Владикавказ, Верхний Фиагдон \n №301',
            ),
          ),
          const SizedBox(height: 24),
          Button(isActive: buttonActive) // Передаем состояние кнопки
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final bool isActive;
  const Button({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      height: 57,
      decoration: BoxDecoration(
        gradient: isActive
            ? const LinearGradient(
                colors: [
                  Color.fromRGBO(83, 232, 139, 1),
                  Color.fromRGBO(21, 190, 119, 1),
                ],
              )
            : null,
        color: isActive ? null : Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
        ),
        onPressed: isActive
            ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AuthScreenSecond(),
                  ),
                );
              }
            : null,
        child: const Text(
          'Готово',
          style: buttonTextStyle,
        ),
      ),
    );
  }
}
