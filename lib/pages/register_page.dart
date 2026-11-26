import 'package:flutter/material.dart';
import '../services/api_exception.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameC = TextEditingController();
  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  final _auth = AuthService();

  bool _loading = false;
  bool _obscurePass = true;

  // Palet Warna Premium (Obsidian & Warm Champagne)
  static const Color _bgObsidian = Color(0xFF0D0F12);
  static const Color _surfaceCard = Color(0xFF161920);
  static const Color _surfaceInput = Color(0xFF1E222B);
  static const Color _borderSubtle = Color(0xFF2A2F3B);
  static const Color _accentGold = Color(0xFFE2C275);
  static const Color _textPrimary = Color(0xFFF3F4F6);
  static const Color _textSecondary = Color(0xFF9CA3AF);

  void _showMessage(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline_rounded : Icons.check_circle_outline,
              color: isError ? const Color(0xFFF87171) : const Color(0xFF34D399),
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: _textPrimary, fontSize: 13),
              ),
            ),
          ],
        ),
        backgroundColor: _surfaceInput,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: _borderSubtle),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Future<void> _register() async {
    if (_nameC.text.trim().isEmpty ||
        _emailC.text.trim().isEmpty ||
        _passC.text.length < 8) {
      _showMessage('Lengkapi data, password minimal 8 karakter');
      return;
    }

    setState(() => _loading = true);
    try {
      await _auth.register(
        name: _nameC.text.trim(),
        email: _emailC.text.trim(),
        password: _passC.text,
      );
      if (!mounted) return;
      _showMessage('Register berhasil, silakan login', isError: false);
      Navigator.pop(context); // kembali ke halaman login
    } on ApiException catch (e) {
      if (mounted) _showMessage(e.message);
    } catch (_) {
      if (mounted) _showMessage('Terjadi kesalahan tak terduga');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _nameC.dispose();
    _emailC.dispose();
    _passC.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: _textSecondary.withOpacity(0.5)),
      prefixIcon: Icon(prefixIcon, color: _textSecondary, size: 20),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: _surfaceInput,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _borderSubtle),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _accentGold, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgObsidian,
      body: Stack(
        children: [
          // Ambient Glow Halus di Sudut Kanan Atas
          Positioned(
            top: -120,
            right: -80,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _accentGold.withOpacity(0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tombol Kembali Minimalis
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: _surfaceCard,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: _borderSubtle),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 14,
                                color: _textSecondary,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Kembali',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: _textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Tipografi Header
                      const Text(
                        'Buat Akun Baru',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: _textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Lengkapi informasi di bawah untuk mendaftarkan akun Anda.',
                        style: TextStyle(
                          fontSize: 14,
                          color: _textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Card Form Utama
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: _surfaceCard,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: _borderSubtle, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.35),
                              blurRadius: 24,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nama Lengkap
                            const Text(
                              'Nama Lengkap',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: _textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _nameC,
                              textCapitalization: TextCapitalization.words,
                              style: const TextStyle(color: _textPrimary, fontSize: 14),
                              cursorColor: _accentGold,
                              decoration: _inputDecoration(
                                hint: 'Nama lengkap Anda',
                                prefixIcon: Icons.person_outline_rounded,
                              ),
                            ),
                            const SizedBox(height: 18),

                            // Email
                            const Text(
                              'Alamat Email',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: _textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _emailC,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: _textPrimary, fontSize: 14),
                              cursorColor: _accentGold,
                              decoration: _inputDecoration(
                                hint: 'nama@email.com',
                                prefixIcon: Icons.mail_outline_rounded,
                              ),
                            ),
                            const SizedBox(height: 18),

                            // Password
                            const Text(
                              'Kata Sandi',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: _textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _passC,
                              obscureText: _obscurePass,
                              style: const TextStyle(color: _textPrimary, fontSize: 14),
                              cursorColor: _accentGold,
                              decoration: _inputDecoration(
                                hint: 'Minimal 8 karakter',
                                prefixIcon: Icons.lock_outline_rounded,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePass
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: _textSecondary,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() => _obscurePass = !_obscurePass);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Gunakan minimal 8 karakter agar akun lebih aman.',
                              style: TextStyle(
                                fontSize: 11.5,
                                color: _textSecondary,
                              ),
                            ),
                            const SizedBox(height: 26),

                            // Tombol Register
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _loading ? null : _register,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _accentGold,
                                  foregroundColor: _bgObsidian,
                                  disabledBackgroundColor: _accentGold.withOpacity(0.4),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: _loading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.2,
                                          color: _bgObsidian,
                                        ),
                                      )
                                    : const Text(
                                        'Daftar Akun',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),

                      // Footer Kembali ke Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sudah punya akun?',
                            style: TextStyle(color: _textSecondary, fontSize: 13),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              foregroundColor: _accentGold,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                            ),
                            child: const Text(
                              'Masuk',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}