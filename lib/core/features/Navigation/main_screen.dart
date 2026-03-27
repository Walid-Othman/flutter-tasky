import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_app/core/features/tasks/Completed_screen.dart';
import 'package:to_do_app/core/features/home/home_screen.dart';
import 'package:to_do_app/core/features/profile/profile_screen.dart';
import 'package:to_do_app/core/features/tasks/tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    TasksScreen(),
    CompletedScreen(),
    ProfileScreen(),
  ];

  SvgPicture _buildSvgPicture(String imgUrl, int index) {
    return SvgPicture.asset(
      imgUrl,
      colorFilter: ColorFilter.mode(
        _currentIndex == index ? Color(0xFF15B86C) : Color(0xFFC6C6C6),
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int? index) async {
          setState(() {
            _currentIndex = index ?? 0;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/home.svg', 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/to_do.svg', 1),
    
            label: ' To D0',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/completed.svg', 2),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/profile.svg', 3),
    
            label: 'Profile',
          ),
        ],
      ),
      body: screens[_currentIndex],
    );
  }
}
