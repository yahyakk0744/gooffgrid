import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../widgets/premium_background.dart';
import '../../config/constants.dart';
// import '../../providers/user_provider.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _nameController = TextEditingController();
  int _selectedAvatar = 0;
  int _selectedAge = -1;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text('Profilini Olustur', style: AppTextStyles.h1),
              const SizedBox(height: 32),

              // Name
              const Text('Ismin', style: AppTextStyles.label),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Adini yaz',
                  hintStyle: const TextStyle(color: AppColors.textTertiary),
                  filled: true,
                  fillColor: AppColors.cardBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.cardBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.cardBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.neonGreen),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Avatar
              const Text('Avatar', style: AppTextStyles.label),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(8, (i) {
                  final color = AppConstants.avatarColors[i];
                  final selected = _selectedAvatar == i;
                  final initial = _nameController.text.isNotEmpty ? _nameController.text[0].toUpperCase() : '?';
                  return GestureDetector(
                    onTap: () => setState(() => _selectedAvatar = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 56,
                      height: 56,
                      transform: Matrix4.identity()..scale(selected ? 1.1 : 1.0),
                      transformAlignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected ? AppColors.neonGreen : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Text(initial, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),

              // Age group
              const Text('Yas Grubu', style: AppTextStyles.label),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(AppConstants.ageGroups.length, (i) {
                    final selected = _selectedAge == i;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedAge = i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: selected ? AppColors.neonGreen : AppColors.cardBg,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: selected ? AppColors.neonGreen : AppColors.cardBorder),
                          ),
                          child: Text(
                            AppConstants.ageGroups[i],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: selected ? Colors.black : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 48),

              // Submit
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonGreen,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  child: const Text('Hazirim'),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
