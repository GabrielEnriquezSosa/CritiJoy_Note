import 'dart:math';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Center(
              child: CustomPaint(
                size: Size(390, 293),
                painter: SquareAndHalfCirclePainter(),
                child: SizedBox(
                  width: 390,
                  height: 293,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/images/Logo.png"),
                      ),
                      Text(
                        "Bienvenido a CritiJoy",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 120),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: Text(
                  "Que gusto Tenerte devuelta Yazmin",
                  style: TextStyle(fontSize: 50, fontFamily: "Rancho"),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 120),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: FilledButton(
          onPressed: () {
            Navigator.pushNamed(context, "/home");
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.blue),
          ),
          child: Text(
            "Entrar",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}

class SquareAndHalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintSquare = Paint()..color = Colors.blue;
    final paintCircle = Paint()..color = Colors.blue;

    canvas.drawRect(
      Rect.fromLTWH(-size.width, 0, size.width * 3, size.height / 2),
      paintSquare,
    );
    canvas.drawArc(
      Rect.fromLTWH(-size.width / 4, 0, size.width * 1.5, size.height),
      0,
      pi,
      true,
      paintCircle,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
