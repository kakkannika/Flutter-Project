import 'package:e_learning_app/G_DOPI/screen/Dashboard/account.dart';
import 'package:e_learning_app/G_DOPI/screen/Dashboard/home_page.dart';
import 'package:e_learning_app/G_DOPI/screen/Dashboard/MyCourse/mycourse.dart';
import 'package:e_learning_app/G_DOPI/screen/Dashboard/Playlist/playlist.dart';
import 'package:e_learning_app/G_DOPI/screen/Shopping_Card/pop_up_add_tocard.dart';
import 'package:flutter/material.dart';
import '../../widget/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeTab(),
    MyCourse(savedVideos: ['Physics', 'Chemistry', 'Mathematics']),
     Playlist(),
    Account(),      
       
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      title: const Text('Welcome to G-DOPI'),
      leading: const Padding(
        padding:  EdgeInsets.all(8.0),
        child:  CircleAvatar(
          backgroundImage: AssetImage('assets/images/logo.png'),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: () {
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => ShoppingCart(cartItems: [], totalPrice: 0.0)));
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            // Handle settings
          },
        ),
      ],
    ),
    body: _screens[_selectedIndex],
    bottomNavigationBar: BottomNavBar(
      selectedIndex: _selectedIndex,
      onTap: _onItemTapped,
    ),
  );
}
}
