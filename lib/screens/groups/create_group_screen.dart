import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../config/app_shadows.dart';
import '../../widgets/premium_background.dart';
import '../../services/haptic_service.dart';
import '../../l10n/app_localizations.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _nameController = TextEditingController();
  final _searchController = TextEditingController();
  double _targetHours = 3;
  final List<_MockFriend> _selectedFriends = [];
  String _searchQuery = '';
  bool _created = false;
  String _inviteCode = '';

  static final _allFriends = [
    _MockFriend('Zeynep', const Color(0xFFF093FB)),
    _MockFriend('Burak', const Color(0xFF4FACFE)),
    _MockFriend('Elif', const Color(0xFFA8EB12)),
    _MockFriend('Can', AppColors.neonOrange),
    _MockFriend('Selin', const Color(0xFF667EEA)),
    _MockFriend('Arda', const Color(0xFF00D4AA)),
    _MockFriend('Defne', const Color(0xFFFF6B6B)),
    _MockFriend('Mert', const Color(0xFF48C6EF)),
  ];

  List<_MockFriend> get _filteredFriends {
    if (_searchQuery.isEmpty) return _allFriends;
    return _allFriends
        .where((f) => f.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  String _generateCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final r = Random();
    return List.generate(6, (_) => chars[r.nextInt(chars.length)]).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: _created ? _buildSuccessView() : _buildFormView(),
        ),
      ),
    );
  }

  Widget _buildFormView() {
    final l = AppLocalizations.of(context)!;
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
              ),
              const SizedBox(width: 12),
              Text(l.createGroup, style: AppType.h2),
            ],
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Group name
                Text(l.groupNameLabel, style: AppType.caption),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameController,
                  style: const TextStyle(color: AppColors.textPrimary),
                  maxLength: 30,
                  decoration: InputDecoration(
                    hintText: l.groupNameHint,
                    hintStyle: const TextStyle(color: AppColors.textTertiary),
                    filled: true,
                    fillColor: AppColors.surface,
                    counterStyle: const TextStyle(color: AppColors.textTertiary),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cardBorder)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cardBorder)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.neonGreen)),
                  ),
                ),
                const SizedBox(height: 24),

                // Daily goal
                Text(l.dailyGoalHours(_targetHours.round()), style: AppType.caption),
                const SizedBox(height: 8),
                Slider(
                  value: _targetHours,
                  min: 1,
                  max: 8,
                  divisions: 7,
                  activeColor: AppColors.neonGreen,
                  inactiveColor: AppColors.cardBorder,
                  onChanged: (v) => setState(() => _targetHours = v),
                ),
                const SizedBox(height: 24),

                // Add members
                Row(
                  children: [
                    Text(l.addMember, style: AppType.caption),
                    const Spacer(),
                    if (_selectedFriends.isNotEmpty)
                      Text(
                        l.selectedCount(_selectedFriends.length),
                        style: const TextStyle(fontSize: 12, color: AppColors.neonGreen, fontWeight: FontWeight.w600),
                      ),
                  ],
                ),
                const SizedBox(height: 8),

                // Search
                TextField(
                  controller: _searchController,
                  style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: InputDecoration(
                    hintText: l.searchFriend,
                    hintStyle: const TextStyle(color: AppColors.textTertiary, fontSize: 14),
                    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textTertiary, size: 20),
                    filled: true,
                    fillColor: AppColors.surface,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cardBorder)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cardBorder)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.neonGreen)),
                  ),
                ),
                const SizedBox(height: 12),

                // Selected chips
                if (_selectedFriends.isNotEmpty) ...[
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _selectedFriends.map((f) => Chip(
                      avatar: CircleAvatar(backgroundColor: f.color, radius: 12, child: Text(f.name[0], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600))),
                      label: Text(f.name, style: const TextStyle(color: AppColors.textPrimary, fontSize: 12)),
                      deleteIcon: const Icon(Icons.close_rounded, size: 16, color: AppColors.textSecondary),
                      onDeleted: () {
                        HapticService.selection();
                        setState(() => _selectedFriends.remove(f));
                      },
                      backgroundColor: AppColors.cardBg,
                      side: const BorderSide(color: AppColors.cardBorder),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    )).toList(),
                  ),
                  const SizedBox(height: 12),
                ],

                // Friend list
                ..._filteredFriends.map((f) {
                  final isSelected = _selectedFriends.contains(f);
                  return GestureDetector(
                    onTap: () {
                      HapticService.selection();
                      setState(() {
                        if (isSelected) {
                          _selectedFriends.remove(f);
                        } else {
                          _selectedFriends.add(f);
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.neonGreen.withValues(alpha: 0.08) : AppColors.cardBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppColors.neonGreen.withValues(alpha: 0.4) : AppColors.cardBorder,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: f.color,
                            child: Text(f.name[0], style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(f.name, style: const TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w500)),
                          ),
                          Icon(
                            isSelected ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                            color: isSelected ? AppColors.neonGreen : AppColors.textTertiary,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),

        // Create button
        Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, MediaQuery.of(context).padding.bottom + 12),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: AppShadow.glow(AppColors.neonGreen),
                borderRadius: BorderRadius.circular(14),
              ),
              child: ElevatedButton(
                onPressed: _onCreate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.neonGreen,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                child: Text(l.create),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessView() {
    final l = AppLocalizations.of(context)!;
    final link = 'gooffgrid.app/g/$_inviteCode';
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Spacer(),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.neonGreen.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_rounded, color: AppColors.neonGreen, size: 40),
          ),
          const SizedBox(height: 20),
          Text(
            l.groupCreated(_nameController.text.trim()),
            style: AppType.h2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            l.invitedCount(_selectedFriends.length),
            style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),

          // Invite link card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Column(
              children: [
                Text(l.inviteLink, style: AppType.caption),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.bg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.link_rounded, color: AppColors.neonGreen, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          link,
                          style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w500),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          HapticService.medium();
                          Clipboard.setData(ClipboardData(text: link));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l.linkCopied)),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.neonGreen,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(l.copy, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _ShareButton(
                        icon: Icons.share_rounded,
                        label: l.share,
                        onTap: () => HapticService.light(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _ShareButton(
                        icon: Icons.qr_code_rounded,
                        label: l.qrCode,
                        onTap: () => HapticService.light(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),

          // Done button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonGreen,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              child: Text(l.ok),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _onCreate() {
    final l = AppLocalizations.of(context)!;
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.groupNameEmpty)),
      );
      return;
    }
    HapticService.medium();
    setState(() {
      _inviteCode = _generateCode();
      _created = true;
    });
  }
}

class _ShareButton extends StatelessWidget {
  const _ShareButton({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: AppColors.textSecondary),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _MockFriend {
  const _MockFriend(this.name, this.color);
  final String name;
  final Color color;
}
