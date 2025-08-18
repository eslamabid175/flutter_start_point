import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = '${info.version} (${info.buildNumber})';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(Icons.school,
                  size: 60, color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Samir Academy',
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Who We Are', theme),
            _buildParagraph(
              'Samir Academy is a digital learning platform built specifically for medical students. We provide courses, flashcards, and quizzes tailored to help students succeed in their academic journey.',
              theme,
            ),
            _buildSectionTitle('Our Mission', theme),
            _buildParagraph(
              'To simplify and enhance medical education through interactive content, easy access, and practical tools like flashcards and practice tests.',
              theme,
            ),
            _buildSectionTitle('Why Choose Us?', theme),
            _buildParagraph(
              '✓ Designed by medical professionals\n'
              '✓ User-friendly interface\n'
              '✓ Regularly updated content\n'
              '✓ Comprehensive resources for all medical subjects',
              theme,
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'App Version: $_version',
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                '© 2025 Samir Academy. All rights reserved.',
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) => Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        child: Text(
          title,
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      );

  Widget _buildParagraph(String text, ThemeData theme) => Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
      );
}
