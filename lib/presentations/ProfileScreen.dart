import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messagingapp/helper/dialog.dart';
import '../API/api.dart';
import '../main.dart';
import '../models/chat_user.dart';
import 'auth/loginScreen.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile Screen"),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mq.width * .05, vertical: mq.height * .05),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: mq.width,
                      height: mq.width * .02,
                    ),
                    Stack(
                      children: [
                        _image != null
                            ?
                            //local image
                            ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(mq.height * .1),
                                child: Image.file(
                                  File(_image!),
                                  width: mq.width *.4,
                                  height: mq.height *.18,
                                  fit: BoxFit.cover,
                                ),
                              )
                            :
                            //server image
                            ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(mq.height * .1),
                                child: CachedNetworkImage(
                                  width: mq.width * .4,
                                  fit: BoxFit.cover,
                                  height: mq.height * .18,
                                  imageUrl: widget.user.image,
                                  // placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const CircleAvatar(child: Icon(Icons.person)),
                                ),
                              ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: MaterialButton(
                              elevation: 1,
                              shape: CircleBorder(),
                              onPressed: () {
                                _showBottomSheet();
                              },
                              color: Colors.white,
                              child: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      width: mq.width,
                      height: mq.width * .04,
                    ),
                    Text(
                      widget.user.email,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    SizedBox(
                      width: mq.width,
                      height: mq.width * .04,
                    ),
                    TextFormField(
                      initialValue: widget.user.name,
                      onSaved: (val) => Apis.me.name = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : "Required field",
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                          hintText: "eg. John Doe",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          label: Text("Name")),
                    ),
                    SizedBox(
                      width: mq.width,
                      height: mq.width * .02,
                    ),
                    TextFormField(
                      initialValue: widget.user.about,
                      onSaved: (val) => Apis.me.about = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : "Required field",
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.info_outline,
                            color: Colors.blue,
                          ),
                          hintText: "Can't talk, TalksIndia only",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          label: const Text("About")),
                    ),
                    SizedBox(
                      width: mq.width,
                      height: mq.width * .02,
                    ),
                    //update profile button
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          minimumSize: Size(mq.width * .5, mq.height * .06)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Apis.updateUserInfo().then((value) {
                            Dialogs.showSnackbar(
                                context, "Profile updated successfully");
                          });
                        }
                      },
                      icon: Icon(Icons.edit),
                      label: Text(
                        "Update",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              )),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          //for add new users
          child: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            onPressed: () async {
              //for showing progressbar
              Dialogs.showProgressBar(context);
              await Apis.updateActiveStatus(false);
              //signOut from app
              await Apis.auth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) async {
                  //for hiding progressbar
                  Navigator.pop(context);
                  //replace home screen with login screen
                  Navigator.pop(context);
                  Apis.auth = FirebaseAuth.instance;

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                });
              });
            },
            label: const Text("Logout"),
            icon: const Icon(Icons.logout),
          ),
        ),
      ),
    );
  }

  //bottom sheet for picking a profile picture for user
  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding:
                EdgeInsets.only(top: mq.height * .03, bottom: mq.height * .08),
            children: [
              const Text(
                "Pick profile picture",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.white,
                          fixedSize: Size(mq.height * .15, mq.width * .3)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
                        if (image != null) {
                          print('Image path: ${image.path} --MimeType: ${image.mimeType}');
                          setState(() {
                            _image = image.path;
                          });
                          Apis.updateProfilePicture(File(_image!));
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(
                        Icons.add_photo_alternate_outlined,
                        color: Colors.blue,
                        size: 100,
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.white,
                          fixedSize: Size(mq.height * .15, mq.width * .3)),
                      onPressed: () async{
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.camera,imageQuality: 80);
                        if (image != null) {
                          print('Image path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });
                          Apis.updateProfilePicture(File(_image!));
                          Dialogs.showSnackbar(context, "Image uploaded");
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(
                        color: Colors.blue,
                        Icons.add_a_photo_outlined,
                        size: 100,
                      ))
                ],
              )
            ],
          );
        });
  }
}
