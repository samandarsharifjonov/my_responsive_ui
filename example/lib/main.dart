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
        baseHeight: 812, // Base height for scaling
        baseWidth: 375, // Base width for scaling
        child: HomePage(), // The home page widget
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive UI Demo', style: TextStyle(fontSize: 18.sp)),
        // Text style scales the font size based on screen size using .sp
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r), // Responsive padding with .r scaling
        child: Column(
          children: [
            // A responsive container with scaled height and width
            Container(
              height: isPortrait(context) ? 200.h : 150.h,
              // Height changes based on orientation
              width: double.infinity,
              // Takes full width
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius:
                    BorderRadius.circular(12.r), // Scaled border radius with .r
              ),
              child: Center(
                child: Text(
                  isPortrait(context) ? 'Portrait Mode' : 'Landscape Mode',
                  style: TextStyle(
                      fontSize: 24.sp, // Scaled font size using .sp
                      color: Colors.white),
                ),
              ),
            ),
            vs(20), // Vertical spacing using .h scaling

            Center(
              child: Text(
                // Using ternary operator to check platform
                // isIOS(context) and isAndroid(context) functions are used to detect device platform
                isIOS(context)
                    ? 'This is an iOS device' // If iOS
                    : isAndroid(context) // If not iOS, check if Android
                        ? 'This is an Android device' // If Android
                        : 'Unknown Platform', // If neither iOS nor Android
              ),
            ),
          ],
        ),
      ),
    );
  }
}
