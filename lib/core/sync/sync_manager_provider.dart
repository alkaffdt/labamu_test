import 'dart:async';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:labamu_test/core/configs/app_config.dart';
import 'package:labamu_test/features/product/presentation/providers/product_pagination_controller_provider.dart';
import 'package:labamu_test/features/product/presentation/providers/product_provider.dart';
import '../../features/product/domain/repositories/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/product/domain/repositories/product_repository.dart';

// <-- sesuaikan path repo provider kamu

final syncManagerProvider = Provider<SyncManager>((ref) {
  final repo = ref.watch(productRepositoryProvider);

  final manager = SyncManager(
    productRepository: repo,
    onSyncComplete: () {
      Future.delayed(
        const Duration(seconds: AppConfig.staticDelayInSeconds),
        () {
          // ref.read(productsPagingControllerProvider).refresh();
        },
      );
    },
  );

  ref.onDispose(() {
    manager.dispose();
  });

  return manager;
});

class SyncManager {
  final ProductRepository productRepository;
  final Connectivity connectivity;
  final VoidCallback? onSyncComplete;

  StreamSubscription? _connectivitySub;
  bool _isSyncing = false;

  SyncManager({
    required this.productRepository,
    Connectivity? connectivity,
    this.onSyncComplete,
  }) : connectivity = connectivity ?? Connectivity();

  /// Call once when app starts
  Future<void> init() async {
    // Sync immediately on start
    await _trySync();

    // Listen connectivity changes
    _connectivitySub = connectivity.onConnectivityChanged.listen((
      result,
    ) async {
      if (result.first != ConnectivityResult.none) {
        await _trySync();
        onSyncComplete?.call();
      }
    });
  }

  Future<void> dispose() async {
    await _connectivitySub?.cancel();
  }

  Future<void> _trySync() async {
    /// no duplicate runs
    if (_isSyncing) return;

    final result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) return;

    _isSyncing = true;

    try {
      await productRepository.syncPendingProducts();
    } catch (e) {
      // log error
    }

    _isSyncing = false;
  }

  /// Optional: manual sync trigger
  Future<void> manualSync() => _trySync();
}
