import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_sw1/controllers/auth.controller.dart';
import 'package:proyecto_sw1/controllers/chat.controller.dart';
import 'package:proyecto_sw1/models/member.dart';
import 'package:proyecto_sw1/widgets/build_message.dart';
import 'package:proyecto_sw1/widgets/build_message_input.dart';
//import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final AuthController authController = Get.find();
  final ChatController chatController = Get.find();

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map <String, dynamic>;
    final Member member = arguments['member'] as Member;
    
    return Scaffold(
      appBar:  AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor:  Theme.of(context).primaryColor ,
        titleTextStyle: const TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        title:  Row(
          children:  [
            CircleAvatar(
              backgroundImage: NetworkImage(member.photo)
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text('${member.firstName} ${member.lastName} ', overflow: TextOverflow.ellipsis, maxLines: 2, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Text('En línea', style: TextStyle(fontSize: 12, color: Colors.white)),
              ],
            )   
          ]
        ),
      ),
      body: Obx((){
        final currentChat = chatController.chats.value!.firstWhere((element) => element.members.contains(member));
        
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: currentChat.messages.length,
                  itemBuilder: (context, index) {
                    final message = currentChat.messages[index];
                    final isMe = message.userId == authController.user.value!.id;
                    return BuildMessage(message: message, isMe: isMe);
                  },
                ),
              ),
              BuildMessageInput(chatId: currentChat.id)
            ],
          );
        }
      )
    );
  }
}