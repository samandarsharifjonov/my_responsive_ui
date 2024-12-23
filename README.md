# My Responsive UI

A Flutter package that makes it easy to create responsive UIs across different screen sizes.

## Features

- Easy to use extensions for responsive dimensions (.h, .w, .sp, .r)
- Built-in spacing utilities (vs, hs)
- Safe dimension calculations with min/max boundaries
- Orientation change support
- Memory leak prevention

## Getting started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  my_responsive_ui: ^1.0.0
```

## Usage

1. Wrap your app with ResponsiveInitializer:

```dart
void main() {
  runApp(
    MaterialApp(
      home: ResponsiveInitializer(
        baseHeight: 812, // Design height
        baseWidth: 375,  // Design width
        child: MyApp(),
      ),
    ),
  );
}
```

2. Use responsive extensions:

```dart
Container(
  height: 200.h,  // Responsive height
  width: 300.w, // Responsive width
  padding: EdgeInsets.all(16.r),
  child: Text(
    'Hello',
    style: TextStyle(fontSize: 16.sp),
  ),
)
```

3. Use spacing utilities:

```dart
Column(
  children: [
    Text('First'),
    vs(20),  // Vertical space
    Text('Second'),
  ],
)
```
