import 'package:flutter/material.dart';
import 'package:last_gp/src/pages/LoginPage.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Welcome to Pharmacy App',
      'description': 'Order your medications easily',
      'image': 'assets/98651-app-onboarding-03.json',
    },
    {
      'title': 'Pneumonia Detection',
      'description': 'Check your x-ray',
      'image': 'assets/84935-x-ray-exam.json',
    },
    {
      'title': 'Login Easily',
      'description': 'Login and register easily',
      'image': 'assets/38435-register.json',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _onboardingData.length,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return buildOnboardingPage(
                  _onboardingData[index]['title']!,
                  _onboardingData[index]['description']!,
                  _onboardingData[index]['image']!,
                );
              },
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            child: Text(
              _currentPage == _onboardingData.length - 1 ? 'Get Started' : 'Next',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (_currentPage == _onboardingData.length - 1) {
                // Handle "Get Started" button tap
                // e.g., navigate to the home screen
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildOnboardingPage(String title, String description, String image) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 60.0),
          Text(
            title,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          Text(
            description,
            style: TextStyle(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.0),
          Lottie.asset(
            image,
            height: 250.0,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _onboardingData.length; i++) {
      indicators.add(
        i == _currentPage ? _buildIndicator(true) : _buildIndicator(false),
      );
    }
    return indicators;
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
