import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';

import 'reusable_layout.dart';

class RecentCallsScreen extends StatefulWidget {
  const RecentCallsScreen({super.key});

  @override
  State<RecentCallsScreen> createState() => _RecentCallsScreenState();
}

class _RecentCallsScreenState extends State<RecentCallsScreen> {
  List<CallLogEntry> callLogs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCallLogs();
  }

  Future<void> _fetchCallLogs() async {
    try {
      // Fetch call logs
      Iterable<CallLogEntry> fetchedCallLogs = await CallLog.get();

      setState(() {
        callLogs = fetchedCallLogs.toList();
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching call logs: $e");
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReusableLayout(
      currentIndexTop: 0,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : callLogs.isEmpty
              ? const Center(child: Text('No call logs available'))
              : ListView.builder(
                  itemCount: callLogs.length,
                  itemBuilder: (context, index) {
                    final call = callLogs[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(
                          call.callType == CallType.incoming
                              ? Icons.call_received
                              : (call.callType == CallType.outgoing
                                  ? Icons.call_made
                                  : Icons.call_missed),
                          color: call.callType == CallType.incoming
                              ? Colors.green
                              : (call.callType == CallType.outgoing
                                  ? Colors.blue
                                  : Colors.red),
                        ),
                      ),
                      title: Text(
                        call.name ?? call.number ?? 'Unknown',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(
                            call.callType == CallType.missed
                                ? Icons.warning
                                : Icons.schedule,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _formatTimestamp(call.timestamp),
                            style: const TextStyle(color: Colors.grey,fontSize:10),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildTag(call.callType),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.info_outline),
                            color: Colors.grey,
                            onPressed: () {
                              // Handle info icon tap
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Call Details"),
                                  content: Text(
                                      "Number: ${call.number}\nType: ${_getCallTypeString(call.callType)}\nTime: ${_formatTimestamp(call.timestamp)}"),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text("Close"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
      indexBottom: 0,
    );
  }

  Widget _buildTag(CallType? callType) {
    String tag = "";
    Color tagColor = Colors.grey;

    if (callType == CallType.incoming) {
      tag = "Personal";
      tagColor = Colors.blue;
    } else if (callType == CallType.outgoing) {
      tag = "Business";
      tagColor = Colors.green;
    } else if (callType == CallType.missed) {
      tag = "Missed";
      tagColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: tagColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: tagColor, width: 1),
      ),
      child: Text(
        tag,
        style: TextStyle(color: tagColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  String _formatTimestamp(int? timestamp) {
    if (timestamp == null) return "Unknown time";
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return "${date.hour}:${date.minute.toString().padLeft(2, '0')} ${date.day}/${date.month}/${date.year}";
  }

  String _getCallTypeString(CallType? callType) {
    switch (callType) {
      case CallType.incoming:
        return "Incoming";
      case CallType.outgoing:
        return "Outgoing";
      case CallType.missed:
        return "Missed";
      default:
        return "Unknown";
    }
  }
}
