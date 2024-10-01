import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hotels_clients_app/qr_scanner.dart';
import 'styles.dart';
import './repository/api_service.dart';

class AuthScreenSecond extends StatefulWidget {
  const AuthScreenSecond({super.key});

  @override
  State<AuthScreenSecond> createState() => _AuthScreenSecondState();
}

class _AuthScreenSecondState extends State<AuthScreenSecond> {
  late ApiService apiService;
  List<String> organizationTitles =
      []; // Список названий организаций для DropDown

  @override
  void initState() {
    super.initState();
    apiService = ApiService(); // Создаем экземпляр класса ApiService
    _loadHotels(); // Вызов метода при загрузке страницы
  }

  Future<void> _loadHotels() async {
    try {
      final response = await apiService.getHotels(); // Вызов метода getHotels
      setState(() {
        organizationTitles = response.organizations
            .map((org) => org.title ?? 'Без названия')
            .toList(); // Извлекаем названия организаций
      });
      print('Список отелей: $organizationTitles');
    } catch (e) {
      print('Ошибка при получении списка отелей: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 253, 255, 1),
      body: Column(
        children: [
          const SizedBox(height: 87),
          // Передаем список названий отелей в DropDownButtonFirst
          DropDownButtonFirst(items: organizationTitles),
          const SizedBox(height: 18),
          DropDownButtonSecond(),
          const SizedBox(height: 18),
          DropDownButtonThird(),
          const SizedBox(height: 32),
          const Text('или'),
          const SizedBox(height: 32),
          Button()
        ],
      ),
    );
  }
}

class DropDownButtonFirst extends StatefulWidget {
  final List<String> items; // Добавляем список в конструктор

  const DropDownButtonFirst({super.key, required this.items});

  @override
  State<DropDownButtonFirst> createState() => _DropDownButtonFirst();
}

class _DropDownButtonFirst extends State<DropDownButtonFirst> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Row(
            children: [
              Image.asset('assets/images/room.png'),
              const SizedBox(
                width: 4,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'Ваш отель',
                    style: dropDownButtonText,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          items: widget.items // Используем список из родительского виджета
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromRGBO(244, 244, 244, 1)))),
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: Text(
                            item,
                            style: dropDownButtonText,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (String? value) {
            setState(() {
              selectedValue = value;
            });
          },
          buttonStyleData: ButtonStyleData(
            height: 57,
            width: 325,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color.fromRGBO(244, 244, 244, 1),
              ),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            elevation: 0,
          ),
          iconStyleData: IconStyleData(
            icon: Image.asset('assets/images/arrow_down.png'),
            iconSize: 14,
            iconEnabledColor: Colors.yellow,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 325,
            elevation: 0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              border: Border(
                left: BorderSide(color: Color.fromRGBO(244, 244, 244, 1)),
                right: BorderSide(color: Color.fromRGBO(244, 244, 244, 1)),
                bottom: BorderSide(color: Color.fromRGBO(244, 244, 244, 1)),
              ),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            offset: const Offset(0, 12),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: WidgetStateProperty.all<double>(6),
              thumbVisibility: WidgetStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}

class DropDownButtonSecond extends StatefulWidget {
  const DropDownButtonSecond({super.key});

  @override
  State<DropDownButtonSecond> createState() => _DropDownButtonSecond();
}

class _DropDownButtonSecond extends State<DropDownButtonSecond> {
  final List<String> items = [
    'Название номера 1',
    'Название номера 2',
    'Название номера 3',
    'Название номера 4',
    'Название номера 5',
    'Название номера 6',
    'Название номера 7',
    'Название номера 8',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Row(
            children: [
              Image.asset('assets/images/search.png'),
              const SizedBox(
                width: 4,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'Номер',
                    style: dropDownButtonText,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          items: items
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromRGBO(244, 244, 244, 1)))),
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: Text(
                            item,
                            style: dropDownButtonText,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (String? value) {
            setState(() {
              selectedValue = value;
            });
          },
          buttonStyleData: ButtonStyleData(
            height: 57,
            width: 325,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color.fromRGBO(244, 244, 244, 1),
              ),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            elevation: 0,
          ),
          iconStyleData: IconStyleData(
            icon: Image.asset('assets/images/arrow_down.png'),
            iconSize: 14,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 325,
            elevation: 0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              border: Border(
                left: BorderSide(color: Color.fromRGBO(244, 244, 244, 1)),
                right: BorderSide(color: Color.fromRGBO(244, 244, 244, 1)),
                bottom: BorderSide(color: Color.fromRGBO(244, 244, 244, 1)),
              ),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            offset: const Offset(0, 12),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: WidgetStateProperty.all<double>(6),
              thumbVisibility: WidgetStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}

class DropDownButtonThird extends StatefulWidget {
  const DropDownButtonThird({super.key});

  @override
  State<DropDownButtonThird> createState() => _DropDownButtonThird();
}

class _DropDownButtonThird extends State<DropDownButtonThird> {
  final List<String> items = [
    'Дата заезда 1',
    'Дата заезда 2',
    'Дата заезда 3',
    'Дата заезда 4',
    'Дата заезда 5',
    'Дата заезда 6',
    'Дата заезда 7',
    'Дата заезда 8',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Row(
            children: [
              Image.asset('assets/images/data.png'),
              const SizedBox(
                width: 4,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'Дата заезда',
                    style: dropDownButtonText,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          items: items
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromRGBO(244, 244, 244, 1)))),
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: Text(
                            item,
                            style: dropDownButtonText,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (String? value) {
            setState(() {
              selectedValue = value;
            });
          },
          buttonStyleData: ButtonStyleData(
            height: 57,
            width: 325,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color.fromRGBO(244, 244, 244, 1),
              ),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            elevation: 0,
          ),
          iconStyleData: IconStyleData(
            icon: Image.asset('assets/images/arrow_down.png'),
            iconSize: 14,
            iconEnabledColor: Colors.yellow,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 325,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              border: Border(
                left: BorderSide(color: Color.fromRGBO(244, 244, 244, 1)),
                right: BorderSide(color: Color.fromRGBO(244, 244, 244, 1)),
                bottom: BorderSide(color: Color.fromRGBO(244, 244, 244, 1)),
              ),
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            offset: const Offset(0, 12),
            elevation: 0,
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(15),
              thickness: WidgetStateProperty.all<double>(6),
              thumbVisibility: WidgetStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const BarcodeScannerSimple()));
        },
        child: const Text(
          'Сканировать QR',
          style: buttonTextStyle,
        ),
      ),
    );
  }
}
