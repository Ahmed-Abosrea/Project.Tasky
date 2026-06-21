import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../widget/custom_text_form_field.dart';
import 'main_layout.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> saveName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/Vector.svg"),
                    const SizedBox(width: 8),
                    Text("Tasky",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                          fontSize: 28,
                        )),
                  ],
                ),

                const SizedBox(height: 40),

                Text(
                  "Welcome To Tasky 👋",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontSize: 22,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Your productivity journey starts here.",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 30),

                SvgPicture.asset("assets/pana.svg", height: 200),

                const SizedBox(height: 30),

                CustomTextFormField(
                  Controller: nameController,
                  title: "Full Name",
                  hint: "Enter your name",
                  maxLines: 1,
                  validator: (v) =>
                  (v == null || v.isEmpty) ? "Enter your name" : null,
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(

                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await saveName();

                        final prefs = await SharedPreferences.getInstance();
                        bool savedDark = prefs.getBool("dark") ?? true;

                        if (!mounted) return;

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MyApp(
                              name: nameController.text,
                              isDark: savedDark,
                            ),
                          ),
                              (route) => false,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff15B86C),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Text("Get Started",
                        style: GoogleFonts.poppins(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}