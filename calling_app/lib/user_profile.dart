import 'package:flutter/material.dart';

class PhoneUserProfile extends StatelessWidget {
  final String userName;
  final String userPhoneNumber;

  const PhoneUserProfile({
    super.key,
    required this.userName,
    required this.userPhoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  // Placeholder Profile Icon
                  const Positioned(
                    bottom: 20,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF5864F8),
                      child: Icon(Icons.person, size: 50),
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
                userName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),

            // Phone Number
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                userPhoneNumber,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                    ),
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
                  _buildActionButton(Icons.share, 'Share'),
                ],
              ),
            ),

            // Contact Info Section
            Container(
              width: double.infinity,
              
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    //spreadRadius: 1,
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
                      'User Info',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  _buildContactTile('Name', userName),
                  _buildContactTile('Phone Number', userPhoneNumber),
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
              child: const Column(
                children: [
                  // ListTile(
                  //   leading: const Icon(Icons.favorite_border),
                  //   title: const Text('Add to Favorites'),
                  //   onTap: () {},
                  // ),
                  // ListTile(
                  //   leading: const Icon(Icons.delete_outline, color: Colors.red),
                  //   title: const Text('Delete Contact',
                  //       style: TextStyle(color: Colors.red)),
                  //   onTap: () {},
                  // ),
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
          child: Icon(icon, color: Color(0xFF5864F8)),
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
          Text(value),
        ],
      ),
    );
  }
}
