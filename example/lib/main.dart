import 'package:flutter/material.dart';
import 'package:my_responsive_ui/my_responsive_ui.dart';

void main() {
  // Runs the app starting with MyApp widget
  runApp(const MyApp());
}

/// The main application widget.
///
/// This widget is the entry point of the app and contains the [ResponsiveInitializer] widget
/// for responsive UI initialization. The [ResponsiveInitializer] sets the base height and width
/// of the screen to scale UI components according to screen size.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Returns the MaterialApp with a responsive layout
    return const MaterialApp(
      home: ResponsiveInitializer(
        baseHeight: 812,  // Base height for scaling
        baseWidth: 375,   // Base width for scaling
        child: HomePage(),  // The home page widget
      ),
    );
  }
}

/// A home page widget that demonstrates a responsive UI.
///
/// This widget contains a scaffold with an AppBar, a container with responsive dimensions,
/// and some padding for spacing. The UI scales according to the screen size using the
/// [ResponsiveUtil] class.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Builds the main UI layout for the home page
    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive UI Demo', style: TextStyle(fontSize: 18.sp)),
        // Text style scales the font size based on screen size using .sp
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),  // Responsive padding with .r scaling
        child: Column(
          children: [
            // A responsive container with scaled height and width
            Container(
              height: 200.h,  // Scaled height using .h
              width: double.infinity,  // Takes full width
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12.r),  // Scaled border radius with .r
              ),
              child: Center(
                child: Text(
                  'Responsive Container',
                  style: TextStyle(
                    fontSize: 24.sp,  // Scaled font size using .sp
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            vs(20),  // Vertical spacing using .h scaling
            // Additional widgets can be added here...
          ],
        ),
      ),
    );
  }
}
