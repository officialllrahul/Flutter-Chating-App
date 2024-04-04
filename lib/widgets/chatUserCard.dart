import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/API/api.dart';
import 'package:messagingapp/helper/my_date_utils.dart';
import 'package:messagingapp/models/message.dart';
import 'package:messagingapp/widgets/dialogs/profile_dialog.dart';

import '../main.dart';
import '../models/chat_user.dart';
import '../presentations/chat_screen.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  Message? _message;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0.5,
      child: InkWell(
        onTap: () {
          //for navigating to chat screen
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ChatScreen(
                        user: widget.user,
                      )));
        },
        child: StreamBuilder(
          stream: Apis.getLastMessage(widget.user),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            final list =
                data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
            if (list.isNotEmpty) _message = list[0];
            return ListTile(
              title: Text(widget.user.name),
              subtitle: Text(
                _message != null ?
                _message!.type== Type.image ? 'image' :
                _message!.msg : widget.user.about,
                maxLines: 1,
              ),
              leading: InkWell(
                onTap: (){
                  showDialog(context: context, builder: (context) => ProfileDialog(user: widget.user,));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(mq.height * .3),
                  child: CachedNetworkImage(
                    width: mq.width * .1,
                    height: mq.height * .046,
                    fit: BoxFit.cover,
                    imageUrl: widget.user.image,
                    errorWidget: (context, url, error) =>
                        CircleAvatar(child: Icon(Icons.person)),
                  ),
                ),
              ),
              trailing: _message == null
                  ? null
                  : _message!.read.isEmpty && _message!.fromId != Apis.user.uid
                      ? Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent.shade400,
                              borderRadius: BorderRadius.circular(10)),
                        )
                      : Text(
                          MyDateUtil.getLastMessageTime(context: context, time: _message!.sent),
                          style: const TextStyle(color: Colors.black54),
                        ),
              // trailing: Text(widget.user.lastActive,style: TextStyle(color: Colors.black54),),
            );
          },
        ),
      ),
    );
  }
}
