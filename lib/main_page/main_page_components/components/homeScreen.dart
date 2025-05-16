import 'package:flutter/material.dart';
import '../widgets/eventCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Improved Header
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(
                        0,
                        123,
                        255,
                        0.9,
                      ), // BlueAccent with opacity
                      Color.fromRGBO(0, 0, 255, 0.7), // Blue with opacity
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Discover Your Event Chef!',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black45,
                                      offset: Offset(1, 1),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset('assets/images/chef.png', height: 50),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Book a personal chef for weddings, birthdays, corporate parties & more!',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Animated Event Cards
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    EventCard(
                      title: "Wedding",
                      imagePath: "assets/images/wedding.png",
                      tag: 'wedding',
                    ),
                    SizedBox(height: 16),
                    EventCard(
                      title: "Birthday",
                      imagePath: "assets/images/birthday.jpg",
                      tag: 'birthday',
                    ),
                    SizedBox(height: 16),
                    EventCard(
                      title: "Corporate Party",
                      imagePath: "assets/images/corporate.jpg",
                      tag: 'corporate',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
