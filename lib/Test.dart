import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persistent FAB Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  // Index to track which widget is currently displayed
  int _currentIndex = 0;

  // List of widgets to display in the body
  final List<Widget> _widgets = [const Widget1(), const Widget2()];

  void _navigateToWidget(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Widget')),
      // Use the current widget based on the index
      body: _widgets[_currentIndex],
      // The FloatingActionButton stays visible regardless of which widget is shown
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Home FAB Pressed!')));
        },
        child: const Text('Button'),
      ),
    );
  }
}

class Widget1 extends StatelessWidget {
  const Widget1({super.key});

  @override
  Widget build(BuildContext context) {
    // Notice we don't use Scaffold here
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Widget First'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Get the _HomeWidgetState and call its navigation method
              final homeState =
                  context.findAncestorStateOfType<_HomeWidgetState>();
              homeState?._navigateToWidget(1);
            },
            child: const Text('Navigate to Widget 2'),
          ),
        ],
      ),
    );
  }
}

class Widget2 extends StatelessWidget {
  const Widget2({super.key});

  @override
  Widget build(BuildContext context) {
    // Notice we don't use Scaffold here either
    return PopScope(
      // Handle the back button press using the current recommended API
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        final homeState = context.findAncestorStateOfType<_HomeWidgetState>();
        homeState?._navigateToWidget(0);
        //return true;
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Widget 2'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Get the _HomeWidgetState and call its navigation method
                final homeState =
                    context.findAncestorStateOfType<_HomeWidgetState>();
                homeState?._navigateToWidget(0);
              },
              child: const Text('Back to Widget 1'),
            ),
          ],
        ),
      ),
    );
  }
}

// Alternative approach using Navigator.push
// If you need to use traditional navigation with Navigator:

class AlternativeHomeWidget extends StatelessWidget {
  const AlternativeHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Widget')),
      body: const Widget1Alt(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Home FAB Pressed!')));
        },
        child: const Text('Button'),
      ),
    );
  }
}

class Widget1Alt extends StatelessWidget {
  const Widget1Alt({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Widget 1'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Use transparent page route to keep the home scaffold visible
              Navigator.of(context).push(
                _TransparentRoute(builder: (context) => const Widget2Alt()),
              );
            },
            child: const Text('Navigate to Widget 2'),
          ),
        ],
      ),
    );
  }
}

class Widget2Alt extends StatelessWidget {
  const Widget2Alt({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.of(context).pop();
      },
      child: Container(
        color: Colors.white, // Background color to cover Widget1
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Widget 2'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Back to Widget 1'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom route that doesn't create a new scaffold
class _TransparentRoute extends PageRoute<void> {
  _TransparentRoute({required this.builder}) : super(fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }
}
