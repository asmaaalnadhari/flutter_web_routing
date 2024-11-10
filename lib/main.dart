import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainLayout(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'HomePage', // Add a name here
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: HomePage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            ),
          ),
          GoRoute(
            path: '/about',
            name: 'AboutPage',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: AboutPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            ),
          ),
          GoRoute(
            path: '/contact',
            name: 'ContactPage',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: ContactPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            ),
          ),
        ],
      ),
    ],

  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Web App with Drawer Navigation',
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}

void navigateToSinglePageAboveHome(BuildContext context, String path) {
  final currentLocation = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    print('currentLocation : $currentLocation');
  if (currentLocation == '/home') {
      print('context.go(path)');
    context.go(path);
  } else {
    print(' context.replace(path)');


    // Replace the current page with the new target page to keep only Home and one other page in the stack
    context.replace(path);
  }
}

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const Text(
          'Flutter Web App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: ColoredBox(
              color: Colors.teal.withOpacity(0.4),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    title: Text(
                      'Home',
                      style: TextStyle(
                        color: GoRouter.of(context).routerDelegate.currentConfiguration.fullPath == '/home'
                            ? Colors.teal
                            : Colors.black,
                      ),
                    ),
                    onTap: () {
                      if (GoRouter.of(context).routerDelegate.currentConfiguration.fullPath != '/home') {
                        context.go('/home');
                      }
                    },
                  ),
                  ListTile(
                    title: Text(
                      'About',
                      style: TextStyle(
                        color: GoRouter.of(context).routerDelegate.currentConfiguration.fullPath == '/about'
                            ? Colors.teal
                            : Colors.black,
                      ),
                    ),
                    onTap: () {
                      if (GoRouter.of(context).routerDelegate.currentConfiguration.fullPath != '/about') {
                        navigateToSinglePageAboveHome(context, '/about');
                      }
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Contact',
                      style: TextStyle(
                        color: GoRouter.of(context).routerDelegate.currentConfiguration.fullPath == '/contact'
                            ? Colors.teal
                            : Colors.black,
                      ),
                    ),
                    onTap: () {
                      if (GoRouter.of(context).routerDelegate.currentConfiguration.fullPath != '/contact') {
                        navigateToSinglePageAboveHome(context, '/contact');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: child,
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}

// Other classes remain the same

// Sample Pages for demonstration
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Page Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'About Page Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Contact Page Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
// Static Footer Widget
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.teal,
      child: const Text(
        textAlign:TextAlign.center ,
        'Footer Section',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}