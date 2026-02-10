import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:tapwater/core/database/app_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tapwater/config/theme/app_colors.dart';
import 'package:tapwater/core/models/enums.dart';
import 'package:tapwater/core/providers/database_provider.dart';
import 'package:tapwater/core/services/notification_service.dart';
import 'package:tapwater/core/services/preferences_service.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  // User choices
  int _goalMl = 2000;
  UnitSystem _unitSystem = UnitSystem.metric;
  bool _enableReminders = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress dots
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (i) {
                  return Container(
                    width: _currentPage == i ? 24 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: _currentPage == i
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _UnitStep(
                    unitSystem: _unitSystem,
                    onChanged: (v) => setState(() => _unitSystem = v),
                  ),
                  _GoalStep(
                    goalMl: _goalMl,
                    unitSystem: _unitSystem,
                    onChanged: (v) => setState(() => _goalMl = v),
                  ),
                  _ReminderStep(
                    enabled: _enableReminders,
                    onChanged: (v) => setState(() => _enableReminders = v),
                  ),
                  const _WelcomeStep(),
                ],
              ),
            ),
            // Navigation
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    TextButton(
                      onPressed: _goBack,
                      style: TextButton.styleFrom(
                        minimumSize: const Size(0, 48),
                      ),
                      child: const Text('Back'),
                    ),
                  const Spacer(),
                  FilledButton(
                    onPressed: _currentPage == 3 ? _complete : _goNext,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(120, 48),
                    ),
                    child: Text(_currentPage == 3 ? 'Get Started' : 'Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goNext() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goBack() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _complete() async {
    final db = ref.read(databaseProvider);

    // Save goal
    await db.dailyGoalDao.setGoal(_goalMl);

    // Save unit system
    await db.userSettingsDao.updateSettings(UserSettingsCompanion(
      unitSystem: drift.Value(_unitSystem == UnitSystem.imperial ? 'imperial' : 'metric'),
      remindersEnabled: drift.Value(_enableReminders),
    ));

    // Set up reminders
    if (_enableReminders) {
      final notif = NotificationService();
      await notif.requestPermission();
      await notif.scheduleReminders(
        startHour: 8,
        endHour: 22,
        intervalMinutes: 120,
      );
    }

    // Mark onboarding complete
    final prefs = ref.read(sharedPreferencesProvider);
    await setOnboardingComplete(prefs);
    ref.invalidate(onboardingCompleteProvider);

    if (mounted) context.go('/today');
  }
}

class _GoalStep extends StatelessWidget {
  final int goalMl;
  final UnitSystem unitSystem;
  final ValueChanged<int> onChanged;
  const _GoalStep({required this.goalMl, required this.unitSystem, required this.onChanged});

  static const double _mlPerOz = 29.5735;

  @override
  Widget build(BuildContext context) {
    final isOz = unitSystem == UnitSystem.imperial;
    // Display value in user's unit
    final displayValue = isOz ? (goalMl / _mlPerOz).round() : goalMl;
    final unitLabel = isOz ? 'oz' : 'ml';
    final sliderMin = isOz ? 34.0 : 1000.0;
    final sliderMax = isOz ? 170.0 : 5000.0;
    final divisions = isOz ? 136 : 40;
    final presets = isOz ? [50, 68, 85, 100] : [1500, 2000, 2500, 3000];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.water_drop, size: 64, color: AppColors.primary),
          const SizedBox(height: 24),
          Text('Set Your Daily Goal',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'How much water do you want to drink each day?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          Text(
            '$displayValue $unitLabel',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
          ),
          const SizedBox(height: 16),
          Slider(
            value: displayValue.toDouble().clamp(sliderMin, sliderMax),
            min: sliderMin,
            max: sliderMax,
            divisions: divisions,
            label: '$displayValue $unitLabel',
            onChanged: (v) {
              final ml = isOz ? (v * _mlPerOz).round() : v.round();
              onChanged(ml);
            },
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: presets.map((preset) {
              final presetMl = isOz ? (preset * _mlPerOz).round() : preset;
              // Match against display value for selection
              return ChoiceChip(
                label: Text('$preset $unitLabel'),
                selected: displayValue == preset,
                onSelected: (_) => onChanged(presetMl),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _UnitStep extends StatelessWidget {
  final UnitSystem unitSystem;
  final ValueChanged<UnitSystem> onChanged;
  const _UnitStep({required this.unitSystem, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.straighten, size: 64, color: AppColors.primary),
          const SizedBox(height: 24),
          Text('Choose Your Units',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 32),
          ...UnitSystem.values.map((u) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ChoiceChip(
                label: Text(u.label),
                selected: unitSystem == u,
                onSelected: (_) => onChanged(u),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ReminderStep extends StatelessWidget {
  final bool enabled;
  final ValueChanged<bool> onChanged;
  const _ReminderStep({required this.enabled, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.notifications_outlined,
              size: 64, color: AppColors.primary),
          const SizedBox(height: 24),
          Text('Stay Hydrated',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Would you like reminders to drink water?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          SwitchListTile(
            title: const Text('Enable Reminders'),
            subtitle: const Text('Every 2 hours, 8 AM - 10 PM'),
            value: enabled,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _WelcomeStep extends StatelessWidget {
  const _WelcomeStep();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('\u{1F4A7}', style: TextStyle(fontSize: 80)),
          const SizedBox(height: 24),
          Text("You're all set!",
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text(
            'TapWater is ready to help you stay hydrated. '
            'Tap the big blue button to log water with one tap.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
