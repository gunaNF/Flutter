import 'package:flutter/material.dart';
import '../services/api_exception.dart';
import '../services/auth_service.dart';
import 'home_auth.dart';
import 'register_page.dart';
import 'article_list_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  Future<void> _login() async {
    if (_emailC.text.trim().isEmpty || _passC.text.isEmpty) {
      _showMessage('Email dan password wajib diisi');
      return;
    }

    setState(() => _loading = true);
    try {
      await _auth.login(email: _emailC.text.trim(), password: _passC.text);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ArticleListPage()),
      );
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
          // Cahaya Halus di Sudut Kanan Atas
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Emblem Minimalis
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: _surfaceCard,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: _borderSubtle, width: 1.2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.shield_outlined,
                          color: _accentGold,
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Header
                      const Text(
                        'Selamat Datang Kembali',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: _textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Masuk ke akun Anda untuk melanjutkan akses ke layanan.',
                        style: TextStyle(
                          fontSize: 14,
                          color: _textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Card Form Login
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
                              key: const ValueKey('login_email_field'),
                              controller: _emailC,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: _textPrimary, fontSize: 14),
                              cursorColor: _accentGold,
                              decoration: _inputDecoration(
                                hint: 'nama@email.com',
                                prefixIcon: Icons.mail_outline_rounded,
                              ),
                            ),
                            const SizedBox(height: 20),

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
                              key: const ValueKey('login_password_field'),
                              controller: _passC,
                              obscureText: _obscurePass == true,
                              style: const TextStyle(color: _textPrimary, fontSize: 14),
                              cursorColor: _accentGold,
                              decoration: _inputDecoration(
                                hint: '••••••••',
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
                            const SizedBox(height: 28),

                            // Tombol Login
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _loading ? null : _login,
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
                                        'Masuk',
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
                      const SizedBox(height: 24),

                      // Footer Register
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Belum punya akun?',
                            style: TextStyle(color: _textSecondary, fontSize: 13),
                          ),
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const RegisterPage()),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: _accentGold,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                            ),
                            child: const Text(
                              'Daftar Sekarang',
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