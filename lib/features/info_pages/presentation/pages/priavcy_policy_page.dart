import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('1. Introduction', theme),
            _buildParagraph(
              'This Privacy Policy explains how we collect, use, and protect your information when you use our application.',
              theme,
            ),
            _buildSectionTitle('2. Data Collection', theme),
            _buildParagraph(
              'We may collect personal information such as your name, email address, and usage data to improve your experience.',
              theme,
            ),
            _buildSectionTitle('3. Data Usage', theme),
            _buildParagraph(
              'The collected data is used for improving app features, customer support, and analytics.',
              theme,
            ),
            _buildSectionTitle('4. Third-party Services', theme),
            _buildParagraph(
              'We may use third-party services (e.g., Firebase, analytics tools) that collect information as governed by their own policies.',
              theme,
            ),
            _buildSectionTitle('5. Security', theme),
            _buildParagraph(
              'We implement security measures to protect your data, but no system is 100% secure.',
              theme,
            ),
            _buildSectionTitle('6. Your Choices', theme),
            _buildParagraph(
              'You can choose not to provide certain information, but it may limit functionality.',
              theme,
            ),
            _buildSectionTitle('7. Updates', theme),
            _buildParagraph(
              'We may update this policy from time to time. Changes will be reflected on this page.',
              theme,
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Last updated: June 28, 2025',
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
