import 'dart:io';
import 'package:critijoy_note/features/auth/presentation/providers/auth_provider.dart';
import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ConfigView extends ConsumerWidget {
  const ConfigView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final user = ref.watch(authStateProvider);
    final photoUrl = user?.photoUrl ?? '';
    final hasPhoto = photoUrl.isNotEmpty && File(photoUrl).existsSync();

    // Theme colors
    final bgColor =
        isDarkMode ? const Color(0xFF0F1522) : const Color(0xFFF5F7FA);
    final cardColor = isDarkMode ? const Color(0xFF111827) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF1B2230);
    final subtitleColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];
    final sectionLabelColor =
        isDarkMode ? const Color(0xFF3B82F6) : const Color(0xFF6B7280);
    final dividerColor =
        isDarkMode ? const Color(0xFF1F2937) : Colors.grey.shade200;
    final syncCardColor =
        isDarkMode ? const Color(0xFF1E3A5F) : const Color(0xFFEBF5FF);
    const accentColor = Color(0xFF3B82F6);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          'Configuración',
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // --- Profile Section ---
            Center(
              child: Column(
                children: [
                  // Avatar with edit badge
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: Stack(
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  isDarkMode
                                      ? accentColor.withValues(alpha: 0.5)
                                      : Colors.orange.shade300.withValues(
                                        alpha: 0.6,
                                      ),
                              width: 3,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: ClipOval(
                              child:
                                  hasPhoto
                                      ? Image.file(
                                        File(photoUrl),
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                      )
                                      : Icon(
                                        Icons.person,
                                        size: 50,
                                        color:
                                            isDarkMode
                                                ? Colors.grey.shade300
                                                : Colors.grey.shade600,
                                      ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Username
                  Text(
                    '@${user?.name ?? 'Usuario'}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Email
                  Text(
                    user?.email ?? '',
                    style: TextStyle(fontSize: 14, color: subtitleColor),
                  ),
                  const SizedBox(height: 16),

                  // Edit Profile Button
                  OutlinedButton(
                    onPressed: () => context.push('/editprofile'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: textColor,
                      side: BorderSide(color: dividerColor, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                      'Editar Perfil',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // --- APP PREFERENCES ---
            _SectionLabel(
              label: 'PREFERENCIAS DE LA APP',
              color: sectionLabelColor,
            ),
            const SizedBox(height: 12),
            _SettingsTile(
              icon: Icons.dark_mode_outlined,
              iconColor: isDarkMode ? Colors.amber : Colors.blueGrey,
              title: 'Modo Oscuro',
              textColor: textColor,
              cardColor: cardColor,
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  ref.read(isDarkModeProvider.notifier).toggleTheme(value);
                },
                activeThumbColor: accentColor,
              ),
            ),
            const SizedBox(height: 8),
            _SettingsTile(
              icon: Icons.language,
              iconColor: accentColor,
              title: 'Idioma',
              subtitle: 'Español (MX)',
              textColor: textColor,
              subtitleColor: subtitleColor,
              cardColor: cardColor,
              trailing: Icon(Icons.chevron_right, color: subtitleColor),
              onTap: () {},
            ),

            const SizedBox(height: 28),

            // --- DATA MANAGEMENT ---
            _SectionLabel(label: 'GESTIÓN DE DATOS', color: sectionLabelColor),
            const SizedBox(height: 12),

            // Sync Status Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: syncCardColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.cloud_done, color: accentColor),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Estado de Sincronización',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Todos los datos respaldados',
                          style: TextStyle(color: subtitleColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.sync, color: accentColor),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _SettingsTile(
              icon: Icons.cloud_upload_outlined,
              iconColor: accentColor,
              title: 'Sincronizar Ahora',
              textColor: textColor,
              cardColor: cardColor,
              trailing: Icon(Icons.chevron_right, color: subtitleColor),
              onTap: () {},
            ),
            const SizedBox(height: 8),
            _SettingsTile(
              icon: Icons.download_outlined,
              iconColor: accentColor,
              title: 'Exportar mis datos',
              textColor: textColor,
              cardColor: cardColor,
              trailing: Icon(Icons.chevron_right, color: subtitleColor),
              onTap: () {},
            ),

            const SizedBox(height: 28),

            // --- ACCOUNT ZONE ---
            _SectionLabel(label: 'ZONA DE CUENTA', color: sectionLabelColor),
            const SizedBox(height: 12),
            _SettingsTile(
              icon: Icons.info_outline,
              iconColor: accentColor,
              title: 'Acerca de la app',
              textColor: textColor,
              cardColor: cardColor,
              trailing: Icon(Icons.chevron_right, color: subtitleColor),
              onTap: () {
                context.push('/about');
              },
            ),
            const SizedBox(height: 8),
            _SettingsTile(
              icon: Icons.logout,
              iconColor: isDarkMode ? Colors.grey[300]! : Colors.grey[700]!,
              title: 'Cerrar Sesión',
              textColor: textColor,
              cardColor: cardColor,
              trailing: Icon(Icons.chevron_right, color: subtitleColor),
              onTap: () async {
                final signOut = ref.read(signOutUsecaseProvider);
                await signOut.execute();
                ref.read(authStateProvider.notifier).clearUser();
                if (context.mounted) {
                  context.go('/signin');
                }
              },
            ),
            const SizedBox(height: 8),
            _SettingsTile(
              icon: Icons.delete_forever,
              iconColor: Colors.red,
              title: 'Eliminar Cuenta',
              textColor: Colors.red,
              cardColor: cardColor,
              trailing: Icon(
                Icons.warning_amber_rounded,
                color: Colors.red.shade300,
              ),
              onTap: () {
                _showDeleteAccountDialog(context, ref, isDarkMode);
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog(
    BuildContext context,
    WidgetRef ref,
    bool isDarkMode,
  ) {
    final dialogBg = isDarkMode ? const Color(0xFF111827) : Colors.white;
    final dialogText = isDarkMode ? Colors.white : const Color(0xFF1B2230);

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            backgroundColor: dialogBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              '¿Eliminar cuenta?',
              style: TextStyle(color: dialogText, fontWeight: FontWeight.bold),
            ),
            content: Text(
              'Esta acción eliminará tu cuenta y todos tus datos de forma permanente. Esta acción no se puede deshacer.',
              style: TextStyle(color: dialogText.withValues(alpha: 0.7)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: dialogText.withValues(alpha: 0.6)),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(ctx).pop();
                  final signOut = ref.read(signOutUsecaseProvider);
                  await signOut.execute();
                  ref.read(authStateProvider.notifier).clearUser();
                  if (context.mounted) {
                    context.go('/signin');
                  }
                },
                child: const Text(
                  'Eliminar',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}

// --- Section label widget ---
class _SectionLabel extends StatelessWidget {
  final String label;
  final Color color;

  const _SectionLabel({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

// --- Reusable settings row tile ---
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Color textColor;
  final Color? subtitleColor;
  final Color cardColor;
  final Widget trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.textColor,
    required this.cardColor,
    required this.trailing,
    this.subtitle,
    this.subtitleColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          color: subtitleColor ?? Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}
