import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'profilepage.dart';
import 'reusable_layout.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> _contacts = [];
  Map<String, List<Contact>> groupedContacts = {};
  List<String> alphabet = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    PermissionStatus permissionStatus = await Permission.contacts.request();
    if (permissionStatus.isGranted) {
      Iterable<Contact> contacts = await ContactsService.getContacts();
      List<Contact> sortedContacts = contacts.toList()
        ..sort((a, b) => (a.displayName ?? '').compareTo(b.displayName ?? ''));

      // Group contacts by the first letter of their display name
      Map<String, List<Contact>> grouped = {};
      for (var contact in sortedContacts) {
        String initial = contact.displayName?.substring(0, 1).toUpperCase() ?? '#';

        // If the name starts with a non-alphabetic character, group under `#`
        if (!RegExp(r'^[A-Z]').hasMatch(initial)) {
          initial = '#';
        }

        if (!grouped.containsKey(initial)) {
          grouped[initial] = [];
        }
        grouped[initial]!.add(contact);
      }

      setState(() {
        _contacts = sortedContacts;
        groupedContacts = grouped;
        alphabet = grouped.keys.toList()..sort();
      });
    } else if (permissionStatus.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void _scrollToSection(String letter) {
    int index = _contacts.indexWhere((contact) {
      String initial = contact.displayName?.substring(0, 1).toUpperCase() ?? '#';
      if (!RegExp(r'^[A-Z]').hasMatch(initial)) {
        initial = '#';
      }
      return initial == letter;
    });

    if (index != -1) {
      _scrollController.animateTo(
        index * 72.0, // Approximate height of each ListTile
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReusableLayout(
      currentIndexTop: 1,
      body: _contacts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                ListView.builder(
                  controller: _scrollController,
                  itemCount: _contacts.length,
                  itemBuilder: (context, index) {
                    Contact contact = _contacts[index];
                    return _buildContactTile(contact, context);
                  },
                ),
                Positioned(
                  right: 12,
                  top: 20,
                  bottom: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: alphabet
                        .map((letter) => GestureDetector(
                              onTap: () => _scrollToSection(letter),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  letter,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
      indexBottom: 0,
    );
  }

  Widget _buildContactTile(Contact contact, BuildContext context) {
    // Define the color combinations
    final List<Map<String, Color>> colors = [
      {'background': const Color(0xFFD7EFFD), 'foreground': const Color(0xFF5FBFF9)}, // Icon 1
      {'background': const Color(0xFFC5EEF0), 'foreground': const Color(0xFF16BAC4)}, // Icon 2
      {'background': const Color(0xFFD5D8FD), 'foreground': const Color(0xFF5864F8)}, // Icon 3
    ];

    // Determine the colors for the current contact
    final Map<String, Color> colorSet = colors[_contacts.indexOf(contact) % colors.length];

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colorSet['background'],
        child: Text(
          contact.displayName?.substring(0, 1) ?? '?',
          style: TextStyle(color: colorSet['foreground']),
        ),
      ),
      title: Text(
        contact.displayName ?? 'Unknown',
        style: const TextStyle(fontWeight: FontWeight.w500), // Make the name bold
      ),
      onTap: () {
        String? n = contact.phones!.first.value;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContactProfile(
              name: contact.displayName,
              phoneNumber: n,
            ),
          ),
        );
      },
    );
  }
}
