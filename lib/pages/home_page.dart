import 'package:flutter/material.dart';
import 'package:projek_flutterpertama/routes/app_route.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F2027),
              Color(0xFF203A43),
              Color(0xFF2C5364),
            ], // Deep Space Gradient
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Header Modern dengan Efek Glassmorphism
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.bolt_rounded,
                                    color: Colors.amber, size: 16),
                                SizedBox(width: 6),
                                Text(
                                  'Flutter v3.x',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Avatar Profil Cepat
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, AppRoute.about),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [Colors.purpleAccent, Colors.cyanAccent],
                                ),
                              ),
                              child: const CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(0xFF1E1E1E),
                                child: Icon(Icons.person, color: Colors.white, size: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Selamat Datang,',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Dashboard Utama 🚀',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Pilih modul navigasi interaktif di bawah untuk menguji fitur aplikasi.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white54,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Daftar Menu Menggunakan Model Card Interaktif yang Elegan
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildModernCard(
                      context,
                      title: 'Profil Pengguna',
                      subtitle: 'Lihat informasi identitas dan detail proyek',
                      icon: Icons.person_pin_rounded,
                      accentColor: Colors.indigoAccent,
                      gradientColors: [const Color(0xFF654EA3), const Color(0xFFEAAFC8)],
                      onPressed: () => Navigator.pushNamed(context, AppRoute.about),
                    ),
                    const SizedBox(height: 16),

                    _buildModernCard(
                      context,
                      title: 'Daftar Artikel & List',
                      subtitle: 'Eksplorasi tampilan grid view dan list dinamis',
                      icon: Icons.article_rounded,
                      accentColor: Colors.tealAccent,
                      gradientColors: [const Color(0xFF11998e), const Color(0xFF38ef7d)],
                      onPressed: () => Navigator.pushNamed(context, AppRoute.articleList),
                    ),
                    const SizedBox(height: 16),

                    _buildModernCard(
                      context,
                      title: 'Galeri Instagram',
                      subtitle: 'Layout tata letak pos media sosial modern',
                      icon: Icons.camera_enhance_rounded,
                      accentColor: Colors.purpleAccent,
                      gradientColors: [const Color(0xFF833ab4), const Color(0xFFfd1d1d), const Color(0xFFfcb045)],
                      onPressed: () => Navigator.pushNamed(context, AppRoute.instagram),
                    ),
                    const SizedBox(height: 16),

                    _buildModernCard(
                      context,
                      title: 'Formulir Registrasi Umum',
                      subtitle: 'Input data dengan validasi, radio, dan datepicker',
                      icon: Icons.edit_document,
                      accentColor: Colors.blueAccent,
                      gradientColors: [const Color(0xFF2193b0), const Color(0xFF6dd5ed)],
                      onPressed: () => Navigator.pushNamed(context, AppRoute.form),
                    ),
                    const SizedBox(height: 16),

                    _buildModernCard(
                      context,
                      title: 'Formulir Pendaftaran Eskul',
                      subtitle: 'Checkbox bersyarat, dropdown kelas, & kontak',
                      icon: Icons.sports_basketball_rounded,
                      accentColor: Colors.orangeAccent,
                      gradientColors: [const Color(0xFFf12711), const Color(0xFFf5af19)],
                      onPressed: () => Navigator.pushNamed(context, AppRoute.eskul),
                    ),
                    const SizedBox(height: 16),

                    _buildModernCard(
                      context,
                      title: 'Grid Instagram Interaktif',
                      subtitle: 'Komponen UI grid lanjutan untuk galeri foto',
                      icon: Icons.grid_view_rounded,
                      accentColor: Colors.lightGreenAccent,
                      gradientColors: [const Color(0xFF56ab2f), const Color(0xFFa8e063)],
                      onPressed: () => Navigator.pushNamed(context, AppRoute.gridInstagram),
                    ),
                    const SizedBox(height: 16),

                    // Modul Kantin Assalaam Food yang Baru Ditambahkan
                    _buildModernCard(
                      context,
                      title: 'Assalaam Food (Kantin)',
                      subtitle: 'Pilih menu makanan, keranjang multi-item, & pembayaran',
                      icon: Icons.fastfood_rounded,
                      accentColor: Colors.amberAccent,
                      gradientColors: [const Color(0xFFFFD33C), const Color(0xFFFFA500)],
                      onPressed: () => Navigator.pushNamed(context, AppRoute.foodList),
                    ),
                    const SizedBox(height: 16),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Kartu Menu Canggih dengan Efek Elevasi dan Gradient Tipis
  Widget _buildModernCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required List<Color> gradientColors,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(18),
          splashColor: accentColor.withOpacity(0.2),
          highlightColor: accentColor.withOpacity(0.1),
          child: Ink(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withOpacity(0.12),
                width: 1.2,
              ),
            ),
            child: Row(
              children: [
                // Ikon dengan latar gradasi khusus
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: gradientColors.first.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: 26),
                ),
                const SizedBox(width: 16),
                // Teks Judul dan Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Indikator Panah Kanan
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}