import 'package:flutter/material.dart';
import 'food_cart_page.dart'; // Menghubungkan ke halaman ke-2

// ===================== WARNA & HELPER (dipakai di semua halaman) =====================
const Color kYellow = Color(0xFFFFD33C);
const Color kDark = Color(0xFF1F1F1F);
const Color kBg = Color(0xFFF6F6F1);

// Mengubah angka 10000 -> "Rp 10.000"
String formatRp(int n) {
  final s = n.toString();
  final b = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write('.');
    b.write(s[i]);
  }
  return 'Rp $b';
}

// Widget foto menu. Kalau foto tidak ditemukan / kosong, otomatis tampil icon.
class FoodImage extends StatelessWidget {
  final String path;
  final IconData icon;
  final double iconSize;

  const FoodImage({
    super.key,
    required this.path,
    required this.icon,
    this.iconSize = 48,
  });

  Widget fallback() {
    return Container(
      color: kYellow.withAlpha(70),
      child: Center(child: Icon(icon, size: iconSize, color: kDark)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) return fallback();

    // Foto dari internet (link) atau dari folder assets
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stack) => fallback(),
      );
    }
    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stack) => fallback(),
    );
  }
}

// ===================== HALAMAN 1: DAFTAR ITEMS =====================
class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  // ---------------------------------------------------------------
  // DATA MENU KANTIN ASSALAAM FOOD
  // >>> UBAH FOTO DI SINI: isi key "image" dengan lokasi foto kamu <<<
  // Contoh dari folder assets : "assets/images/batagor.jpg"
  // Contoh dari internet      : "https://contoh.com/batagor.jpg"
  // Kalau dikosongkan (""), akan tampil icon sebagai pengganti.
  // ---------------------------------------------------------------
 final List<Map<String, dynamic>> menuList = [
    {"name": "Batagor", "price": 5000, "category": "Makanan", "icon": Icons.rice_bowl, "image": "/home/guna/Downloads/batagor.webp"},
    {"name": "Makaroni Basah", "price": 5000, "category": "Makanan", "icon": Icons.ramen_dining, "image": "/home/guna/Downloads/makaroni-basah-foto-resep-utama.webp"},
    {"name": "Mie Yamin", "price": 10000, "category": "Makanan", "icon": Icons.lunch_dining, "image": "/home/guna/Downloads/mie-yamin.webp"},
    {"name": "Cilok", "price": 3000, "category": "Makanan", "icon": Icons.local_drink, "image": "/home/guna/Downloads/cilok-is-typical-west-javanese-food-made-from-springy-tapioca-with-additional-spices-such-as-soy-sauce-sauce_608104-1301.webp"},
    {"name": "Paket Ayam Geprek", "price": 7000, "category": "Makanan", "icon": Icons.local_bar, "image": "/home/guna/Downloads/ognAQhzlQCpE1EFt8B4IfpDAAM9jgQfA6KUDEn~tplv-sdweummd6v-shrink_640_0_q50.webp"},
    {"name": "Air Mineral", "price": 3000, "category": "Minuman", "icon": Icons.water_drop, "image": "/home/guna/Downloads/f222768c-e147-45e0-bd47-0f75760d7f7b.webp"},
     {"name": "Extrajos susu", "price": 3000, "category": "Minuman", "icon": Icons.water_drop, "image": "/home/guna/Downloads/83b3eec0-2134-4d39-b3c6-cdc357bf030a_Go-Biz_20210331_192834.webp"},
  ];

  // Keranjang belanja untuk menampung multi items (nama menu -> jumlah)
  final Map<String, int> cart = {};

  final List<String> categories = ["Semua", "Makanan", "Minuman"];
  String selectedCategory = "Semua";
  String searchText = "";

  int get totalItems => cart.values.fold(0, (sum, qty) => sum + qty);

  int get totalPrice {
    int total = 0;
    cart.forEach((name, qty) {
      final item = menuList.firstWhere((e) => e["name"] == name);
      total += (item["price"] as int) * qty;
    });
    return total;
  }

  void goToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodCartPage(cart: cart, menuList: menuList),
      ),
    ).then((_) => setState(() {})); // refresh setelah kembali dari halaman 2
  }

  @override
  Widget build(BuildContext context) {
    // Filter menu sesuai kategori & kata pencarian
    final List<Map<String, dynamic>> filtered = menuList.where((item) {
      final okCategory = selectedCategory == "Semua" || item["category"] == selectedCategory;
      final okSearch = (item["name"] as String).toLowerCase().contains(searchText.toLowerCase());
      return okCategory && okSearch;
    }).toList();

    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- Header (banner gradasi + pencarian) ----------
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD33C), Color(0xFFFFA726)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFA726).withAlpha(90),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Stack(
                  children: [
                    // Hiasan lingkaran transparan
                    Positioned(
                      right: -30,
                      top: -30,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 50,
                      bottom: -45,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(35),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    // Isi header
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(25),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.restaurant_menu, color: kDark, size: 22),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: kDark,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "Kantin Sekolah",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            "Assalamu'alaikum 👋",
                            style: TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                          const Text(
                            "Assalaam Food",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: kDark,
                              height: 1.15,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Jajan enak, harga pas di kantong 😋",
                            style: TextStyle(fontSize: 13, color: Colors.black87),
                          ),
                          const SizedBox(height: 18),

                          // Kolom pencarian
                          TextField(
                            onChanged: (value) => setState(() => searchText = value),
                            decoration: InputDecoration(
                              hintText: "Cari makanan atau minuman",
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(vertical: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ---------- Chip Kategori ----------
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final active = cat == selectedCategory;
                  return GestureDetector(
                    onTap: () => setState(() => selectedCategory = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: active ? kDark : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: active ? Colors.white : kDark,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 14),

            // ---------- Grid Menu ----------
            Expanded(
              child: filtered.isEmpty
                  ? const Center(child: Text("Menu tidak ditemukan 🥲"))
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      itemCount: filtered.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 0.66,
                      ),
                      itemBuilder: (context, index) => buildMenuCard(filtered[index]),
                    ),
            ),
          ],
        ),
      ),

      // ---------- Bar Keranjang (muncul kalau ada item) ----------
      bottomNavigationBar: totalItems == 0
          ? null
          : SafeArea(
              child: GestureDetector(
                onTap: goToCart,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: kDark,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(color: kYellow, shape: BoxShape.circle),
                        child: const Icon(Icons.shopping_bag_outlined, color: kDark, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("$totalItems item dipilih",
                                style: const TextStyle(color: Colors.white70, fontSize: 12)),
                            Text(formatRp(totalPrice),
                                style: const TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                      ),
                      const Text("Lihat Pesanan",
                          style: TextStyle(color: kYellow, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_ios, color: kYellow, size: 14),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  // ---------- Kartu satu menu ----------
  Widget buildMenuCard(Map<String, dynamic> item) {
    final String name = item["name"] as String;
    final int price = item["price"] as int;
    final IconData icon = item["icon"] as IconData;
    final String image = (item["image"] ?? "") as String;
    final int qty = cart[name] ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Foto menu
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: double.infinity,
                  child: FoodImage(path: image, icon: icon),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 2, 12, 0),
            child: Text(
              formatRp(price),
              style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFE08A00)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: qty == 0
                ? GestureDetector(
                    onTap: () => setState(() => cart[name] = 1),
                    child: Container(
                      height: 38,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: kDark,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text("+ Tambah",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    ),
                  )
                : Container(
                    height: 38,
                    decoration: BoxDecoration(
                      color: kYellow,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.remove, size: 20),
                          onPressed: () {
                            setState(() {
                              if (qty > 1) {
                                cart[name] = qty - 1;
                              } else {
                                cart.remove(name);
                              }
                            });
                          },
                        ),
                        Text("$qty", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.add, size: 20),
                          onPressed: () => setState(() => cart[name] = qty + 1),
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