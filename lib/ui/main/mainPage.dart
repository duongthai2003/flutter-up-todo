import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const new({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _pages = []; //List of pages

  int _currentPage = 0;
  //init the list of pages when the page is loaded
  void initState() {
    super.initState();
    _pages = [
      Container(color: Colors.red),
      Container(color: Colors.blue),
      Container(color: Colors.green),
      Container(color: Colors.yellow),
      Container(color: Colors.purple),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: SafeArea(
        child: _pages.elementAt(_currentPage), //_pages[currentPage], // .elementAt giống như lấy item của mảng từ vị trí index nào
      ),
      // list menu điều hướng
      bottomNavigationBar: BottomNavigationBar(
        type:
            BottomNavigationBarType.fixed, // xẽ luôn hiển thị cả label của item

        backgroundColor: Color(0xFF363636),
        unselectedItemColor: Colors.white, // khi không select item
        selectedItemColor: Color(0xFF8687E7), // khi select item
        currentIndex: _currentPage, // vị trí của item hiện tại
        onTap: (index) {
          // sử lý logic khi select item
          if (index == 2) {
            return;
          }
          setState(() {
            // cập nhật lại vị trí của item hiện tại
            _currentPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              // icon của item
              "assets/images/home-2.png",
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
            activeIcon: Image.asset(
              // icon của item khi select
              "assets/images/home-2.png",
              width: 24,
              height: 24,
              fit: BoxFit.fill,
              color: Color(0xFF8687E7),
            ),
            label: "Home",
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/calendar.png",
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
            activeIcon: Image.asset(
              "assets/images/calendar.png",
              width: 24,
              height: 24,
              fit: BoxFit.fill,
              color: Color(0xFF8687E7),
            ),
            label: "Calendar",
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Container(),
            label: "",
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/clock.png",
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
            activeIcon: Image.asset(
              "assets/images/clock.png",
              width: 24,
              height: 24,
              fit: BoxFit.fill,
              color: Color(0xFF8687E7),
            ),
            label: "Focuse",
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/user.png",
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
            activeIcon: Image.asset(
              "assets/images/user.png",
              width: 24,
              height: 24,
              fit: BoxFit.fill,
              color: Color(0xFF8687E7),
            ),
            label: "Profile",
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
      floatingActionButton: Container(
        // tạo button nổi lên
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color(0xFF8687E7),
        ),
        child: IconButton(
          onPressed: () => {print("Lam cai gi do")},
          icon: Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // đặt vị trí của button nổi lên là ở giữa docked
    );
  }
}
