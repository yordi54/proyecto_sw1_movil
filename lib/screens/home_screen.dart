//page home

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:proyecto_sw1/controllers/auth.controller.dart';
import 'package:proyecto_sw1/controllers/chat.controller.dart';
import 'package:proyecto_sw1/models/member.dart';
import 'package:proyecto_sw1/models/message.model.dart';
import 'package:proyecto_sw1/widgets/chat_user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final AuthController _authController = Get.find();
  final ChatController _chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    _chatController.getChats(_authController.user.value!.id);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Theme.of(context).primaryColor ,
        titleTextStyle: const TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        title: const Text('Chats'),
        centerTitle: true,
        actions: [
          //icon search
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              //search
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              _authController.logout();
            },
          )
        ],
      ),

      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Obx((){
          if(_chatController.chats.value == null){
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: _chatController.chats.value!.length,
            itemBuilder: (context, index) {
              Member member = _chatController.chats.value![index].members.firstWhere((element) => element.id != _authController.user.value!.id);
              Message latestMessage = _chatController.chats.value![index].latestMessage;
              List<Message> messages = _chatController.chats.value![index].messages;
              
              return ChatUserCard(member: member, latestMessage: latestMessage, messages: messages );
            },
          );
        }

        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //add chat
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add_comment_sharp),
      )
      
    );
  }
}
