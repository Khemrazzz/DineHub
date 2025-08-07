import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('About DineHub'),
        backgroundColor: const Color(0xFFFF6B6B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Column(
            children: const [
              SizedBox(height: 10),
              Text(
                '🍽️',
                style: TextStyle(fontSize: 50),
              ),
              SizedBox(height: 10),
              Text(
                'DineHub v1.0.0',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Discover Amazing Restaurants',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF718096),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _infoCard(
            title: 'Our Mission',
            content:
                'To help food lovers discover the best restaurants in their area and share their dining experiences.',
          ),
          const SizedBox(height: 20),
          _infoCard(
            title: 'Features',
            content: '''
• Restaurant discovery  
• Location-based search  
• User reviews & ratings  
• Interactive maps  
• Menu browsing
''',
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // TODO: Rate app or open store
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B6B),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Rate This App'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Navigate to contact support page or open email
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF4A5568),
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            child: const Text('Contact Support'),
          ),
        ],
      ),
    );
  }

  static Widget _infoCard({required String title, required String content}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3748))),
          const SizedBox(height: 8),
          Text(content,
              style: const TextStyle(
                  fontSize: 12, height: 1.5, color: Color(0xFF4A5568))),
        ],
      ),
    );
  }
}
