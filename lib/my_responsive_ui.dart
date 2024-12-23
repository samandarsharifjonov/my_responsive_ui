import 'package:flutter/material.dart';

class ResponsiveUtil {
  static final ResponsiveUtil _instance = ResponsiveUtil._internal();

  factory ResponsiveUtil() => _instance;

  ResponsiveUtil._internal();

  double _height = 1;
  double _width = 1;
  double _scale = 1;

  static const double _minScale = 0.8;
  static const double _maxScale = 1.5;

  double get height => _height;
  double get width => _width;
  double get scale => _scale.clamp(_minScale, _maxScale);

  void updateDimensions(BuildContext context, double baseHeight, double baseWidth) {
    try {
      final mediaQuery = MediaQuery.of(context);
      _height = (mediaQuery.size.height / baseHeight).clamp(_minScale, _maxScale);
      _width = (mediaQuery.size.width / baseWidth).clamp(_minScale, _maxScale);
      _scale = (_height + _width) / 2;
    } catch (e) {
      debugPrint('ResponsiveUtil error: $e');
      _height = 1;
      _width = 1;
      _scale = 1;
    }
  }
}
extension ExtSize on num {
  double get h => (this * ResponsiveUtil().height).clamp(0.0, double.infinity);
  double get w => (this * ResponsiveUtil().width).clamp(0.0, double.infinity);
  double get sp => (this * ResponsiveUtil().scale).clamp(0.0, double.infinity);
  double get r => (this * ResponsiveUtil().scale).clamp(0.0, double.infinity);
}


Widget verticalSp(double height) => SizedBox(
  height: height.h.clamp(0.0, double.infinity),
);

Widget horizontalSp(double width) => SizedBox(
  width: width.w.clamp(0.0, double.infinity),
);

Widget vs(double height) => verticalSp(height);
Widget hs(double width) => horizontalSp(width);

class ResponsiveInitializer extends StatefulWidget {
  final double baseHeight;
  final double baseWidth;
  final Widget child;

  const ResponsiveInitializer({
    required this.baseHeight,
    required this.baseWidth,
    required this.child,
    super.key,
  }) : assert(baseHeight > 0 && baseWidth > 0, 'Base dimensions must be positive');

  @override
  State<ResponsiveInitializer> createState() => _ResponsiveInitializerState();
}

class _ResponsiveInitializerState extends State<ResponsiveInitializer> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateDimensions();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _updateDimensions();
  }

  void _updateDimensions() {
    ResponsiveUtil().updateDimensions(context, widget.baseHeight, widget.baseWidth);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}