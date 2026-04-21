import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/features/auth/presentation/pages/splash_page.dart';
import 'package:web_app/features/auth/presentation/pages/web_login_page.dart';
import 'package:web_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:web_app/features/point_illico/presentation/pages/point_colis_page.dart';
import 'package:web_app/features/admin/presentation/widgets/admin_shell.dart';
import 'package:web_app/features/admin/presentation/pages/admin_dashboard_page.dart';
import 'package:web_app/features/admin/presentation/pages/admin_livreurs_page.dart';
import 'package:web_app/features/admin/presentation/pages/admin_livraisons_page.dart';
import 'package:web_app/features/admin/presentation/pages/admin_points_page.dart';
import 'package:web_app/features/admin/presentation/pages/admin_colis_page.dart';
import 'package:web_app/features/admin/presentation/pages/admin_zones_page.dart';
import 'package:web_app/features/admin/presentation/pages/admin_tarifs_page.dart';
import 'package:web_app/features/admin/presentation/pages/admin_transactions_page.dart';
import 'package:web_app/features/admin/presentation/pages/admin_forfaits_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: RouterNotifier(ref),
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isAuthenticated = authState.isAuthenticated;
      final loc = state.matchedLocation;
      final isAuth = loc == '/auth/login' || loc == '/splash';
      if (!isAuthenticated && !isAuth) return '/auth/login';
      if (isAuthenticated && isAuth) return _homeForRole(authState.user?.role);
      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashPage()),
      GoRoute(path: '/auth/login', builder: (_, __) => const WebLoginPage()),
      GoRoute(path: '/point/dashboard', builder: (_, __) => const PointColisPage()),
      ShellRoute(
        builder: (c, s, child) => AdminShell(child: child),
        routes: [
          GoRoute(path: '/admin/dashboard', builder: (_, __) => const AdminDashboardPage()),
          GoRoute(path: '/admin/livraisons', builder: (_, __) => const AdminLivraisonsPage()),
          GoRoute(path: '/admin/livreurs', builder: (_, __) => const AdminLivreursPage()),
          GoRoute(path: '/admin/points', builder: (_, __) => const AdminPointsPage()),
          GoRoute(path: '/admin/colis', builder: (_, __) => const AdminColisPage()),
          GoRoute(path: '/admin/vehicules', builder: (_, __) => const AdminVehiculesPage()),
          GoRoute(path: '/admin/zones', builder: (_, __) => const AdminZonesPage()),
          GoRoute(path: '/admin/tarifs', builder: (_, __) => const AdminTarifsPage()),
          GoRoute(path: '/admin/transactions', builder: (_, __) => const AdminTransactionsPage()),
          GoRoute(path: '/admin/forfaits', builder: (_, __) => const AdminForfaitsPage()),
        ],
      ),
    ],
  );
});

String _homeForRole(String? role) => switch (role) {
  'Admin' => '/admin/dashboard',
  'PointIllico' => '/point/dashboard',
  _ => '/auth/login',
};

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  RouterNotifier(this._ref) {
    _ref.listen(authProvider, (_, __) => notifyListeners());
  }
}
