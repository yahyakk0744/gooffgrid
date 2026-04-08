import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SubscriptionTier { free, pro }

class SubscriptionState {
  const SubscriptionState({
    this.tier = SubscriptionTier.free,
    this.familyMembers = const [],
    this.selectedTheme = 'default',
  });

  final SubscriptionTier tier;
  final List<String> familyMembers;
  final String selectedTheme;

  bool get isPro => tier == SubscriptionTier.pro;
  bool get isProPlus => tier == SubscriptionTier.pro; // Geriye uyumluluk
  bool get isFree => tier == SubscriptionTier.free;

  // Feature gates — tüm Pro+ özellikleri artık Pro'ya dahil
  int get maxActiveduels => isFree ? 3 : 999;
  int get maxBreathTechniques => isFree ? 2 : 6;
  bool get canUsePhotoStories => isPro;
  bool get canViewDetailedAnalytics => isPro;
  bool get canViewHeatmap => isPro;
  bool get canViewTopReports => isPro;
  bool get canUnlockBadges => isPro;
  bool get showAds => false; // Reklam yok
  bool get hasFamilyPlan => isPro;
  bool get hasCustomThemes => isPro;
  bool get hasPrioritySupport => isPro;
  bool get hasBetaAccess => isPro;
  bool get hasAdvancedGoals => isPro;
  bool get hasFamilyRanking => isPro;
  bool get hasFamilyReport => isPro;

  SubscriptionState copyWith({
    SubscriptionTier? tier,
    List<String>? familyMembers,
    String? selectedTheme,
  }) {
    return SubscriptionState(
      tier: tier ?? this.tier,
      familyMembers: familyMembers ?? this.familyMembers,
      selectedTheme: selectedTheme ?? this.selectedTheme,
    );
  }
}

class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  /// RevenueCat entegre edilene kadar tüm özellikler açık.
  /// RevenueCat eklendiğinde `SubscriptionTier.free` olarak değiştirilecek.
  SubscriptionNotifier() : super(const SubscriptionState(tier: SubscriptionTier.pro));

  void upgrade(SubscriptionTier tier) {
    state = state.copyWith(tier: tier);
  }

  void setTheme(String theme) {
    state = state.copyWith(selectedTheme: theme);
  }

  void addFamilyMember(String name) {
    if (state.familyMembers.length >= 5) return;
    state = state.copyWith(familyMembers: [...state.familyMembers, name]);
  }

  void removeFamilyMember(String name) {
    state = state.copyWith(
      familyMembers: state.familyMembers.where((m) => m != name).toList(),
    );
  }

  // Demo: toggle between tiers for testing
  void cycleTier() {
    final next = switch (state.tier) {
      SubscriptionTier.free => SubscriptionTier.pro,
      SubscriptionTier.pro => SubscriptionTier.free,
    };
    state = state.copyWith(tier: next);
  }
}

final subscriptionProvider =
    StateNotifierProvider<SubscriptionNotifier, SubscriptionState>(
  (ref) => SubscriptionNotifier(),
);
