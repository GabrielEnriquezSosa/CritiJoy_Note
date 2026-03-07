import 'dart:io';
import 'package:critijoy_note/features/auth/presentation/providers/auth_provider.dart';
import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  ConsumerState<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  bool _isPasswordSectionOpen = false;
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _isLoading = false;
  String? _successMessage;
  String? _errorMessage;
  String? _pickedImagePath;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authStateProvider);
    _usernameController = TextEditingController(text: user?.name ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _pickedImagePath =
        (user?.photoUrl != null && user!.photoUrl.isNotEmpty)
            ? user.photoUrl
            : null;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
    );
    if (picked != null) {
      setState(() {
        _pickedImagePath = picked.path;
      });
    }
  }

  Future<void> _handleSave() async {
    final currentPw = _currentPasswordController.text.trim();
    final newPw = _newPasswordController.text.trim();

    // Validate password fields only when the section is open and partially filled
    if (_isPasswordSectionOpen && (currentPw.isNotEmpty || newPw.isNotEmpty)) {
      if (currentPw.isEmpty) {
        setState(() => _errorMessage = 'Ingresa tu contraseña actual.');
        return;
      }
      if (newPw.isEmpty) {
        setState(() => _errorMessage = 'Ingresa la nueva contraseña.');
        return;
      }
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final user = ref.read(authStateProvider);
      if (user == null) throw Exception('No hay sesión activa.');

      final repo = ref.read(authRepositoryProvider);

      // 1. Update name / email / photo
      final updatedUser = user.copyWith(
        name: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        photoUrl: _pickedImagePath ?? '',
      );
      await repo.updateProfile(updatedUser);
      ref.read(authStateProvider.notifier).setUser(updatedUser);

      // 2. Change password if both fields are provided
      if (_isPasswordSectionOpen && currentPw.isNotEmpty && newPw.isNotEmpty) {
        await repo.changePassword(user.id, currentPw, newPw);
        // Clear fields after success
        _currentPasswordController.clear();
        _newPasswordController.clear();
        setState(() => _isPasswordSectionOpen = false);
      }

      setState(() {
        _successMessage = 'Perfil actualizado correctamente.';
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _successMessage = null);
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    final bgColor =
        isDarkMode ? const Color(0xFF0F1522) : const Color(0xFFF5F7FA);
    final textColor = isDarkMode ? Colors.white : const Color(0xFF1B2230);
    final subtitleColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];
    final inputFillColor =
        isDarkMode ? const Color(0xFF1F2937) : Colors.grey.shade100;
    final inputBorderColor =
        isDarkMode ? const Color(0xFF374151) : Colors.grey.shade300;
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
          'Editar Perfil',
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // --- Avatar with edit badge ---
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  isDarkMode
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade800,
                            ),
                            child: ClipOval(child: _buildAvatarContent()),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: accentColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: bgColor, width: 2),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Text(
                      'Actualizar Foto',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // --- Messages ---
            if (_successMessage != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _successMessage!,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (_errorMessage != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // --- Username ---
            _FieldLabel(label: 'Nombre de Usuario', color: subtitleColor),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _usernameController,
              hint: 'Tu nombre de usuario',
              icon: Icons.person_outline,
              textColor: textColor,
              subtitleColor: subtitleColor,
              fillColor: inputFillColor,
              borderColor: inputBorderColor,
            ),

            const SizedBox(height: 20),

            // --- Email ---
            _FieldLabel(label: 'Correo Electrónico', color: subtitleColor),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _emailController,
              hint: 'correo@ejemplo.com',
              icon: Icons.email_outlined,
              textColor: textColor,
              subtitleColor: subtitleColor,
              fillColor: inputFillColor,
              borderColor: inputBorderColor,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 28),

            // --- Change Password (collapsible) ---
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                setState(
                  () => _isPasswordSectionOpen = !_isPasswordSectionOpen,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cambiar Contraseña',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    _isPasswordSectionOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: subtitleColor,
                  ),
                ],
              ),
            ),

            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FieldLabel(
                      label: 'Contraseña Actual',
                      color: subtitleColor,
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _currentPasswordController,
                      hint: '••••••••',
                      icon: Icons.lock_outline,
                      textColor: textColor,
                      subtitleColor: subtitleColor,
                      fillColor: inputFillColor,
                      borderColor: inputBorderColor,
                      obscureText: _obscureCurrentPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureCurrentPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: subtitleColor,
                          size: 20,
                        ),
                        onPressed:
                            () => setState(
                              () =>
                                  _obscureCurrentPassword =
                                      !_obscureCurrentPassword,
                            ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _FieldLabel(
                      label: 'Nueva Contraseña',
                      color: subtitleColor,
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _newPasswordController,
                      hint: 'Ingresa nueva contraseña',
                      icon: Icons.lock_outline,
                      textColor: textColor,
                      subtitleColor: subtitleColor,
                      fillColor: inputFillColor,
                      borderColor: inputBorderColor,
                      obscureText: _obscureNewPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureNewPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: subtitleColor,
                          size: 20,
                        ),
                        onPressed:
                            () => setState(
                              () => _obscureNewPassword = !_obscureNewPassword,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState:
                  _isPasswordSectionOpen
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 250),
            ),

            const SizedBox(height: 40),

            // --- Save Button ---
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child:
                    _isLoading
                        ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                        : const Text(
                          'Guardar Cambios',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// Builds the avatar content: user image if available, otherwise default icon.
  Widget _buildAvatarContent() {
    if (_pickedImagePath != null && _pickedImagePath!.isNotEmpty) {
      final file = File(_pickedImagePath!);
      if (file.existsSync()) {
        return Image.file(file, fit: BoxFit.cover, width: 120, height: 120);
      }
    }
    // Default user icon
    return const Center(
      child: Icon(Icons.person, size: 56, color: Colors.white),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required Color textColor,
    required Color? subtitleColor,
    required Color fillColor,
    required Color borderColor,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    const accentColor = Color(0xFF3B82F6);
    return TextField(
      controller: controller,
      style: TextStyle(color: textColor, fontSize: 15),
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: subtitleColor),
        filled: true,
        fillColor: fillColor,
        prefixIcon: Icon(icon, color: subtitleColor, size: 20),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentColor, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  final Color? color;

  const _FieldLabel({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
