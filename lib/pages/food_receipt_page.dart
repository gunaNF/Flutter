import 'package:flutter/material.dart';
import 'food_list_page.dart'; // Kembali ke halaman pertama + warna & formatRp
import 'dart:typed_data';

class FoodReceiptPage extends StatelessWidget {
  final Map<String, int> cart;
  final List<Map<String, dynamic>> menuList;
  final int totalPrice;
  final String paymentMethod;
  final int cashPaid;
  final int change;
  final String buyerName;
  final Uint8List? photoBytes; // foto selfie (boleh kosong)

  const FoodReceiptPage({
    super.key,
    required this.cart,
    required this.menuList,
    required this.totalPrice,
    required this.paymentMethod,
    required this.cashPaid,
    required this.change,
    required this.buyerName,
    this.photoBytes,
  });

  String twoDigit(int n) => n.toString().padLeft(2, '0');

  // Garis putus-putus ala struk
  Widget dashedLine() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int count = (constraints.maxWidth / 8).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            count,
            (_) => Container(width: 4, height: 1.5, color: Colors.black26),
          ),
        );
      },
    );
  }

  Widget infoRow(String left, String right, {bool bold = false, Color? color}) {
    final style = TextStyle(
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      fontSize: bold ? 17 : 14,
      color: color,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(left, style: style)),
          Text(right, style: style),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String waktu =
        "${twoDigit(now.day)}/${twoDigit(now.month)}/${now.year}  ${twoDigit(now.hour)}:${twoDigit(now.minute)}";
    final String noOrder = "AF-${(now.millisecondsSinceEpoch % 10000).toString().padLeft(4, '0')}";

    return Scaffold(
      backgroundColor: kYellow,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 8),
              // ---------- Ikon sukses ----------
              Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(color: kDark, shape: BoxShape.circle),
                child: const Icon(Icons.check_rounded, color: kYellow, size: 40),
              ),
              const SizedBox(height: 12),
              const Text("Transaksi Berhasil!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: kDark)),
              const SizedBox(height: 2),
              const Text("Terima kasih sudah jajan di Assalaam Food",
                  style: TextStyle(color: Colors.black54, fontSize: 13)),
              const SizedBox(height: 20),

              // ---------- Kartu struk ----------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text("STRUK PEMBAYARAN",
                          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.5)),
                    ),
                    const SizedBox(height: 16),
                    // Foto pembeli (kalau ada)
                    if (photoBytes != null)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: CircleAvatar(
                            radius: 42,
                            backgroundImage: MemoryImage(photoBytes!),
                          ),
                        ),
                      ),
                    infoRow("Pembeli", buyerName),
                    infoRow("No. Pesanan", noOrder),
                    infoRow("Tanggal", waktu),
                    const SizedBox(height: 10),
                    dashedLine(),
                    const SizedBox(height: 12),

                    // Rincian multi items
                    const Text("Rincian Belanja",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 6),
                    ...cart.entries.map((entry) {
                      final item = menuList.firstWhere((element) => element["name"] == entry.key);
                      final int subtotal = (item["price"] as int) * entry.value;
                      return infoRow("${entry.key} (x${entry.value})", formatRp(subtotal));
                    }).toList(),

                    const SizedBox(height: 10),
                    dashedLine(),
                    const SizedBox(height: 12),

                    infoRow("Total", formatRp(totalPrice), bold: true),
                    infoRow("Metode Bayar", paymentMethod),
                    if (paymentMethod == "Cash") ...[
                      infoRow("Tunai Dibayar", formatRp(cashPaid)),
                      infoRow("Kembalian", formatRp(change), color: Colors.green.shade700),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // ---------- Tombol selesai ----------
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kDark,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () {
              // Kembali ke halaman pertama dan bersihkan riwayat navigasi sebelumnya
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const FoodListScreen()),
                (route) => false,
              );
            },
            child: const Text("Selesai (Kembali ke Menu)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
        ),
      ),
    );
  }
}