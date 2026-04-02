import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../widgets/premium_background.dart';
import '../../widgets/app_card.dart';

class WhatIfScreen extends StatelessWidget {
  const WhatIfScreen({super.key});

  static const _items = [
    {'emoji': '\u{1F4DA}', 'text': "Instagram'da 8 saat = 2 kitap okurdun"},
    {'emoji': '\u{1F393}', 'text': "YouTube'da 6 saat = 1 online kurs bitirirdin"},
    {'emoji': '\u{1F4D6}', 'text': "TikTok'ta 4 saat = 60 sayfa çalışırdın"},
    {'emoji': '\u{1F3D6}', 'text': 'Toplam 22 saat = 3 gün tatil'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(onTap: () => context.pop(), child: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary)),
                  const SizedBox(width: 12),
                  const Text('Ne Yapabilirdin?', style: AppTextStyles.h1),
                ],
              ),
              const SizedBox(height: 24),
              ..._items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: AppCard(
                  child: Row(
                    children: [
                      Text(item['emoji']!, style: const TextStyle(fontSize: 36)),
                      const SizedBox(width: 16),
                      Expanded(child: Text(item['text']!, style: AppTextStyles.body)),
                    ],
                  ),
                ),
              )),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
