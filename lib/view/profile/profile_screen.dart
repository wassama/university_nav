import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'component/personal_info_component.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.orange,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(() => EditProfileScreen());
              },
              child:  Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white,width: 1.5)
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            )
          ],
          title: Text(
            'Profile',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 20),
          ),
        ),
        body: SafeArea(
          child: StreamBuilder<DocumentSnapshot>(
            stream: _firestore
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 140, vertical: 300),
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data == null || !snapshot.data!.exists) {
                  return const Center(
                    child: Text('No data available for this user.'),
                  );
                }
                final Map<String, dynamic> map =
                    snapshot.data!.data() as Map<String, dynamic>? ?? {};
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            )
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            PhysicalModel(
                              color: Colors.white,
                              clipBehavior: Clip.hardEdge,
                              shape: BoxShape.circle,
                              child: CircleAvatar(
                                radius: 30,
                                child: (map['image'] ?? '').toString().isEmpty
                                    ? const Icon(CupertinoIcons.profile_circled)
                                    : Image.network(
                                        map['image'],
                                        height: 130,
                                        width: 130,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            const SizedBox(width: 25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  map['userName'] ?? 'No Name',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  map['email'] ?? 'No emial',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height:  61),
                      const Text(
                        'Profile Info',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      PersonalInfoComponent(
                        icon: Icons.verified_user_outlined,
                        text1: 'Name',
                        text2: map['userName'] ?? '',
                      ),
                      const SizedBox(height:  15),
                      PersonalInfoComponent(
                        icon: Icons.alternate_email,
                        text1: 'Email',
                        text2: map['email'] ?? '',
                      ),
                      const SizedBox(height:  15),
                      PersonalInfoComponent(
                        icon: Icons.lock,
                        text1: 'phone',
                        text2: map['number']?.toString() ?? 'xxx-xxx-xxx',
                      ),
                      const SizedBox(height:  15),
                      const PersonalInfoComponent(
                        icon: Icons.lock,
                        text1: 'Password',
                        text2: '**********',
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text('Something went wrong!'),
                );
              }
            },
          ),
        ));
  }
}
