import 'package:flutter/material.dart';
import 'package:proyecto_sw1/models/message.model.dart';



class BuildMessage extends StatefulWidget {
  final Message message;
  final bool isMe;
  const BuildMessage({super.key, required this.message, required this.isMe});

  @override
  State<BuildMessage> createState() => _BuildMessageState();
}

class _BuildMessageState extends State<BuildMessage> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: widget.isMe ? Colors.green : Colors.grey[700],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(widget.message.translatedText.content, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(widget.message.getTime(), style: const TextStyle(color: Colors.white)),
            
            )
          ],
        )
      ),      
    );
  }
}