import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';

class PolicyTermsScreen extends StatelessWidget {
  PolicyTermsScreen({super.key});

  final RxString selectedSection = ''.obs;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Abhi Herbals'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: isDarkMode ? Colors.black : const Color(0xFFF2F2F2),
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 900),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[850] : Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  if (!isDarkMode)
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                ],
              ),
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome to Abhi Herbals',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'We are committed to protecting your personal information and ensuring a secure, ad-free shopping experience for fresh, herbal juices.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDarkMode ? Colors.grey[300] : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => selectedSection.value = 'privacy',
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedSection.value == 'privacy'
                                ? Colors.green[700]
                                : (isDarkMode ? Colors.black : Colors.white),
                            foregroundColor: selectedSection.value == 'privacy'
                                ? Colors.white
                                : (isDarkMode ? Colors.white : Colors.black),
                            side: BorderSide(color: Colors.green[700]!),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                          child: const Text('View Privacy Policy'),
                        ),
                        ElevatedButton(
                          onPressed: () => selectedSection.value = 'terms',
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedSection.value == 'terms'
                                ? Colors.green[700]
                                : (isDarkMode ? Colors.black : Colors.white),
                            foregroundColor: selectedSection.value == 'terms'
                                ? Colors.white
                                : (isDarkMode ? Colors.white : Colors.black),
                            side: BorderSide(color: Colors.green[700]!),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                          child: const Text('View Terms & Conditions'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (selectedSection.value == 'privacy') _privacyPolicy(isDarkMode),
                    if (selectedSection.value == 'terms') _termsAndConditions(isDarkMode),
                    const SizedBox(height: 40),
                    Text(
                      '© 2025 Abhi Herbals. All rights reserved.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: isDarkMode ? Colors.grey[400] : Colors.grey),
                    )
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _privacyPolicy(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Privacy Policy', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black)),
        const SizedBox(height: 8),
        Text('Last updated: April 05, 2025', style: TextStyle(color: isDarkMode ? Colors.grey[300] : Colors.black87)),
        const SizedBox(height: 10),
        ...[
          'Abhi Herbals is dedicated to safeguarding your privacy. This policy explains how we collect, use, and protect your personal data.',
          'We collect information such as your name, email, phone number, address, city, state, and postal code to process your juice orders and provide customer support.',
          'Your data is stored securely and used strictly for order fulfillment, support, and service improvement purposes.',
          'We do not share, sell, or lease your data to any third-party for commercial gain. There are no advertisements within our application.',
          'We may use anonymized data internally for analytical purposes to enhance your experience and improve our product range.',
          'We use modern encryption and security practices to ensure the safety of your data. However, no internet transmission is 100% secure.',
          'Users may request to update, access or delete their data by contacting us directly. We will process these requests within a reasonable timeframe.',
          'We comply with applicable data protection regulations and do not knowingly collect data from children under the age of 13.',
          'Contact us: sachshri3293@gmail.com | Phone: 7988858339',
        ].map((text) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(text, style: TextStyle(color: isDarkMode ? Colors.grey[300] : Colors.black87)),
            )),
      ],
    );
  }

  Widget _termsAndConditions(bool isDarkMode) {
    const termsList = [
      'By using the Abhi Herbals application, you agree to the following terms:',
      '• The app is intended solely for users looking to order natural and herbal juices for personal consumption.',
      '• Users must provide accurate and up-to-date personal details to ensure proper order processing and delivery.',
      '• All personal data is handled as per our Privacy Policy and is not shared or misused.',
      '• You are responsible for maintaining the confidentiality of your login information and for all activities under your account.',
      '• Products listed in the app are subject to availability and may be updated or discontinued without notice.',
      '• While our herbal juices are natural, we make no medical claims or guarantees. Please consult your physician before use if you have health concerns.',
      '• Abhi Herbals is not liable for delays or non-fulfillment of services caused by natural calamities, network failures, or third-party issues.',
      '• Any misuse of the app including spamming, fraudulent orders, or hacking attempts will lead to immediate suspension of services.',
      '• We reserve the right to update these terms at any time. Continued use of the app constitutes acceptance of the revised terms.',
      '• All purchases are subject to our standard delivery and return policies.',
      '• Use of our services implies your acceptance of these terms.'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: termsList
          .map((text) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(text, style: TextStyle(color: isDarkMode ? Colors.grey[300] : Colors.black87)),
              ))
          .toList(),
    );
  }
}