import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_responsive_ui/my_responsive_ui.dart';


void main() {
  group('ResponsiveUtil tests', () {
    testWidgets('updateDimensions correctly calculates height, width, and scale', (WidgetTester tester) async {
      final responsiveUtil = ResponsiveUtil();
      final testWidget = MediaQuery(
        data: const MediaQueryData(size: Size(360, 640)),
        child: Builder(
          builder: (context) {
            responsiveUtil.updateDimensions(context, 640, 360);
            return const SizedBox();
          },
        ),
      );

      await tester.pumpWidget(testWidget);

      expect(responsiveUtil.height, closeTo(1.0, 0.01));
      expect(responsiveUtil.width, closeTo(1.0, 0.01));
      expect(responsiveUtil.scale, closeTo(1.0, 0.01));
    });
  });

}



