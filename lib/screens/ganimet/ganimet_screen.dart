import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/theme.dart';
import '../../services/haptic_service.dart';
import '../../providers/o2_provider.dart';
import '../../widgets/glassmorphic_card.dart';
import '../../l10n/app_localizations.dart';

// ──────────────────────────────────────────────
// GANIMET DATA PROVIDER
// ──────────────────────────────────────────────

final _ganimetProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final data = await Supabase.instance.client
      .from('ganimet_noktalari')
      .select()
      .eq('aktif', true)
      .order('created_at', ascending: false);
  return List<Map<String, dynamic>>.from(data);
});

// ──────────────────────────────────────────────
// SCREEN
// ──────────────────────────────────────────────

class GanimetScreen extends ConsumerStatefulWidget {
  const GanimetScreen({super.key});

  @override
  ConsumerState<GanimetScreen> createState() => _GanimetScreenState();
}

class _GanimetScreenState extends ConsumerState<GanimetScreen> {
  GoogleMapController? _mapCtrl;
  Map<String, dynamic>? _selected;

  static const _turkeyCenter = LatLng(39.0, 35.0);

  Set<Marker> _buildMarkers(List<Map<String, dynamic>> items) {
    return items.map((item) {
      final lat = (item['lat'] as num).toDouble();
      final lng = (item['lng'] as num).toDouble();
      return Marker(
        markerId: MarkerId(item['id'] as String),
        position: LatLng(lat, lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        onTap: () {
          HapticService.light();
          setState(() => _selected = item);
        },
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final o2 = ref.watch(o2Provider);
    final ganimetAsync = ref.watch(_ganimetProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Google Map
          ganimetAsync.when(
            data: (items) => GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: _turkeyCenter,
                zoom: 6,
              ),
              markers: _buildMarkers(items),
              onMapCreated: (ctrl) => _mapCtrl = ctrl,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              style: _darkMapStyle,
            ),
            loading: () => const Center(
                child:
                    CircularProgressIndicator(color: AppColors.neonGreen)),
            error: (_, __) => Center(
                child: Text(l.mapLoadFailed,
                    style: AppTextStyles.bodySecondary)),
          ),

          // Top bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _circleButton(
                    Icons.arrow_back_ios_new_rounded,
                    () {
                      HapticService.light();
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 12),
                  Text(l.offGridMarket, style: AppTextStyles.h1),
                  const Spacer(),
                  _o2Chip(o2.balance),
                ],
              ),
            ),
          ),

          // Bottom sheet when marker selected
          if (_selected != null) _buildBottomSheet(_selected!, o2.balance),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.bg.withValues(alpha: 0.7),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Icon(icon, color: AppColors.textSecondary, size: 18),
      ),
    );
  }

  Widget _o2Chip(int balance) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.bg.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neonGreen.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('O\u2082',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.neonGreen.withValues(alpha: 0.7))),
          const SizedBox(width: 4),
          Text('$balance',
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.neonGreen)),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(Map<String, dynamic> item, int balance) {
    final l = AppLocalizations.of(context)!;
    final name = item['mekan_adi'] as String? ?? '';
    final address = item['adres'] as String? ?? '';
    final photoUrl = item['photo_url'] as String?;
    final o2Cost = item['o2_maliyet'] as int? ?? 0;
    final odul = item['odul_baslik'] as String? ?? '';
    final canAfford = balance >= o2Cost;

    return DraggableScrollableSheet(
      initialChildSize: 0.42,
      minChildSize: 0.15,
      maxChildSize: 0.65,
      builder: (context, scrollCtrl) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.bg.withValues(alpha: 0.95),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(
                top: BorderSide(
                    color: AppColors.neonGreen.withValues(alpha: 0.15))),
            boxShadow: [
              BoxShadow(
                  color: AppColors.neonGreen.withValues(alpha: 0.05),
                  blurRadius: 30,
                  offset: const Offset(0, -8)),
            ],
          ),
          child: ListView(
            controller: scrollCtrl,
            padding: EdgeInsets.zero,
            children: [
              // Drag handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.textTertiary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Photo
              if (photoUrl != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      photoUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (_, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          height: 200,
                          color: AppColors.surface,
                          child: const Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.neonGreen, strokeWidth: 2)),
                        );
                      },
                      errorBuilder: (_, __, ___) => Container(
                        height: 200,
                        color: AppColors.surface,
                        child: const Center(
                            child: Icon(Icons.image_not_supported_rounded,
                                color: AppColors.textTertiary, size: 40)),
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: AppTextStyles.h1
                            .copyWith(fontWeight: FontWeight.w700)),
                    if (address.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(address, style: AppTextStyles.bodySecondary),
                    ],
                    const SizedBox(height: 12),
                    // O2 badge + odul
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color:
                                AppColors.neonGreen.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppColors.neonGreen
                                    .withValues(alpha: 0.3)),
                          ),
                          child: Text('$o2Cost O\u2082',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.neonGreen)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(odul,
                              style: AppTextStyles.h3
                                  .copyWith(color: AppColors.gold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Al button
                    GestureDetector(
                      onTap: () => _onRedeem(item, canAfford),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: canAfford
                              ? AppColors.neonGreen
                              : AppColors.textTertiary,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: canAfford
                              ? [
                                  BoxShadow(
                                      color: AppColors.neonGreen
                                          .withValues(alpha: 0.3),
                                      blurRadius: 12)
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            canAfford ? l.redeem : l.insufficientO2,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: canAfford
                                  ? Colors.black
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onRedeem(Map<String, dynamic> item, bool canAfford) {
    final l = AppLocalizations.of(context)!;
    if (!canAfford) {
      HapticService.warning();
      return;
    }
    HapticService.heavy();
    final odul = item['odul_baslik'] as String? ?? '';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardBg,
        title: Text(l.confirm, style: AppTextStyles.h2),
        content: Text(l.confirmRedeemMsg(odul), style: AppTextStyles.body),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l.cancel)),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              HapticService.success();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(l.itemReceived(odul)),
                backgroundColor: AppColors.neonGreen,
                behavior: SnackBarBehavior.floating,
              ));
              setState(() => _selected = null);
            },
            child: Text(l.redeem,
                style: const TextStyle(color: AppColors.neonGreen)),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────
// DARK MAP STYLE
// ──────────────────────────────────────────────

const _darkMapStyle = '''
[
  {"elementType":"geometry","stylers":[{"color":"#212121"}]},
  {"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},
  {"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},
  {"featureType":"road","elementType":"geometry","stylers":[{"color":"#2c2c2c"}]},
  {"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]}
]
''';
