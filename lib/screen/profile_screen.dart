import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcom_screen.dart';

class ProfileScrean extends StatelessWidget {
  final bool isDark;
  final Function(bool) onThemeChanged;

  const ProfileScrean({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    Color textColor =
    isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text("My Profile", style: TextStyle(color: textColor)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const CircleAvatar(
              radius: 40,
              backgroundImage:
              AssetImage("assets/leading_element.png"),
            ),

            const SizedBox(height: 10),

            Text("User",
                style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),

            const SizedBox(height: 30),

            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [

                  ListTile(
                    leading: Icon(Icons.dark_mode, color: textColor),
                    title: Text("Dark Mode",
                        style: TextStyle(color: textColor)),
                    trailing: Switch(
                      value: isDark,
                      onChanged: onThemeChanged,
                      activeColor: const Color(0xff15B86C),
                    ),
                  ),

                  const Divider(height: 1),

                  ListTile(
                    onTap: () => logout(context),
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text("Log Out",
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}