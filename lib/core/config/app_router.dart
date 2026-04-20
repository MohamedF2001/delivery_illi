import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../features/auth/presentation/pages/splash_page.dart';
import '../../../features/auth/presentation/pages/login_page.dart';
import '../../../features/auth/presentation/pages/client_register_page.dart';
import '../../../features/auth/presentation/providers/auth_provider.dart';
import '../../../features/livraison/presentation/pages/client_home_page.dart';
import '../../../features/livraison/presentation/pages/livraison_list_page.dart';
import '../../../features/livraison/presentation/pages/livraison_detail_page.dart';
import '../../../features/livreur/presentation/pages/missions_page.dart';
import '../../../features/point_illico/presentation/pages/point_colis_page.dart';
import '../../../features/admin/presentation/widgets/admin_shell.dart';
import '../../../features/admin/presentation/pages/admin_dashboard_page.dart';
import '../../../features/admin/presentation/pages/admin_livreurs_page.dart';
import '../../../features/admin/presentation/pages/admin_livraisons_page.dart';
import '../../../features/admin/presentation/pages/admin_points_page.dart';
import '../../../features/admin/presentation/pages/admin_colis_page.dart';
import '../../../features/admin/presentation/pages/admin_zones_page.dart';
import '../../../features/admin/presentation/pages/admin_tarifs_page.dart';
import '../../../features/admin/presentation/pages/admin_transactions_page.dart';
import '../../../features/admin/presentation/pages/admin_forfaits_page.dart';
import '../../../features/vehicule/presentation/pages/vehicule_list_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authProvider.notifier);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: RouterNotifier(ref),
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoggedIn = authState.isLoggedIn;
      final loc = state.matchedLocation;
      final isAuth =
          loc == '/auth/login' || loc == '/auth/register' || loc == '/splash';

      if (!isLoggedIn && !isAuth) return '/auth/login';
      if (isLoggedIn && (loc == '/auth/login' || loc == '/auth/register')) {
        return _homeForRole(authState.user?.role);
      }
      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashPage()),
      GoRoute(path: '/auth/login', builder: (_, __) => const LoginPage()),
      GoRoute(
        path: '/auth/register',
        builder: (_, __) => const ClientRegisterPage(),
      ),
      // ── Client ──────────────────────────────────────────────
      GoRoute(path: '/home', builder: (_, __) => const ClientHomePage()),
      GoRoute(
        path: '/mes-livraisons',
        builder: (_, __) => const LivraisonsListPage(),
      ),
      GoRoute(
        path: '/livraison/new',
        builder: (_, __) => const CreateLivraisonPlaceholderPage(),
      ),
      GoRoute(
        path: '/livraison/:id',
        builder: (_, s) => LivraisonDetailPage(id: s.pathParameters['id']!),
      ),
      GoRoute(
        path: '/colis',
        builder: (_, __) => const ColisClientPlaceholderPage(),
      ),
      GoRoute(
        path: '/forfaits',
        builder: (_, __) => const ForfaitsPlaceholderPage(),
      ),
      GoRoute(
        path: '/profil',
        builder: (_, __) => const ProfilePlaceholderPage(),
      ),
      // ── Livreur ─────────────────────────────────────────────
      GoRoute(
        path: '/livreur/missions',
        builder: (_, __) => const MissionsPage(),
      ),
      GoRoute(
        path: '/livreur/gains',
        builder: (_, __) => const GainsPlaceholderPage(),
      ),
      // ── Point ILLICO ─────────────────────────────────────────
      GoRoute(path: '/point/colis', builder: (_, __) => const PointColisPage()),
      // ── Admin Shell ──────────────────────────────────────────
      ShellRoute(
        builder: (c, s, child) => AdminShell(child: child),
        routes: [
          GoRoute(
            path: '/admin/dashboard',
            builder: (_, __) => const AdminDashboardPage(),
          ),
          GoRoute(
            path: '/admin/livraisons',
            builder: (_, __) => const AdminLivraisonsPage(),
          ),
          GoRoute(
            path: '/admin/livreurs',
            builder: (_, __) => const AdminLivreursPage(),
          ),
          GoRoute(
            path: '/admin/points',
            builder: (_, __) => const AdminPointsPage(),
          ),
          GoRoute(
            path: '/admin/colis',
            builder: (_, __) => const AdminColisPage(),
          ),
          GoRoute(
            path: '/admin/vehicules',
            builder: (_, __) => const AdminVehiculesPage(),
          ),
          GoRoute(
            path: '/admin/zones',
            builder: (_, __) => const AdminZonesPage(),
          ),
          GoRoute(
            path: '/admin/tarifs',
            builder: (_, __) => const AdminTarifsPage(),
          ),
          GoRoute(
            path: '/admin/transactions',
            builder: (_, __) => const AdminTransactionsPage(),
          ),
          GoRoute(
            path: '/admin/forfaits',
            builder: (_, __) => const AdminForfaitsPage(),
          ),
        ],
      ),
    ],
    errorBuilder: (_, state) => Scaffold(
      body: Center(
        child: Text(
          'Page introuvable: ${state.matchedLocation}',
          style: const TextStyle(color: Colors.red),
        ),
      ),
    ),
  );
});

String _homeForRole(String? role) => switch (role) {
  'Client' => '/home',
  'Livreur' => '/livreur/missions',
  'PointIllico' => '/point/colis',
  'Admin' => '/admin/dashboard',
  _ => '/auth/login',
};

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  RouterNotifier(this._ref) {
    _ref.listen(authProvider, (_, __) => notifyListeners());
  }
}

// ── Placeholder pages ────────────────────────────────────────
class _PlaceholderPage extends StatelessWidget {
  final String title;
  final IconData icon;
  const _PlaceholderPage({required this.title, required this.icon});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: const Color(0xFFFF6B00)),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'Page en cours de développement',
            style: TextStyle(color: Color(0xFF6B7280)),
          ),
        ],
      ),
    ),
  );
}

class CreateLivraisonPlaceholderPage extends StatelessWidget {
  const CreateLivraisonPlaceholderPage({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderPage(
    title: 'Nouvelle livraison',
    icon: Icons.add_location_alt_outlined,
  );
}

class ColisClientPlaceholderPage extends StatelessWidget {
  const ColisClientPlaceholderPage({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderPage(
    title: 'Mes colis',
    icon: Icons.inventory_2_outlined,
  );
}

class ForfaitsPlaceholderPage extends StatelessWidget {
  const ForfaitsPlaceholderPage({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderPage(
    title: 'Forfaits',
    icon: Icons.card_membership_outlined,
  );
}

class ProfilePlaceholderPage extends StatelessWidget {
  const ProfilePlaceholderPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const _PlaceholderPage(title: 'Mon profil', icon: Icons.person_outline);
}

class GainsPlaceholderPage extends StatelessWidget {
  const GainsPlaceholderPage({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderPage(
    title: 'Gains & Cash',
    icon: Icons.payments_outlined,
  );
}
