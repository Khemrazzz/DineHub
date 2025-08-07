import 'package:flutter/material.dart';

class ErrorEmptyPage extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onRetry;
  final VoidCallback? onClearFilters;

  const ErrorEmptyPage({
    super.key,
    required this.title,
    required this.message,
    required this.onRetry,
    this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6B6B),
        title: const Text('DineHub'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '🔍',
                style: TextStyle(fontSize: 48, color: Colors.black38),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A5568),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF718096),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B6B),
                  minimumSize: const Size.fromHeight(45),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Try Again'),
              ),
              if (onClearFilters != null) const SizedBox(height: 12),
              if (onClearFilters != null)
                OutlinedButton(
                  onPressed: onClearFilters,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF4A5568),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                    minimumSize: const Size.fromHeight(45),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Clear Filters'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
