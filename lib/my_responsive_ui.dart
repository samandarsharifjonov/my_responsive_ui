import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

/// Returns `true` if the device is in portrait mode.
bool isPortrait(BuildContext context) => MediaQuery.of(context).orientation == Orientation.portrait;

/// Returns `true` if the device is in landscape mode.
bool isLandscape(BuildContext context) => MediaQuery.of(context).orientation == Orientation.landscape;

/// Returns `true` if the platform is iOS.
bool isIOS(BuildContext context) => Theme.of(context).platform == TargetPlatform.iOS;

/// Returns `true` if the platform is Android.
bool isAndroid(BuildContext context) => Theme.of(context).platform == TargetPlatform.android;

/// A utility class for responsive design.
///
/// The [ResponsiveUtil] class helps in scaling UI components based on the device's screen
/// size, adapting the layout to various screen dimensions. It provides height, width, and
/// scale properties for calculating responsive sizes.
class ResponsiveUtil {
  /// Singleton instance of [ResponsiveUtil].
  static final ResponsiveUtil _instance = ResponsiveUtil._internal();

  /// Factory constructor to return the singleton instance of [ResponsiveUtil].
  factory ResponsiveUtil() => _instance;

  /// Private internal constructor for the singleton pattern.
  ResponsiveUtil._internal();

  // Private variables to store the current height, width, and scale factors.
  double _height = 1;
  double _width = 1;
  double _scale = 1;

  // Constants for minimum and maximum scale values.
  static const double _minScale = 0.8;
  static const double _maxScale = 1.5;

  /// Returns the height scaling factor.
  double get height => _height;

  /// Returns the width scaling factor.
  double get width => _width;

  /// Returns the scale factor, clamped between the minimum and maximum scale values.
  double get scale => _scale.clamp(_minScale, _maxScale);

  /// Updates the dimensions of the screen based on the provided [baseHeight] and [baseWidth].
  ///
  /// [context] is used to obtain screen dimensions via [MediaQuery].
  /// The height and width are calculated as a ratio of the screen size to the base size.
  /// The scale is the average of height and width scaling factors.
  void updateDimensions(
      BuildContext context, double baseHeight, double baseWidth) {
    try {
      final mediaQuery = MediaQuery.of(context);
      _height =
          (mediaQuery.size.height / baseHeight).clamp(_minScale, _maxScale);
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

/// Extension on [num] to provide responsive size utilities.
///
/// This extension provides getters for scaling values based on the current screen size:
/// - [h] for height scaling
/// - [w] for width scaling
/// - [sp] for scaling based on the average of height and width scaling factors
/// - [r] for scaling based on the same logic as [sp]
extension ExtSize on num {
  /// Returns the height-scaled value.
  double get h => (this * ResponsiveUtil().height).clamp(0.0, double.infinity);

  /// Returns the width-scaled value.
  double get w => (this * ResponsiveUtil().width).clamp(0.0, double.infinity);

  /// Returns the scale-based value (average of height and width scaling).
  double get sp => (this * ResponsiveUtil().scale).clamp(0.0, double.infinity);

  /// Alias for the [sp] getter, for consistency with certain design systems.
  double get r => (this * ResponsiveUtil().scale).clamp(0.0, double.infinity);
}

/// A widget that provides vertical spacing with responsive height scaling.
///
/// This widget uses the [height] property of [ResponsiveUtil] to scale the vertical
/// space based on the current screen size.
Widget verticalSp(double height) => SizedBox(
  height: height.h.clamp(0.0, double.infinity),
);

/// A widget that provides horizontal spacing with responsive width scaling.
///
/// This widget uses the [width] property of [ResponsiveUtil] to scale the horizontal
/// space based on the current screen size.
Widget horizontalSp(double width) => SizedBox(
  width: width.w.clamp(0.0, double.infinity),
);

/// Alias for [verticalSp] to simplify vertical spacing usage.
Widget vs(double height) => verticalSp(height);

/// Alias for [horizontalSp] to simplify horizontal spacing usage.
Widget hs(double width) => horizontalSp(width);

/// A widget that initializes responsive scaling and updates it based on screen size.
///
/// This widget is responsible for updating the responsive dimensions when the
/// screen size changes (e.g., orientation changes). It accepts [baseHeight] and
/// [baseWidth] to scale elements accordingly.
class ResponsiveInitializer extends StatefulWidget {
  /// The base height for the responsive calculations.
  final double baseHeight;

  /// The base width for the responsive calculations.
  final double baseWidth;

  /// The child widget that will be rendered after scaling.
  final Widget child;

  /// Creates a [ResponsiveInitializer] widget.
  ///
  /// [baseHeight] and [baseWidth] must be positive numbers, representing
  /// the reference dimensions for scaling.
  const ResponsiveInitializer({
    required this.baseHeight,
    required this.baseWidth,
    required this.child,
    super.key,
  }) : assert(baseHeight > 0 && baseWidth > 0,
  'Base dimensions must be positive');

  @override
  State<ResponsiveInitializer> createState() => _ResponsiveInitializerState();
}

class _ResponsiveInitializerState extends State<ResponsiveInitializer>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Adds an observer to track changes in screen dimensions.
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Removes the observer when the widget is disposed.
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Updates the screen dimensions when dependencies change.
    _updateDimensions();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // Updates the screen dimensions when screen size or metrics change.
    _updateDimensions();
  }

  /// Updates the responsive dimensions based on the screen size.
  void _updateDimensions() {
    ResponsiveUtil()
        .updateDimensions(context, widget.baseHeight, widget.baseWidth);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
