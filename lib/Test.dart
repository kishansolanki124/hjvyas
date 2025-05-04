import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Element Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 600),
              reverseTransitionDuration: Duration(milliseconds: 600),
              pageBuilder: (context, animation, secondaryAnimation) => DetailPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'imageHero',
                child: Image.network(
                  'https://picsum.photos/200',
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 1, end: 1),
                duration: Duration(milliseconds: 600),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, 0),
                    child: Transform.scale(
                      scale: value,
                      child: child,
                    ),
                  );
                },
                child: Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Animated text that moves from center to top-left
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 600),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(-100 * (1 - value), -50 * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: Transform.scale(
                      scale: 0.8 + (value * 0.2),
                      child: child,
                    ),
                  ),
                );
              },
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: 'imageHero',
                  child: Image.network(
                    'https://picsum.photos/200',
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Nullam euismod, nisl eget aliquam ultricies, nunc nisl '
                    'aliquet nunc, quis aliquam nisl nunc eu nisl.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}