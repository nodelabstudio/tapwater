import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:tapwater/core/models/enums.dart';
import 'package:tapwater/core/providers/purchase_providers.dart';
import 'package:tapwater/core/services/purchase_service.dart';
import 'widgets/tier_card.dart';

class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  List<Package> _packages = [];

  @override
  void initState() {
    super.initState();
    _loadOfferings();
  }

  Future<void> _loadOfferings() async {
    final packages = await PurchaseService().getOfferings();
    if (mounted) setState(() => _packages = packages);
  }

  Package? _findPackage(String identifier) {
    try {
      return _packages.firstWhere((p) => p.identifier == identifier);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final purchaseState = ref.watch(purchaseProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Upgrade')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Unlock More Features',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'No subscriptions for Pro. Pay once, keep forever.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TierCard(
              title: 'Pro',
              price: '\$4.99',
              priceSubtitle: 'One-time purchase',
              isActive: purchaseState.tier == PurchaseTier.pro ||
                  purchaseState.tier == PurchaseTier.insights,
              isLoading: purchaseState.isLoading,
              onPurchase: () => _purchasePro(),
              features: const [
                'Multi-beverage tracking',
                'Custom drink types',
                'Edit & delete entries',
                'Backdate entries',
                'Full history access',
                'Shift worker day boundary',
                'Home screen widgets',
              ],
            ),
            const SizedBox(height: 16),
            TierCard(
              title: 'Insights',
              price: '\$1.99/mo',
              priceSubtitle: purchaseState.tier == PurchaseTier.free
                  ? 'Requires Pro — purchase Pro first'
                  : 'Includes all Pro features',
              isActive: purchaseState.tier == PurchaseTier.insights,
              isLoading: purchaseState.isLoading,
              isDisabled: purchaseState.tier == PurchaseTier.free,
              onPurchase: () => _purchaseInsights(),
              features: const [
                'Everything in Pro',
                'Trend analytics & charts',
                'Daily tags & notes',
                'CSV export',
                'HealthKit sync',
                'Custom themes',
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('No thanks, continue with Free'),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () => ref.read(purchaseProvider.notifier).restore(),
                child: const Text('Restore Purchases'),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Future<void> _purchasePro() async {
    // Try RevenueCat identifiers: \$rc_lifetime, pro_lifetime, or pro
    final package = _findPackage('\$rc_lifetime') ??
        _findPackage('pro_lifetime') ??
        _findPackage('pro');
    if (package == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Purchase not available. Please try again later.')),
        );
      }
      return;
    }
    await ref.read(purchaseProvider.notifier).purchase(package);
  }

  Future<void> _purchaseInsights() async {
    final tier = ref.read(purchaseProvider).tier;
    if (tier == PurchaseTier.free) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please purchase Pro first before subscribing to Insights.'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
    final package = _findPackage('\$rc_monthly') ??
        _findPackage('insights_monthly') ??
        _findPackage('insights');
    if (package == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Subscription not available. Please try again later.')),
        );
      }
      return;
    }
    await ref.read(purchaseProvider.notifier).purchase(package);
  }
}
