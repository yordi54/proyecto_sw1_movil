import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_sw1/models/member.dart';
import 'package:proyecto_sw1/models/message.model.dart';
import 'package:proyecto_sw1/route.dart';
import 'package:proyecto_sw1/utils/colors.dart';


class ChatUserCard extends StatelessWidget {
  final Member member;
  final Message latestMessage;
  final List<Message> messages;
  const ChatUserCard({super.key, required this.member, required this.latestMessage, required this.messages});
  


  @override
  Widget build(BuildContext context) {    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Theme.of(context).cardColor,
      elevation: 2.0,
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(member.photo),
              radius: 25,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.online,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            )
          ],
        ),
        title: Text('${member.firstName} ${member.lastName}'),
        subtitle:  Text( latestMessage.id != 0 ? latestMessage.translatedText.content : '', maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Text(latestMessage.id != 0 ? latestMessage.getTime() : ''),
          ],
      ),
      onTap: ()  {
        
        Get.toNamed(AppRoutes.chat, arguments: {'member': member});

      }
      )
    );
  }
}