import 'package:flutter/material.dart';
import './styles.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home Page',
      style: TextStyle(fontSize: 24),
    ),
    Text(
      'Business Page',
      style: TextStyle(fontSize: 24),
    ),
    Text(
      'School Page',
      style: TextStyle(fontSize: 24),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom NavBar with FAB'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape: const CircleBorder(),
        onPressed: () {},
        tooltip: 'Increment',
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(83, 232, 139, 1),
                Color.fromRGBO(21, 190, 119, 1),
              ],
            ),
          ),
          child: Image.asset('assets/images/service.png'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        child: CustomBottomAppBar(
          notchMargin: 8.0,
          fabSize: 56.0,
          onItemTapped: _onItemTapped,
          selectedIndex: _selectedIndex,
        ),
      ),
    );
  }
}

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
    required this.notchMargin,
    required this.fabSize,
    required this.onItemTapped,
    required this.selectedIndex,
  });

  final double notchMargin;
  final double fabSize;
  final ValueChanged<int> onItemTapped;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipperWithFab(
        notchMargin: notchMargin,
        fabSize: fabSize,
      ),
      child: CustomPaint(
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: const Color.fromARGB(255, 255, 255, 255),
            border: Border.all(color: const Color.fromRGBO(217, 217, 217, 1)),
          ),
          child: CustomMultiChildLayout(
            delegate: OwnMultiChildLayoutDelegate(),
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              LayoutId(
                id: 1,
                child: TextButton(
                  onPressed: () => onItemTapped(0),
                  child: SizedBox(
                    width: 96,
                    height: 50,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/request.png'),
                        const SizedBox(height: 11),
                        const Text('Мои запросы', style: clientsNavBar),
                      ],
                    ),
                  ),
                ),
              ),
              LayoutId(
                id: 2,
                child: TextButton(
                  onPressed: () => onItemTapped(1),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 34,
                      ),
                      Text('Сервисы', style: clientsNavBar),
                    ],
                  ),
                ),
              ),
              LayoutId(
                id: 3,
                child: TextButton(
                  onPressed: () => onItemTapped(2),
                  child: SizedBox(
                    width: 65,
                    height: 50,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/profile.png'),
                        const SizedBox(height: 11),
                        const Text('Профиль', style: clientsNavBar),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OwnMultiChildLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  Size getSize(BoxConstraints constraints) =>
      Size(constraints.biggest.width, 100);

  @override
  void performLayout(Size size) {
    if (hasChild(1) && hasChild(2) && hasChild(3)) {
      const double margin = 8.0;

      // Размеры для каждого элемента (например, они могут быть одинаковыми)
      final firstElementSize = layoutChild(
        1,
        BoxConstraints.loose(Size(size.width / 3, size.height)),
      );
      final secondElementSize = layoutChild(
        2,
        BoxConstraints.loose(Size(size.width / 3, size.height)),
      );
      final thirdElementSize = layoutChild(
        3,
        BoxConstraints.loose(Size(size.width / 3, size.height)),
      );

      // Позиционируем первый элемент (левый), отступая от левого края на 8 пикселей
      final firstElementYOffset = size.height / 2 - firstElementSize.height / 2;
      positionChild(1, Offset(margin, firstElementYOffset));

      // Позиционируем второй элемент (центральный) по центру контейнера
      final secondElementXOffset =
          (size.width / 2) - (secondElementSize.width / 2);
      final secondElementYOffset =
          size.height / 2 - secondElementSize.height / 2;
      positionChild(2, Offset(secondElementXOffset, secondElementYOffset));

      // Позиционируем третий элемент (правый), отступая от правого края на 8 пикселей
      final thirdElementYOffset = size.height / 2 - thirdElementSize.height / 2;
      positionChild(
          3,
          Offset(size.width - thirdElementSize.width - margin,
              thirdElementYOffset));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}

class CustomClipperWithFab extends CustomClipper<Path> {
  CustomClipperWithFab({
    required this.notchMargin,
    required this.fabSize,
  });

  final double notchMargin;
  final double fabSize;

  @override
  Path getClip(Size size) {
    final double notchRadius = fabSize / 2.0;
    final double center = size.width / 2.0;

    return Path()
      ..lineTo(center - notchRadius - notchMargin, 0)
      ..arcToPoint(
        Offset(center + notchRadius + notchMargin, 0),
        radius: Radius.circular(notchRadius + notchMargin),
        clockwise: false,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
