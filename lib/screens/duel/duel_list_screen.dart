import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../widgets/duel_card.dart';
import '../../models/duel.dart' show DuelStatus;
import '../../providers/duel_provider.dart';
import '../../widgets/premium_background.dart';
import '../../widgets/empty_state.dart';
import '../../services/haptic_service.dart';

class DuelListScreen extends ConsumerWidget {
  const DuelListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duels = ref.watch(duelProvider);
    final active = duels.where((d) => d.status == DuelStatus.active).toList();
    final past = duels.where((d) => d.status == DuelStatus.completed).toList();

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Duellolar', style: AppTextStyles.h1),
              const SizedBox(height: 24),

              if (duels.isEmpty)
                EmptyState(
                  emoji: '⚡',
                  title: 'Henüz düello yok',
                  subtitle: 'İlk düellonu başlat!',
                  buttonText: 'Düello Oluştur',
                  onButtonTap: () => context.push('/duel/create'),
                ),

              if (active.isNotEmpty) ...[
                const Text('Aktif Duellolar', style: AppTextStyles.h3),
                const SizedBox(height: 12),
                ...active.map((d) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () {
                      HapticService.light();
                      context.push('/duel/${d.id}');
                    },
                    child: DuelCard(
                      player1Name: d.player1.name,
                      player1Minutes: d.player1.totalMinutes,
                      player2Name: d.player2.name,
                      player2Minutes: d.player2.totalMinutes,
                      status: d.status,
                    ),
                  ),
                )),
                const SizedBox(height: 24),
              ],

              if (past.isNotEmpty) ...[
                const Text('Gecmis', style: AppTextStyles.h3),
                const SizedBox(height: 12),
                ...past.map((d) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DuelCard(
                    player1Name: d.player1.name,
                    player1Minutes: d.player1.totalMinutes,
                    player2Name: d.player2.name,
                    player2Minutes: d.player2.totalMinutes,
                    status: d.status,
                    winnerId: d.winnerId,
                  ),
                )),
              ],

              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () => context.push('/duel/create'),
                  icon: const Icon(Icons.bolt_rounded),
                  label: const Text('Yeni Duel'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonGreen,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
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
