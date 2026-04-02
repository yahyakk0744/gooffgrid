import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/theme.dart';
import '../../services/google_places_service.dart';
import '../../services/haptic_service.dart';
import '../../widgets/glassmorphic_card.dart';
import '../../widgets/premium_background.dart';

class AdminGanimetScreen extends StatefulWidget {
  const AdminGanimetScreen({super.key});

  @override
  State<AdminGanimetScreen> createState() => _AdminGanimetScreenState();
}

class _AdminGanimetScreenState extends State<AdminGanimetScreen> {
  final _searchCtrl = TextEditingController();
  final _odulCtrl = TextEditingController();
  final _o2Ctrl = TextEditingController();

  List<PlacePrediction> _predictions = [];
  PlaceDetails? _selectedPlace;
  List<Map<String, dynamic>> _existingItems = [];
  bool _saving = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadExisting();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _odulCtrl.dispose();
    _o2Ctrl.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _loadExisting() async {
    try {
      final data = await Supabase.instance.client
          .from('ganimet_noktalari')
          .select()
          .order('created_at', ascending: false);
      if (mounted) setState(() => _existingItems = List<Map<String, dynamic>>.from(data));
    } catch (e) {
      debugPrint('Ganimet load error: $e');
    }
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.length < 3) {
        setState(() => _predictions = []);
        return;
      }
      final results = await GooglePlacesService.autocomplete(query);
      if (mounted) setState(() => _predictions = results);
    });
  }

  Future<void> _onPredictionTap(PlacePrediction p) async {
    HapticService.light();
    setState(() => _predictions = []);
    _searchCtrl.text = p.mainText;

    final details = await GooglePlacesService.getDetails(p.placeId);
    if (details != null && mounted) {
      setState(() => _selectedPlace = details);
    }
  }

  Future<void> _save() async {
    final place = _selectedPlace;
    if (place == null) return;
    final odul = _odulCtrl.text.trim();
    final o2 = int.tryParse(_o2Ctrl.text.trim());
    if (odul.isEmpty || o2 == null || o2 <= 0) {
      _showSnack('Ödül ve O\u2082 maliyeti doldurun', isError: true);
      return;
    }

    setState(() => _saving = true);
    try {
      await Supabase.instance.client.from('ganimet_noktalari').insert({
        'place_id': place.placeId,
        'mekan_adi': place.name,
        'adres': place.address,
        'photo_url': place.photoUrl,
        'lat': place.lat,
        'lng': place.lng,
        'odul_baslik': odul,
        'o2_maliyet': o2,
        'aktif': true,
      });
      HapticService.success();
      _showSnack('Kaydedildi!');
      _clearForm();
      _loadExisting();
    } catch (e) {
      _showSnack('Hata: $e', isError: true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _clearForm() {
    _searchCtrl.clear();
    _odulCtrl.clear();
    _o2Ctrl.clear();
    setState(() {
      _selectedPlace = null;
      _predictions = [];
    });
  }

  Future<void> _delete(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardBg,
        title: const Text('Sil', style: AppTextStyles.h2),
        content: const Text('Bu noktayı silmek istediğine emin misin?',
            style: AppTextStyles.body),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('İptal')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text('Sil',
                  style: TextStyle(color: AppColors.ringDanger))),
        ],
      ),
    );
    if (confirm != true) return;

    try {
      await Supabase.instance.client
          .from('ganimet_noktalari')
          .delete()
          .eq('id', id);
      HapticService.medium();
      _loadExisting();
    } catch (e) {
      _showSnack('Silme hatası: $e', isError: true);
    }
  }

  void _showSnack(String msg, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: isError ? AppColors.ringDanger : AppColors.neonGreen,
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Ganimet Noktası Ekle', style: AppTextStyles.h1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.textSecondary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: PremiumBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search
              _buildSearchField(),
              if (_predictions.isNotEmpty) _buildPredictionList(),
              if (_selectedPlace != null) ...[
                const SizedBox(height: 16),
                _buildPlacePreview(_selectedPlace!),
                const SizedBox(height: 16),
                _buildFormFields(),
                const SizedBox(height: 16),
                _buildSaveButton(),
              ],
              const SizedBox(height: 32),
              const Text('Mevcut Noktalar', style: AppTextStyles.h2),
              const SizedBox(height: 12),
              ..._existingItems.map(_buildExistingItem),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchCtrl,
      onChanged: _onSearchChanged,
      style: AppTextStyles.body,
      decoration: InputDecoration(
        hintText: 'Mekan ara...',
        hintStyle: AppTextStyles.bodySecondary,
        prefixIcon:
            const Icon(Icons.search_rounded, color: AppColors.textTertiary),
        filled: true,
        fillColor: AppColors.cardBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.neonGreen),
        ),
      ),
    );
  }

  Widget _buildPredictionList() {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      constraints: const BoxConstraints(maxHeight: 200),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: _predictions.length,
        separatorBuilder: (_, __) =>
            const Divider(color: AppColors.cardBorder, height: 1),
        itemBuilder: (_, i) {
          final p = _predictions[i];
          return ListTile(
            dense: true,
            title: Text(p.mainText, style: AppTextStyles.h3),
            subtitle: Text(p.description,
                style: AppTextStyles.labelSmall, maxLines: 1,
                overflow: TextOverflow.ellipsis),
            onTap: () => _onPredictionTap(p),
          );
        },
      ),
    );
  }

  Widget _buildPlacePreview(PlaceDetails place) {
    return GlassmorphicCard(
      glowColor: AppColors.neonGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (place.photoUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                place.photoUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 200,
                  color: AppColors.surface,
                  child: const Center(
                      child: Icon(Icons.image_not_supported_rounded,
                          color: AppColors.textTertiary, size: 40)),
                ),
              ),
            ),
          const SizedBox(height: 12),
          Text(place.name,
              style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(place.address, style: AppTextStyles.bodySecondary),
          const SizedBox(height: 4),
          Text('${place.lat.toStringAsFixed(5)}, ${place.lng.toStringAsFixed(5)}',
              style: AppTextStyles.labelSmall),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        TextField(
          controller: _odulCtrl,
          style: AppTextStyles.body,
          decoration: _inputDeco('Ödül Başlığı (ör: Bedava Kahve)'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _o2Ctrl,
          style: AppTextStyles.body,
          keyboardType: TextInputType.number,
          decoration: _inputDeco('O\u2082 Maliyeti'),
        ),
      ],
    );
  }

  InputDecoration _inputDeco(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.bodySecondary,
        filled: true,
        fillColor: AppColors.cardBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.neonGreen),
        ),
      );

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: _saving ? null : _save,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: _saving ? AppColors.textTertiary : AppColors.neonGreen,
          borderRadius: BorderRadius.circular(14),
          boxShadow: _saving
              ? null
              : [
                  BoxShadow(
                      color: AppColors.neonGreen.withValues(alpha: 0.3),
                      blurRadius: 12)
                ],
        ),
        child: Center(
          child: _saving
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2))
              : const Text('Kaydet',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
        ),
      ),
    );
  }

  Widget _buildExistingItem(Map<String, dynamic> item) {
    final photoUrl = item['photo_url'] as String?;
    final name = item['mekan_adi'] as String? ?? '';
    final o2 = item['o2_maliyet'] as int? ?? 0;
    final id = item['id'] as String;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassmorphicCard(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: photoUrl != null
                  ? Image.network(photoUrl,
                      width: 48, height: 48, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _placeholderThumb())
                  : _placeholderThumb(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTextStyles.h3, maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  Text('$o2 O\u2082', style: AppTextStyles.label),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded,
                  color: AppColors.ringDanger, size: 22),
              onPressed: () => _delete(id),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholderThumb() => Container(
        width: 48,
        height: 48,
        color: AppColors.surface,
        child: const Icon(Icons.place_rounded,
            color: AppColors.textTertiary, size: 24),
      );
}
