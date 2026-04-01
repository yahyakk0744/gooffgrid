import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gooffgrid/models/season_task.dart';

class SeasonState {
  final String name;
  final List<SeasonTask> tasks;

  const SeasonState({required this.name, required this.tasks});
}

const _mockTasks = [
  SeasonTask(id: 's1', description: '7 gun ust uste hedefi tut', target: 7, current: 5, isCompleted: false, isPremium: false),
  SeasonTask(id: 's2', description: '3 duello kazan', target: 3, current: 2, isCompleted: false, isPremium: false),
  SeasonTask(id: 's3', description: 'Toplam 500 puan topla', target: 500, current: 500, isCompleted: true, isPremium: false),
  SeasonTask(id: 's4', description: 'Bir gruba katil', target: 1, current: 1, isCompleted: true, isPremium: false),
  SeasonTask(id: 's5', description: '5 arkadasa reaksiyon gonder', target: 5, current: 3, isCompleted: false, isPremium: false),
  SeasonTask(id: 's6', description: 'Gunluk 1 saat altinda kal (3 gun)', target: 3, current: 1, isCompleted: false, isPremium: true),
  SeasonTask(id: 's7', description: 'Sehrinde Top 10 a gir', target: 1, current: 0, isCompleted: false, isPremium: true),
  SeasonTask(id: 's8', description: 'Haftalik karne notu A al', target: 1, current: 0, isCompleted: false, isPremium: true),
];

class SeasonNotifier extends StateNotifier<SeasonState> {
  SeasonNotifier()
      : super(const SeasonState(
          name: 'Sezon 1: Bahar Uyanisi',
          tasks: _mockTasks,
        ));
}

final seasonProvider = StateNotifierProvider<SeasonNotifier, SeasonState>(
  (ref) => SeasonNotifier(),
);
