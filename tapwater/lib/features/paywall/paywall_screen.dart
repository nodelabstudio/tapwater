import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tapwater/core/models/enums.dart';
import 'package:tapwater/core/providers/purchase_providers.dart';
import 'widgets/tier_card.dart';

class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              onPurchase: () => _purchasePro(ref),
              features: const [
                'Multi-beverage tracking',
                'Custom drink types',
                'Edit & delete entries',
                'Backdate entries',
                'Full history access',
                'Shift worker day boundary',
                'Home screen widgets',
                'Apple Watch app',
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
              onPurchase: () => _purchaseInsights(context, ref),
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
            // No thanks button - clear and obvious
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('No thanks, continue with Free'),
              ),
            ),
            const SizedBox(height: 8),
            // Restore purchases
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

  void _purchasePro(WidgetRef ref) {
    // In production, this would fetch the package from RevenueCat offerings
    // and call purchaseService.purchase(package)
    // For now, this is a placeholder
    ref.read(purchaseProvider.notifier).refresh();
  }

  void _purchaseInsights(BuildContext context, WidgetRef ref) {
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
    ref.read(purchaseProvider.notifier).refresh();
  }
}
