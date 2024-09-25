import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:university_nav/view/profile/profile_controller.dart';

import '../../widgets/rounded_buttom.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  final bool _isLoading = false;
  bool _isInitialized = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.orange,
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text('Edit Profile',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w900)),
            centerTitle: true),
        body: Consumer<ProfileController>(
          builder: (context, profileController, child) {
            return StreamBuilder(
                stream: _firestore
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 140, vertical: 300),
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    final Map<String, dynamic> map =
                        snapshot.data!.data() as Map<String, dynamic>;
                    if (!_isInitialized) {
                      nameController.text = map['userName'] ?? '';
                      phoneNumberController.text =
                          map['number'] ?? 'xxx-xxx-xxx';
                      emailController.text = map['email'] ?? '';
                      _isInitialized = true;
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 15),
                            const Text(
                              'Personal Info',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Manage your personal Info',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                profileController.pickImage(context);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      PhysicalModel(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        clipBehavior: Clip.hardEdge,
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.white,
                                          child: profileController.image == null
                                              ? (map['image'] ?? '')
                                                      .toString()
                                                      .isEmpty
                                                  ? const Icon(CupertinoIcons
                                                      .profile_circled)
                                                  : Image.network(
                                                      map['image'],
                                                      height: 130,
                                                      width: 130,
                                                      fit: BoxFit.fill,
                                                    )
                                              : _isLoading
                                                  ? const CircularProgressIndicator()
                                                  : Image.file(
                                                      File(profileController
                                                          .image!.path),
                                                      fit: BoxFit.fill,
                                                      height: 130,
                                                      width: 130,
                                                    ),
                                        ),
                                      ),
                                      const Positioned(
                                        bottom: 0,
                                        right: -2,
                                        child: CircleAvatar(
                                          maxRadius: 8,
                                          backgroundColor: Colors.indigo,
                                          child: Icon(
                                            Icons.camera_alt,
                                            size: 10,
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Change Your Photo',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.orange,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 17),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Personal Info',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: nameController,
                              cursorColor: Colors.orangeAccent,
                              onFieldSubmitted: (p0) {
                                FocusScope.of(context).requestFocus(emailFocus);
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                labelText: 'Name',
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: emailController,
                              cursorColor: Colors.orangeAccent,
                              onFieldSubmitted: (p0) {
                                FocusScope.of(context).requestFocus(phoneFocus);
                              },
                              focusNode: emailFocus,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: phoneNumberController,
                              cursorColor: Colors.orangeAccent,
                              onFieldSubmitted: (p0) {
                                FocusScope.of(context).requestFocus(emailFocus);
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            Center(
                              child: RoundedButton(
                                  buttonText: 'Update',
                                  onPress: () {
                                    profileController
                                        .updateProfile(
                                            context,
                                            nameController.text.trim(),
                                            emailController.text.trim(),
                                            phoneNumberController.text.trim())
                                        .then((value) => Get.back());
                                  },
                                  buttonColor: Colors.orange),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('Something went wrong!'),
                    );
                  }
                });
          },
        ),
      ),
    );
  }
}
