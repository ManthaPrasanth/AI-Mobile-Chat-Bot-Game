import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';

class CreateLobbyScreen extends StatefulWidget {
  final IO.Socket socket;
  const CreateLobbyScreen({super.key, required this.socket});

  @override
  _CreateLobbyScreenState createState() => _CreateLobbyScreenState();
}

class _CreateLobbyScreenState extends State<CreateLobbyScreen> {
  String? type = 'public';
  int maxHumans = 2;
  int maxAIs = 1;
  String password = '';

  void _create() {
    final id = const Uuid().v4().substring(0, 6);
    widget.socket.emit('create_lobby', {
      'id': id,
      'type': type,
      'maxHumans': maxHumans,
      'maxAIs': maxAIs,
      'password': password,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Lobby"),
        backgroundColor: Colors.blueAccent,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lobby Type
                Text("Lobby Type",
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                DropdownButtonFormField(
                  value: type,
                  items: ['public', 'private']
                      .map((t) => DropdownMenuItem(
                            value: t,
                            child: Text(t.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500)),
                          ))
                      .toList(),
                  onChanged: (String? v) {
                    setState(() {
                      type = v;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                const SizedBox(height: 20),

                // Password (if private)
                if (type == 'private') ...[
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),
                    obscureText: true,
                    onChanged: (v) => password = v,
                  ),
                  const SizedBox(height: 20),
                ],

                // Max Humans
                Text("Max Humans: $maxHumans",
                    style: Theme.of(context).textTheme.titleMedium),
                Slider(
                  value: maxHumans.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: "$maxHumans",
                  activeColor: Colors.blueAccent,
                  onChanged: (v) =>
                      setState(() => maxHumans = v.toInt()),
                ),
                const SizedBox(height: 16),

                // Max AIs
                Text("Max AIs: $maxAIs",
                    style: Theme.of(context).textTheme.titleMedium),
                Slider(
                  value: maxAIs.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: "$maxAIs",
                  activeColor: Colors.green,
                  onChanged: (v) => setState(() => maxAIs = v.toInt()),
                ),
                const SizedBox(height: 24),

                // Create Button
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _create,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      icon: const Icon(Icons.add_circle_outline,
                          color: Colors.white),
                      label: const Text(
                        "Create Lobby",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
