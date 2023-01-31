// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:myapp/util/show_task_list.dart';
import 'package:myapp/forms/add_task_form.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<MainPage> {
  static const String _title = 'Nurulla';

  int currentBotNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
        leading: navMenu(context),
      ),
      body: TaskList(),
      floatingActionButton: goToTask(context),
      bottomNavigationBar: bottomNav(),
    );
  }

  // navMenu method to show and hide Navigation Menu
  GestureDetector navMenu(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Coming soon.'),
          ),
        );
      },
      child: const Icon(
        Icons.menu,
      ),
    );
  }

  // goToTask method when add FloatingActionButton is pressed
  FloatingActionButton goToTask(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTask()),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  // botttomNav method to call BottomNavigationBar widget
  BottomNavigationBar bottomNav() {
    return BottomNavigationBar(
      currentIndex: currentBotNavIndex,
      showUnselectedLabels: false,
      onTap: (index) => setState(() => currentBotNavIndex = index),
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Feed',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}