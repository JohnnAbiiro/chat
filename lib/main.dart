import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({'sender': 'user', 'message': _controller.text.trim()});
        _messages.add({
          'sender': 'bot',
          'message': 'You said: ${_controller.text.trim()}'
        });
      });
      _controller.clear();
    }
  }

  Widget _buildMessage(String message, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[300] : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(5),
            topRight: const Radius.circular(5),
            bottomLeft: isUser ? const Radius.circular(5) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(5),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final reversedIndex = _messages.length - 1 - index;
                final isUser = _messages[reversedIndex]['sender'] == 'user';
                return _buildMessage(
                    _messages[reversedIndex]['message']!, isUser);
              },
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onSubmitted: (value) {
                      // Send the message when the "done" button is pressed
                      _sendMessage();
                    },
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ChatScreen(),
    theme: ThemeData.light(),
  ));
}
