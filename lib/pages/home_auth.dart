import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import 'food_list_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = AuthService();
  late Future<UserModel> _futureUser;

  // Palet Warna Premium (Obsidian & Warm Champagne)
  static const Color _bgObsidian = Color(0xFF0D0F12);
  static const Color _surfaceCard = Color(0xFF161920);
  static const Color _surfaceInput = Color(0xFF1E222B);
  static const Color _borderSubtle = Color(0xFF2A2F3B);
  static const Color _accentGold = Color(0xFFE2C275);
  static const Color _textPrimary = Color(0xFFF3F4F6);
  static const Color _textSecondary = Color(0xFF9CA3AF);

  @override
  void initState() {
    super.initState();
    _futureUser = _auth.getUser();
  }

  void _reloadUser() {
    setState(() {
      _futureUser = _auth.getUser();
    });
  }

  Future<void> _logout() async {
    await _auth.logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (_) => false,
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return 'U';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts[1][0]}'.toUpperCase();
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
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Bar Minimalis
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _surfaceCard,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: _borderSubtle),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.verified_user_outlined,
                                  size: 15,
                                  color: _accentGold,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Akun Aktif',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: _logout,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: _surfaceCard,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: _borderSubtle),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.logout_rounded,
                                    size: 16,
                                    color: _textSecondary,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Keluar',
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
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Konten Utama FutureBuilder<UserModel>
                      Expanded(
                        child: FutureBuilder<UserModel>(
                          future: _futureUser,
                          builder: (context, snap) {
                            if (snap.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: _accentGold,
                                  strokeWidth: 2.2,
                                ),
                              );
                            }

                            if (snap.hasError) {
                              return Center(
                                child: Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: _surfaceCard,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: _borderSubtle),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF87171).withOpacity(0.12),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.error_outline_rounded,
                                          color: Color(0xFFF87171),
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(height: 14),
                                      const Text(
                                        'Gagal Memuat Profil',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: _textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        snap.error.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: _textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: OutlinedButton(
                                              onPressed: _reloadUser,
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: _textPrimary,
                                                side: const BorderSide(color: _borderSubtle),
                                                padding: const EdgeInsets.symmetric(vertical: 13),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                              ),
                                              child: const Text('Coba Lagi'),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: _logout,
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: _accentGold,
                                                foregroundColor: _bgObsidian,
                                                elevation: 0,
                                                padding: const EdgeInsets.symmetric(vertical: 13),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                              ),
                                              child: const Text(
                                                'Kembali ke Login',
                                                style: TextStyle(fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            final user = snap.data!;
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Kartu Profil Pengguna
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: _surfaceCard,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: _borderSubtle),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 20,
                                          offset: const Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 54,
                                          height: 54,
                                          decoration: BoxDecoration(
                                            color: _surfaceInput,
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(
                                              color: _accentGold.withOpacity(0.5),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            _getInitials(user.name),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: _accentGold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Selamat Datang,',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: _textSecondary,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                'Halo, ${user.name}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  color: _textPrimary,
                                                  letterSpacing: -0.3,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                user.email,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: _textSecondary,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 24),

                                  const Text(
                                    'Layanan Utama',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: _textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 12),

                                  // Kartu Pintasan Assalaam Food
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const FoodListScreen(),
                                          ),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(20),
                                      child: Ink(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: _surfaceCard,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: _borderSubtle),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 48,
                                              height: 48,
                                              decoration: BoxDecoration(
                                                color: _accentGold.withOpacity(0.14),
                                                borderRadius: BorderRadius.circular(14),
                                                border: Border.all(
                                                  color: _accentGold.withOpacity(0.35),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.restaurant_menu_rounded,
                                                color: _accentGold,
                                                size: 24,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            const Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Assalaam Food',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      color: _textPrimary,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    'Pesan menu kantin, kelola keranjang, dan bayar tunai atau QRIS.',
                                                    style: TextStyle(
                                                      fontSize: 12.5,
                                                      color: _textSecondary,
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: _surfaceInput,
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: _borderSubtle),
                                              ),
                                              child: const Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 14,
                                                color: _accentGold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
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