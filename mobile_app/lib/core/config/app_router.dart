import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_app/features/auth/presentation/pages/splash_page.dart';
import 'package:mobile_app/features/auth/presentation/pages/login_page.dart';
import 'package:mobile_app/features/auth/presentation/pages/client_register_page.dart';
import 'package:mobile_app/features/auth/presentation/pages/role_selection_page.dart';
import 'package:mobile_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobile_app/features/livraison/presentation/pages/client_home_page.dart';
import 'package:mobile_app/features/livraison/presentation/pages/livraison_list_page.dart';
import 'package:mobile_app/features/livraison/presentation/pages/livraison_detail_page.dart';
import 'package:mobile_app/features/livreur/presentation/pages/missions_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: RouterNotifier(ref),
    redirect: (context, state) async {
      final authState = ref.read(authProvider);
      final isAuthenticated = authState.isAuthenticated;
      final loc = state.matchedLocation;
      final prefs = await SharedPreferences.getInstance();
      final selectedRole = prefs.getString('selected_role');
      final isAuth = loc == '/auth/login' || loc == '/auth/register' || loc == '/splash' || loc == '/auth/role';

      if (selectedRole == null && loc != '/auth/role' && loc != '/splash') return '/auth/role';
      if (!isAuthenticated && !isAuth) return '/auth/login';
      if (isAuthenticated && isAuth) return _homeForRole(authState.user?.role);
      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashPage()),
      GoRoute(path: '/auth/role', builder: (_, __) => const RoleSelectionPage()),
      GoRoute(path: '/auth/login', builder: (_, __) => const LoginPage()),
      GoRoute(path: '/auth/register', builder: (_, __) => const ClientRegisterPage()),
      GoRoute(path: '/home', builder: (_, __) => const ClientHomePage()),
      GoRoute(path: '/mes-livraisons', builder: (_, __) => const LivraisonsListPage()),
      GoRoute(path: '/livraison/:id', builder: (_, s) => LivraisonDetailPage(id: s.pathParameters['id']!)),
      GoRoute(path: '/livreur/dashboard', builder: (_, __) => const MissionsPage()),
    ],
  );
});

String _homeForRole(String? role) => switch (role) {
  'Client' => '/home',
  'Livreur' => '/livreur/dashboard',
  _ => '/auth/login',
};

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  RouterNotifier(this._ref) {
    _ref.listen(authProvider, (_, __) => notifyListeners());
  }
}
