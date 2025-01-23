import 'package:calling_app/contacts.dart';
import 'package:calling_app/dialpad_screen.dart';
import 'package:calling_app/messages.dart';
import 'package:calling_app/recent_call_logs.dart';
import 'package:calling_app/user_profile.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReusableLayout extends StatelessWidget {
  final Widget body;
  final int currentIndexTop;
  final int indexBottom;

  const ReusableLayout(
      {super.key,
      required this.body,
      required this.currentIndexTop,
      required this.indexBottom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/Vector.png',
              height: 60, // Adjust the size of the image as needed
            ),
            const SizedBox(width: 8),
          ],
        ),
        titleSpacing: 0.0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.black),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTabButton(
                  label: "Calls",
                  isSelected: currentIndexTop == 0,
                  onPressed: () {
                     Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RecentCallsScreen()),
        );
                  },
                ),
                _buildTabButton(
                  label: "Contacts",
                  isSelected: currentIndexTop == 1,
                  onPressed: () {
                     Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ContactsScreen()),
        );
                  },
                ),
                _buildTabButton(
                  label: "Messages",
                  isSelected: currentIndexTop == 2,
                  onPressed: () {
                     Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MessagesScreen()),
        );
                  },
                ),
                _buildTabButton(
                  label: "Favorites",
                  isSelected: currentIndexTop == 3,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBottom,
        selectedItemColor: const Color(0xFF5864F8),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RecentCallsScreen()),
              );
              break;
            case 1:
               Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DialPadScreen()),
        );
              break;
            case 2:
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ReusableLayout(
              //       body: const ContactsScreen(),
              //       currentIndexTop: currentIndexTop,
              //       indexBottom: 2,
              //     ),
              //   ),
              // );
              break;
            case 3:
              Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PhoneUserProfile(userName: 'Riya', userPhoneNumber: '9930087965',)),
        );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Connects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dialpad),
            label: 'Dialpad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_agenda),
            label: 'Reachouts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String label,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor:
            isSelected ? const Color(0xFF5864F8) : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
