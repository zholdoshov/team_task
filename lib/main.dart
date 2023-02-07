import 'package:flutter/material.dart';
import 'package:myapp/screens/home_page.dart';
import 'package:myapp/screens/profile_page.dart';
import 'package:myapp/screens/feed_page.dart';
import 'package:go_router/go_router.dart';

final routes = [
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/feed',
    builder: (context, state) => const FeedPage(),
  ),
  GoRoute(
    path: '/profile',
    builder: (context, state) => const ProfilePage(),
  )
];

final _router = GoRouter(initialLocation: '/home', routes: routes);

void main() {
  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routerConfig: _router,
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
      textTheme: const TextTheme(
        headline1: TextStyle(color: Colors.deepPurple),
      ),
    ),
    title: 'Task App',
  ));
}
