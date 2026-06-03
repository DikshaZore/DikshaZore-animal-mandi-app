import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../routes/app_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingPages = [
    OnboardingData(icon: Icons.location_on_rounded, title: 'Find Nearby Animals', description: 'Discover animals near you with just a few taps.'),
    OnboardingData(icon: Icons.trending_up, title: 'Buy & Sell Quickly', description: 'Post your animals or browse listings in minutes.'),
    OnboardingData(icon: Icons.phone, title: 'Direct Contact', description: 'Call or WhatsApp sellers directly without middlemen.'),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _onboardingPages.length,
            itemBuilder: (context, index) => OnboardingPage(data: _onboardingPages[index]),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _onboardingPages.length,
                  effect: const ExpandingDotsEffect(dotColor: Color(0xFFE0E0E0), activeDotColor: Color(0xFF2D8659), dotHeight: 8, dotWidth: 8, spacing: 8),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage == _onboardingPages.length - 1) {
                        context.go(Routes.login);
                      } else {
                        _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                      }
                    },
                    child: Text(_currentPage == _onboardingPages.length - 1 ? 'Get Started' : 'Next'),
                  ),
                ),
                if (_currentPage > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () => _pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut),
                        child: const Text('Back'),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingData {
  final IconData icon;
  final String title;
  final String description;
  OnboardingData({required this.icon, required this.title, required this.description});
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  const OnboardingPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAFAFA),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF2D8659).withOpacity(0.1)),
            child: Icon(data.icon, size: 80, color: const Color(0xFF2D8659)),
          ),
          const SizedBox(height: 32),
          Text(data.title, style: const TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF1F1F1F)), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(data.description, style: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF757575)), textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}