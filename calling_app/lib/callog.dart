import 'package:flutter/material.dart';

class CallLogScreen extends StatelessWidget {
  const CallLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Image.asset(
                'assets/surefylogo.png', // Replace with your asset path
                height: 30,
              ),
              const SizedBox(width: 10),
              const Text(
                "SUREFY.AI",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          bottom: const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: "Calls"),
              Tab(text: "Contacts"),
              Tab(text: "Messages"),
              Tab(text: "Favorites"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Calls Tab
            ListView.builder(
              itemCount: 10, // Number of call logs
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFF5864F8),
                    child: Icon(
                      index % 2 == 0 ? Icons.phone : Icons.person,
                      color: const Color(0xFF5864F8),
                    ),
                  ),
                  title: Text(
                    index % 2 == 0 ? "+91 9685485260" : "Tejal",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(
                        index % 3 == 0
                            ? Icons.call_made
                            : (index % 3 == 1
                                ? Icons.call_received
                                : Icons.call_missed),
                        color: index % 3 == 2 ? Colors.red : Colors.green,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      Text(index % 3 == 2 ? "Missed" : "Outgoing"),
                      const SizedBox(width: 10),
                      const Text(
                        "12:00 PM",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  trailing: const Icon(
                    Icons.info_outline,
                    color: Colors.grey,
                  ),
                );
              },
            ),
            // Contacts Tab
            const Center(child: Text("Contacts Tab")),
            // Messages Tab
            const Center(child: Text("Messages Tab")),
            // Favorites Tab
            const Center(child: Text("Favorites Tab")),
          ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   currentIndex: 0,
        //   selectedItemColor: Colors.blue,
        //   unselectedItemColor: Colors.grey,
        //   items: const [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: "Connects",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.dialpad),
        //       label: "Dialpad",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.grid_view),
        //       label: "Menu",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: "Profile",
        //     ),
        //   ],
        // ),
      ),
    );
  }
}