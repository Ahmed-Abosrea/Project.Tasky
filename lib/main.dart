import 'package:flutter/material.dart';
import 'package:projecttask1/screen/welcom_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/main_layout.dart';
import 'screen/welcom_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name") ?? "";
  bool isDark = prefs.getBool("dark") ?? true;

  runApp(MyApp(name: name, isDark: isDark));
}

class MyApp extends StatefulWidget {
  final String name;
  final bool isDark;

  const MyApp({super.key, required this.name, required this.isDark});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isDark;

  @override
  void initState() {
    super.initState();
    isDark = widget.isDark;
  }

  void toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("dark", value);

    setState(() {
      isDark = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor:
        isDark ? const Color(0xff121212) : Colors.white,
        cardColor:
        isDark ? const Color(0xff1E1E1E) : Colors.grey[200],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: isDark ? Colors.white : Colors.black,
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),

      home: widget.name.isNotEmpty
          ? MainLayout(
        isDark: isDark,
        onThemeChanged: toggleTheme,
      )
          : const WelcomeScreen(),
    );
  }
}