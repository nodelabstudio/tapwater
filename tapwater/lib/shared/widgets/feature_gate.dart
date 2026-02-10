import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tapwater/core/providers/purchase_providers.dart';

class FeatureGate extends ConsumerWidget {
  final bool Function(PurchaseTierCheck) check;
  final Widget child;
  final Widget? lockedChild;

  const FeatureGate({
    super.key,
    required this.check,
    required this.child,
    this.lockedChild,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(purchaseProvider);
    final allowed = check(PurchaseTierCheck(state.tier));
    if (allowed) return child;
    return lockedChild ??
        GestureDetector(
          onTap: () => context.push('/paywall'),
          child: Opacity(opacity: 0.5, child: AbsorbPointer(child: child)),
        );
  }
}

class PurchaseTierCheck {
  final dynamic tier;
  PurchaseTierCheck(this.tier);
}

void showPaywallIfNeeded(BuildContext context, WidgetRef ref, bool allowed) {
  if (!allowed) {
    context.push('/paywall');
  }
}
