import 'package:chef_app/Authentication/screens/register.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with TickerProviderStateMixin {
  bool _showChefHat = false;
  bool _showFork = false;
  bool _showBrand = false;
  bool _showFinalText = false;

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() => _showChefHat = true);

    await Future.delayed(const Duration(milliseconds: 400));
    setState(() => _showFork = true);

    await Future.delayed(const Duration(milliseconds: 400));
    setState(() => _showBrand = true);

    await Future.delayed(const Duration(milliseconds: 600));
    setState(() => _showFinalText = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (mounted) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => Register()));
    }
  }

  Widget _animatedImage({
    required String path,
    required bool show,
    double width = 150,
    double height = 40,
    BoxFit fit = BoxFit.contain,
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 600),
      opacity: show ? 1 : 0,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 600),
        offset: show ? Offset.zero : const Offset(0, 0.3),
        child: Image.asset(path, width: width, height: height, fit: fit),
      ),
    );
  }

  Widget _animatedText({required bool show}) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 600),
      opacity: show ? 1 : 0,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 600),
        offset: show ? Offset.zero : const Offset(0, 0.3),
        child: const Text(
          "ChefDev",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E2E2E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _animatedImage(
              path: 'assets/images/chef_hat.png',
              show: _showChefHat,
              width: 150,
              height: 100,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 12),
            _animatedImage(
              path: 'assets/images/fork_icon.png',
              show: _showFork,
              width: 150,
              height: 30,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 12),
            _animatedImage(
              path: 'assets/images/chefdev_text.png',
              show: _showBrand,
              width: 150,
              height: 35,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 20),
            _animatedText(show: _showFinalText),
          ],
        ),
      ),
    );
  }
}
