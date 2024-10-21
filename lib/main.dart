import 'package:clockworks/firebase_options.dart';
import 'package:clockworks/screens/home_screen.dart';
import 'package:clockworks/screens/ingredients_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Widget> _pages = [
    const HomeScreen(),
    const IngredientsScreen(),
  ];

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFF011993),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF011993)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(currentIndex: _currentIndex, items: [
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                }),
            label: 'Ingredients',
          ),
        ]),
      ),
    );
  }
}
