import 'package:flutter/material.dart';

class ContactProfile extends StatelessWidget {
  final String? name;
  final String? phoneNumber;
  final String? profileImage;

  const ContactProfile({
    super.key,
    required this.name,
    required this.phoneNumber,
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              height: 200,
              color: const Color(0xFF5864F8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Profile Image
                  Positioned(
                    bottom: 20,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: profileImage != null
                          ? NetworkImage(profileImage!)
                          : null,
                      child: profileImage == null
                          ? const Icon(Icons.person, size: 50)
                          : null,
                    ),
                  ),
                  // Back Button
                  Positioned(
                    top: 16,
                    left: 4,
                   
                    child: IconButton(
                      icon: const Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Icon(Icons.arrow_back, color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 6,
                    child: IconButton(
                      icon: const Padding(
                        padding: EdgeInsets.only(top:15),
                        child: Icon(Icons.more_vert, color: Colors.black),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            // Name
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                name!,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(Icons.phone, 'Call'),
                  _buildActionButton(Icons.message, 'Message'),
                  _buildActionButton(Icons.note, 'Notes'),
                ],
              ),
            ),

            // Contact Info Section
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Contact Info',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  _buildContactTile('Mobile', phoneNumber!),
                  _buildContactTile('Work', phoneNumber!),
                ],
              ),
            ),

            // Other Actions
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.favorite_border),
                    title: const Text('Add to Favorites'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete_outline, color: Colors.red),
                    title: const Text('Delete Contact',
                        style: TextStyle(color: Colors.red)),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // Call History
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Call History',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const ListTile(
                    leading: Icon(Icons.call_made, color: Colors.green),
                    title: Text('Outgoing call'),
                    subtitle: Text('Today, 12:00 PM'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF5864F8)),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  Widget _buildContactTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.phone, color: Color(0xFF5864F8)),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.message, color: Color(0xFF5864F8)),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
