import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messagingapp/helper/dialog.dart';
import 'package:messagingapp/helper/my_date_utils.dart';
import '../API/api.dart';
import '../main.dart';
import '../models/chat_user.dart';

class ViewProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ViewProfileScreen({super.key, required this.user});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.user.name),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: mq.width * .05, vertical: mq.height * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: mq.width,
                    height: mq.width * .02,
                  ),
                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(mq.height * .1),
                    child: CachedNetworkImage(
                      width: mq.width * .4,
                      fit: BoxFit.cover,
                      height: mq.height * .18,
                      imageUrl: widget.user.image,
                      errorWidget: (context, url, error) =>
                      const CircleAvatar(child: Icon(Icons.person)),
                    ),
                  ),
                  SizedBox(
                    width: mq.width,
                    height: mq.width * .04,
                  ),
                  Text(
                    widget.user.email,
                    style:
                    const TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  SizedBox(
                    width: mq.width,
                    height: mq.width * .02,
                  ),
                  //user about
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("About",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black87),),
                      SizedBox(width: 10,),
                      Text(
                        widget.user.about,
                        style:
                        const TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            )),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Joined On: ",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black87),),
            SizedBox(width: 10,),
            Text(
              MyDateUtil.getLastMessageTime(context: context, time: widget.user.createdAt,showYear: true),
              style:
              const TextStyle(color: Colors.black54, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
