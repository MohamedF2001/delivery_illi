import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared/core/api/api_client.dart';
import 'package:shared/core/errors/failures.dart';
import 'package:shared/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:shared/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:shared/features/auth/domain/entities/user_entity.dart';
import 'package:shared/features/auth/domain/usecases/login_usecase.dart';

class AuthState {
  final UserEntity? user;
  final String? token;
  final String? role;
  final bool isLoading;
  final Failure? error;

  const AuthState({
    this.user,
    this.token,
    this.role,
    this.isLoading = false,
    this.error,
  });

  bool get isAuthenticated => token != null && user != null;

  AuthState copyWith({
    UserEntity? user,
    String? token,
    String? role,
    bool? isLoading,
    Failure? error,
    bool clearAll = false,
  }) => AuthState(
    user: clearAll ? null : (user ?? this.user),
    token: clearAll ? null : (token ?? this.token),
    role: clearAll ? null : (role ?? this.role),
    isLoading: isLoading ?? this.isLoading,
    error: error,
  );
}

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase _login;
  final AuthRepositoryImpl _repo;
  final _storage = const FlutterSecureStorage();

  AuthNotifier(this._login, this._repo) : super(const AuthState()) {
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    state = state.copyWith(isLoading: true);
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('selected_role');
    final token = await _storage.read(key: 'token');

    if (token == null) {
      state = state.copyWith(isLoading: false, role: role);
      return;
    }

    final result = await _repo.getProfile();
    result.fold(
      (f) async {
        await _storage.delete(key: 'token');
        state = AuthState(role: role);
      },
      (user) => state = state.copyWith(isLoading: false, user: user, token: token, role: role ?? user.role),
    );
  }

  Future<bool> login({
    required String role,
    String? email,
    String? telephone,
    String? motDePasse,
    String? codePin,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _login.execute(
      role: role,
      email: email,
      telephone: telephone,
      motDePasse: motDePasse,
      codePin: codePin,
    );

    return await result.fold(
      (f) async {
        state = state.copyWith(isLoading: false, error: f);
        return false;
      },
      (data) async {
        final token = data['token'] as String;
        await _storage.write(key: 'token', value: token);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('selected_role', role);

        final userResult = await _repo.getProfile();
        return userResult.fold(
          (f) {
            state = state.copyWith(isLoading: false, error: f);
            return false;
          },
          (u) {
            state = state.copyWith(isLoading: false, user: u, token: token, role: role);
            return true;
          },
        );
      },
    );
  }

  Future<void> logout() async {
    await _storage.delete(key: 'token');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('selected_role');
    state = const AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repo = AuthRepositoryImpl(AuthRemoteDataSource(apiClient));
  return AuthNotifier(LoginUseCase(repo), repo);
});
