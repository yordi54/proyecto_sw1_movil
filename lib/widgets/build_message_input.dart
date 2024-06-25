import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_sw1/controllers/chat.controller.dart';


class BuildMessageInput extends StatefulWidget {
  final int chatId;
  const BuildMessageInput({super.key, required this.chatId});

  @override
  State<BuildMessageInput> createState() => _BuildMessageInputState();
}

class _BuildMessageInputState extends State<BuildMessageInput> {
  final ChatController chatController = Get.find();
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: messageController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Escribe un mensaje...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide.none
                  ),
                  filled: true,
                  fillColor: Colors.white
                ),
              ),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              backgroundColor: Colors.greenAccent,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () {
                  if (messageController.text.isNotEmpty) {
                    chatController.sendMessage(widget.chatId ,messageController.text);
                    messageController.clear();
                  }
                  
                },
              ),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              backgroundColor: Colors.greenAccent,
              child: IconButton(
                icon: const Icon(Icons.mic, color: Colors.white),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}