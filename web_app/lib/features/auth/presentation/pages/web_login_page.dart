import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/core/config/app_theme.dart';
import 'package:shared/core/widgets/loading_button.dart';
import 'package:web_app/features/auth/presentation/providers/auth_provider.dart';

class WebLoginPage extends ConsumerStatefulWidget {
  const WebLoginPage({super.key});
  @override
  ConsumerState<WebLoginPage> createState() => _WebLoginPageState();
}

class _WebLoginPageState extends ConsumerState<WebLoginPage> {
  final _adminEmailCtrl = TextEditingController();
  final _adminPassCtrl = TextEditingController();
  final _pointTelCtrl = TextEditingController();
  final _pointPassCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Espace Administrateur', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                  const SizedBox(height: 32),
                  TextField(controller: _adminEmailCtrl, decoration: const InputDecoration(labelText: 'Email')),
                  const SizedBox(height: 16),
                  TextField(controller: _adminPassCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'Mot de passe')),
                  const SizedBox(height: 32),
                  LoadingButton(
                    label: 'Se connecter en tant qu\'Admin',
                    onPressed: () => ref.read(authProvider.notifier).login(role: 'Admin', email: _adminEmailCtrl.text, motDePasse: _adminPassCtrl.text),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: Container(
              color: AppColors.secondary.withOpacity(0.02),
              padding: const EdgeInsets.all(48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Espace Point ILLICO', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  const SizedBox(height: 32),
                  TextField(controller: _pointTelCtrl, decoration: const InputDecoration(labelText: 'Téléphone')),
                  const SizedBox(height: 16),
                  TextField(controller: _pointPassCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'Mot de passe')),
                  const SizedBox(height: 32),
                  LoadingButton(
                    label: 'Se connecter en tant que Point',
                    onPressed: () => ref.read(authProvider.notifier).login(role: 'PointIllico', telephone: _pointTelCtrl.text, motDePasse: _pointPassCtrl.text),
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
