import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  final IO.Socket socket;
  final String lobbyId;

  const ChatScreen({super.key, required this.socket, required this.lobbyId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> messages = [];

  @override
  void initState() {
    super.initState();

    widget.socket.on("receive_message", (data) {
      if (data["lobbyId"] == widget.lobbyId) {
        setState(() {
          messages.add({
            "sender": data["sender"] ?? "Unknown",
            "message": data["message"] ?? "",
          });
        });
      }
    });
  }

  void sendMessage() {
    if (_controller.text.isNotEmpty) {
      widget.socket.emit("send_message", {
        "lobbyId": widget.lobbyId,
        "sender": "Me",
        "message": _controller.text,
      });

      setState(() {
        messages.add({"sender": "Me", "message": _controller.text});
      });

      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lobby ${widget.lobbyId}")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (ctx, i) {
                final msg = messages[i];
                return ListTile(
                  title: Text(msg["sender"] ?? ""),
                  subtitle: Text(msg["message"] ?? ""),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "Type a message...",
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: sendMessage,
              )
            ],
          )
        ],
      ),
    );
  }
}
