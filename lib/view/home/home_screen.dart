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
import 'package:university_nav/view/profile/profile_screen.dart';
import '../SubCategory/sub_category.dart';
import '../view_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> subCategories = [];
  List<Map<String, dynamic>> filteredCategories = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _listenToCategories();
    _searchController.addListener(() {
      _filterCategories(_searchController.text);
    });
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final localCategories = prefs.getString('categories');
    if (localCategories != null) {
      setState(() {
        categories = List<Map<String, dynamic>>.from(json.decode(localCategories));
        filteredCategories = categories;
      });
    }
  }

  Future<void> _storeCategories(List<QueryDocumentSnapshot> docs) async {
    final prefs = await SharedPreferences.getInstance();
    final newCategories = docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    // Prefetch images
    for (var category in newCategories) {
      CachedNetworkImageProvider(category['icon'].toString()).resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((_, __) {}, onError: (dynamic exception, StackTrace? stackTrace) {
          print("Failed to prefetch image: $exception");
        }),
      );
      for (var imageUrl in category['images']) {
        CachedNetworkImageProvider(imageUrl.toString()).resolve(const ImageConfiguration()).addListener(
          ImageStreamListener((_, __) {}, onError: (dynamic exception, StackTrace? stackTrace) {
            print("Failed to prefetch image: $exception");
          }),
        );
      }
    }

    await prefs.setString('categories', json.encode(newCategories));
    setState(() {
      categories = newCategories;
      filteredCategories = newCategories; // Update filtered list
    });
  }



  void _listenToCategories() {
    FirebaseFirestore.instance.collection('categories').snapshots().listen(
          (snapshot) {
        if (snapshot.docs.isNotEmpty) {
          _storeCategories(snapshot.docs);
        }
      },
      onError: (error) {
        print("Error loading categories: $error");
      },
    );
  }



  void _filterCategories(String query) {
    final filtered = categories.where((category) {
      final name = category['name'].toString().toLowerCase();
      final searchQuery = query.toLowerCase();
      return name.contains(searchQuery);
    }).toList();
    setState(() {
      filteredCategories = filtered;
    });
  }

  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber.shade600,
        title: Image.asset('assets/logo.png',height: 80,width: 120,),
        actions: [
          user == null ? const SizedBox.shrink() : IconButton(
            onPressed: () {
              Get.to(() => const ProfileScreen());
            },
            icon: const Icon(
              CupertinoIcons.profile_circled,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              decoration:  InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: -4,horizontal: 13),
                hintText: 'Search Categories',
                hintStyle: const TextStyle(color: Colors.white24),
                suffixIcon: const Icon(CupertinoIcons.search_circle_fill),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: Colors.white)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide:  const BorderSide(color: Colors.amber)
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          filteredCategories.isEmpty
              ? const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 200),
                child: Text('No categories available'),
              ))
              : Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                final category = filteredCategories[index];
                Future<void> _storeSubCategories(List<QueryDocumentSnapshot> docs) async {
                  final prefs = await SharedPreferences.getInstance();
                  final newSubCategories = docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

                  // Prefetch images
                  for (var subCategory in newSubCategories) {
                    CachedNetworkImageProvider(subCategory['icon'].toString()).resolve(const ImageConfiguration()).addListener(
                      ImageStreamListener((_, __) {}, onError: (dynamic exception, StackTrace? stackTrace) {
                        print("Failed to prefetch image: $exception");
                      }),
                    );
                    for (var imageUrl in subCategory['images']) {
                      CachedNetworkImageProvider(imageUrl.toString()).resolve(const ImageConfiguration()).addListener(
                        ImageStreamListener((_, __) {}, onError: (dynamic exception, StackTrace? stackTrace) {
                          print("Failed to prefetch image: $exception");
                        }),
                      );
                    }
                  }

                  await prefs.setString('subCategories_${categories[index]['id']}', json.encode(newSubCategories));
                  setState(() {
                    subCategories = newSubCategories;
                  });
                }
                void _listenToSubCategories() {
                  final categoryId = categories[index]['id'];
                  FirebaseFirestore.instance.collection('categories').doc(categoryId).collection('subcategories').snapshots().listen(
                        (snapshot) {
                      if (snapshot.docs.isNotEmpty) {
                        _storeSubCategories(snapshot.docs);
                      }
                    },
                    onError: (error) {
                      print("Error loading subcategories: $error");
                    },
                  );
                }
                return GestureDetector(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    print('object${category['id']}');
                    final subcategoriesRef = FirebaseFirestore.instance.collection('categories').doc(category['id']).collection('subcategories');
                    final subcategoriesSnapshot = await subcategoriesRef.get();
                    if (subcategoriesSnapshot.docs.isEmpty || !subcategoriesRef.path.contains('subcategories')) {
                      // Navigate to ViewDetails screen if no subcategories or subcollection doesn't exist
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewDetails(
                            category: category['images'],
                          ),
                        ),
                      );
                    } else {
                      // Navigate to SubCategoryScreen with subcategories list
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubCategoryScreen(
                            subCategory: subcategoriesSnapshot.docs.map((doc) => doc.data()).toList(),
                          ),
                        ),
                      );
                    }
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
                            category['name'].toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: category['icon'].toString(),
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