import 'package:flutter/material.dart';
import 'package:frontend/ui/views/items_view.dart';
import 'package:frontend/ui/views/profile_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  final List<Widget> _children = [ItemsView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              heroTag: 'main-fab',
              backgroundColor: Colors.grey,
              elevation: 2.0,
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, '/items/add');
              },
            )
          : FloatingActionButton(
              heroTag: 'main-fab',
              backgroundColor: Colors.grey,
              elevation: 2.0,
              child: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              color: Colors.white,
              iconSize: _currentIndex == 0 ? 32 : 24,
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              color: Colors.white,
              iconSize: _currentIndex == 1 ? 32 : 24,
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
          ],
        ),
        color: Colors.grey,
        shape: const CircularNotchedRectangle(),
      ),

    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
