import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:university_nav/cosntants/constant.dart';
import 'package:university_nav/view/SubCategory/sub_category_details_screen.dart';
import 'package:university_nav/view/profile/profile_screen.dart';
import '../view_details.dart';

class SubCategoryScreen extends StatefulWidget {
  final List subCategory;
  const SubCategoryScreen({required this.subCategory, Key? key}) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => SubCategoryScreenState();
}

class SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber.shade600,
        title: Image.asset('assets/logo.png', height: 80, width: 120,),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 15),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: widget.subCategory.length,
              itemBuilder: (context, index) {
                final subCategory = widget.subCategory[index];
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubCategoryDetailsScreen(
                          images: subCategory['images'],
                        ),
                      ),
                    );
                  },
                  child: PhysicalModel(
                    color: Colors.transparent,
                    clipBehavior: Clip.hardEdge,
                    shadowColor: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    elevation: 2,
                    child: GridTile(
                      footer: Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.6)),
                        child: Center(
                          child: Text(
                            subCategory['name'].toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: subCategory['icon'].toString(),
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}