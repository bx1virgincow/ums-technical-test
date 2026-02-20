import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums/feature/profile/presentation/bloc/profile_bloc.dart';

import 'dashboard.dart';
import '../../../profile/presentation/screen/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  // final LoginResponseEntity userEntity;

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: bottomNavScreens[currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (value) {
          onTabTapped(value);
        },
        currentIndex: currentIndex,
      ),
    );
  }
}

List<Widget> bottomNavScreens = [dashboardScreen(), profileScreen()];
