import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared/core/config/app_theme.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});
  Future<void> _selectRole(BuildContext context, String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_role', role);
    if (context.mounted) Navigator.of(context).pushReplacementNamed('/auth/login');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Bienvenue sur ILLICO', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.secondary), textAlign: TextAlign.center),
              const SizedBox(height: 12),
              const Text('Choisissez votre profil pour continuer', style: TextStyle(fontSize: 16, color: AppColors.textSecondary), textAlign: TextAlign.center),
              const SizedBox(height: 48),
              _RoleButton(title: 'Client', subtitle: 'Je souhaite envoyer ou recevoir un colis', icon: Icons.inventory_2_outlined, onPressed: () => _selectRole(context, 'Client')),
              const SizedBox(height: 20),
              _RoleButton(title: 'Livreur', subtitle: 'Je souhaite effectuer des livraisons', icon: Icons.two_wheeler_rounded, onPressed: () => _selectRole(context, 'Livreur')),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final VoidCallback onPressed;
  const _RoleButton({required this.title, required this.subtitle, required this.icon, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(border: Border.all(color: AppColors.divider), borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle), child: Icon(icon, color: AppColors.primary, size: 32)),
            const SizedBox(width: 20),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              Text(subtitle, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            ])),
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.divider),
          ],
        ),
      ),
    );
  }
}
