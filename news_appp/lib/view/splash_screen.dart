import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_appp/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Centered Image with Proper Size
          Center(
            child: Image.network(
              'https://images.pexels.com/photos/4057663/pexels-photo-4057663.jpeg?auto=compress&cs=tinysrgb&w=600',
              width: width * 0.9, // 90% of screen width
              height: height * 0.5, // 50% of screen height
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Text("Failed to load image"));
              },
            ),
          ),

          SizedBox(height: 20),

          // Centered Text
          Text(
            'Top Headlines',
            style: GoogleFonts.anton(
              letterSpacing: 0.6,
              color: Colors.grey.shade700,
              fontSize: 24,
            ),
          ),

          SizedBox(height: 30),

          // Centered Loading Indicator
          SpinKitChasingDots(
            color: Color.fromARGB(255, 230, 132, 96),
            size: 40,
          ),
        ],
      ),
    );
  }
}
