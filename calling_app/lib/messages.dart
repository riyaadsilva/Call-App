import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

import 'reusable_layout.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final Telephony telephony = Telephony.instance;
  List<SmsMessage> messages = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  Future<void> _fetchMessages() async {
    // Request permissions for SMS
    bool? permissionsGranted = await telephony.requestSmsPermissions;
    if (permissionsGranted != null && permissionsGranted) {
      // Fetch SMS messages
      List<SmsMessage> fetchedMessages = await telephony.getInboxSms(
        columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
      );

      setState(() {
        messages = fetchedMessages;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // Handle the case where permission is denied
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SMS permission is required to view messages.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReusableLayout(
      currentIndexTop: 2,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : messages.isEmpty
              ? const Center(child: Text('No messages to display'))
              : ListView.separated(
                  itemCount: messages.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey, // Faint grey color
                    thickness: 0.3, // Thin line
                    height: 1, // Space between items
                  ),
                  itemBuilder: (context, index) {
                    SmsMessage message = messages[index];
                    return ListTile(
                      leading: const Icon(
                        Icons.person,
                        size: 40,
                        color: Color(0xFF5864F8), // Person icon color
                      ),
                      title: Text(
                        message.address ?? 'Unknown',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, // Bold title
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        message.body ?? 'No content',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        // Navigate to a detailed view of the message
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessageDetailScreen(message: message),
                          ),
                        );
                      },
                    );
                  },
                ),
      indexBottom: 0,
    );
  }
}

class MessageDetailScreen extends StatelessWidget {
  final SmsMessage message;

  const MessageDetailScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(message.address ?? 'Unknown'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16), // Add spacing at the top
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0), // Horizontal margin
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 241, 244), // Light grey background
                borderRadius: BorderRadius.circular(12), // Rounded corners
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 2), // Shadow position
                  ),
                ],
              ),
              child: Text(
                message.body ?? 'No content',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

