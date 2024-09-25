import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SubCategoryDetailsScreen extends StatefulWidget {
  final List images;

  SubCategoryDetailsScreen({required this.images, super.key});

  @override
  State<SubCategoryDetailsScreen> createState() => _SubCategoryDetailsScreen();
}

class _SubCategoryDetailsScreen extends State<SubCategoryDetailsScreen> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true); // Repeats the animation and reverses it
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.vertical,
            controller: _pageController,
            reverse: true,
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: widget.images[index].toString(),
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
              );
            },
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 2,
            right: 16,
            child: Container(
              width: 8,
              height: 200,
              child: ListView.builder(
                itemCount: widget.images.length,
                reverse: true,
                itemBuilder: (context, index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    width: 8,
                    height: _currentPage == index ? 25 : 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: _currentPage == index
                          ? Colors.amber.shade600
                          : Colors.tealAccent,
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: MediaQuery.of(context).size.width / 2 - 20, // Center the icons
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Icon(
                          Icons.double_arrow_rounded,
                          size: 35,
                          color: Colors.amber.shade600,
                        ),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Icon(
                          Icons.double_arrow_rounded,
                          size: 40,
                          color: Colors.amber.shade600,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}