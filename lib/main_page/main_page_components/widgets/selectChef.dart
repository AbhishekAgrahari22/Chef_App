import 'dart:ui';
import 'package:flutter/material.dart';

class ChefSelectionPage extends StatefulWidget {
  final List<String> selectedItems;

  const ChefSelectionPage({super.key, required this.selectedItems});

  @override
  State<ChefSelectionPage> createState() => _ChefSelectionPageState();
}

class _ChefSelectionPageState extends State<ChefSelectionPage> {
  String? selectedChef;
  final PageController _pageController = PageController();
  double currentPage = 0;

  final List<Map<String, dynamic>> chefs = [
    {
      "name": "Chef Anjali",
      "experience": "8 years experience",
      "reviews": "4.9 ★ (120 reviews)",
      "image": "assets/images/chef.png",
    },
    {
      "name": "Chef Aman",
      "experience": "5 years experience",
      "reviews": "4.7 ★ (85 reviews)",
      "image": "assets/images/chef.png",
    },
    {
      "name": "Chef Priya",
      "experience": "6 years experience",
      "reviews": "4.8 ★ (102 reviews)",
      "image": "assets/images/chef.png",
    },
    {
      "name": "Chef Raj",
      "experience": "10 years experience",
      "reviews": "5.0 ★ (140 reviews)",
      "image": "assets/images/chef.png",
    },
    {
      "name": "Chef Meera",
      "experience": "7 years experience",
      "reviews": "4.9 ★ (110 reviews)",
      "image": "assets/images/chef.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget buildChefCard(int index) {
    final chef = chefs[index];
    final isSelected = chef["name"] == selectedChef;

    return GestureDetector(
      onTap: () {
        setState(() => selectedChef = chef["name"]);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: Offset(0, (currentPage - index) * 60),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? Colors.greenAccent
                        : Color.fromRGBO(255, 255, 255, 0.1),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Color.fromRGBO(255, 255, 255, 0.2),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            chef["image"],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          chef["name"],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          chef["experience"],
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          chef["reviews"],
                          style: const TextStyle(color: Colors.white54),
                        ),
                        const SizedBox(height: 12),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: const Icon(Icons.check_circle, size: 28),
                          // isSelected
                          //     ? const Icon(
                          //       Icons.check_circle,
                          //       color: Colors.greenAccent,
                          //       size: 28,
                          //     )
                          //     : const SizedBox(height: 28),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSwipeIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.arrow_forward_ios, color: Colors.white60, size: 20),
        const SizedBox(width: 6),
        const Text(
          "Swipe to explore chefs",
          style: TextStyle(color: Colors.white60, fontSize: 14),
        ),
      ],
    );
  }

  Widget buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        chefs.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: index == currentPage.round() ? 20 : 8,
          decoration: BoxDecoration(
            color:
                index == currentPage.round()
                    ? Colors.greenAccent
                    : Colors.white60,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: const Text("Select Your Chef"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: chefs.length,
              itemBuilder: (context, index) => buildChefCard(index),
            ),
          ),
          buildSwipeIndicator(),
          const SizedBox(height: 12),
          buildPageIndicator(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton(
              onPressed:
                  selectedChef == null
                      ? null
                      : () {
                        showDialog(
                          context: context,
                          builder:
                              (_) => AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text("Booking Confirmed!"),
                                content: Text(
                                  "Chef: $selectedChef\nItems: ${widget.selectedItems.join(', ')}",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.popUntil(
                                          context,
                                          (route) => route.isFirst,
                                        ),
                                    child: const Text("Done"),
                                  ),
                                ],
                              ),
                        );
                      },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text(
                "Continue to Confirm",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
