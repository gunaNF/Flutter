import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // untuk kamera / galeri
import 'food_list_page.dart'; // untuk warna, formatRp, dan FoodImage
import 'food_receipt_page.dart';
import 'dart:typed_data';

class FoodCartPage extends StatefulWidget {
  final Map<String, int> cart;
  final List<Map<String, dynamic>> menuList;

  const FoodCartPage({super.key, required this.cart, required this.menuList});

  @override
  State<FoodCartPage> createState() => _FoodCartPageState();
}

class _FoodCartPageState extends State<FoodCartPage> {
  String selectedPayment = "Cash";
  final TextEditingController cashController = TextEditingController();

  // Data pembeli: nama & foto (foto disimpan sebagai bytes)
  final TextEditingController nameController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  Uint8List? photoBytes;

  @override
  void dispose() {
    cashController.dispose();
    nameController.dispose();
    super.dispose();
  }

  // Ambil foto dari kamera (selfie) atau galeri
  Future<void> pickPhoto(ImageSource source) async {
    try {
      final XFile? file = await picker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.front, // kamera depan = selfie
        imageQuality: 70,
        maxWidth: 800,
      );
      if (file == null) return; // dibatalkan
      final Uint8List bytes = await file.readAsBytes();
      setState(() => photoBytes = bytes);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kamera / galeri tidak bisa dibuka")),
      );
    }
  }

  // Menu pilihan: selfie atau galeri
  void showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text("Ambil Selfie / Foto"),
              onTap: () {
                Navigator.pop(context);
                pickPhoto(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text("Pilih dari Galeri"),
              onTap: () {
                Navigator.pop(context);
                pickPhoto(ImageSource.gallery);
              },
            ),
            if (photoBytes != null)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text("Hapus Foto"),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => photoBytes = null);
                },
              ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> findItem(String name) {
    return widget.menuList.firstWhere((element) => element["name"] == name);
  }

  int calculateTotal() {
    int total = 0;
    widget.cart.forEach((name, qty) {
      total += (findItem(name)["price"] as int) * qty;
    });
    return total;
  }

  // Tambah / kurangi jumlah item langsung dari halaman ini
  void changeQty(String name, int delta) {
    setState(() {
      final newQty = (widget.cart[name] ?? 0) + delta;
      if (newQty <= 0) {
        widget.cart.remove(name);
      } else {
        widget.cart[name] = newQty;
      }
    });
    // Kalau keranjang kosong, kembali ke halaman menu
    if (widget.cart.isEmpty) Navigator.pop(context);
  }

  void confirmPayment(int totalPrice) {
    final int cash = int.tryParse(cashController.text) ?? 0;

    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nama pembeli wajib diisi!")),
      );
      return;
    }

    if (selectedPayment == "Cash" && cash < totalPrice) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Uang tunai tidak mencukupi!")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodReceiptPage(
          cart: widget.cart,
          menuList: widget.menuList,
          totalPrice: totalPrice,
          paymentMethod: selectedPayment,
          cashPaid: selectedPayment == "Cash" ? cash : totalPrice,
          change: selectedPayment == "Cash" ? cash - totalPrice : 0,
          buyerName: nameController.text.trim(),
          photoBytes: photoBytes,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int totalPrice = calculateTotal();
    final int cash = int.tryParse(cashController.text) ?? 0;
    final int changeAmount = cash - totalPrice;

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        title: const Text("Pesanan Kamu", style: TextStyle(fontWeight: FontWeight.bold, color: kDark)),
        centerTitle: true,
        backgroundColor: kBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: kDark),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- Daftar item (multi items) ----------
            const Text("Ringkasan Pesanan", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...widget.cart.entries.map((entry) {
              final item = findItem(entry.key);
              final int price = item["price"] as int;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        child: FoodImage(
                          path: (item["image"] ?? "") as String,
                          icon: item["icon"] as IconData,
                          iconSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(entry.key,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          const SizedBox(height: 2),
                          Text(formatRp(price), style: const TextStyle(color: Colors.black54, fontSize: 12)),
                          const SizedBox(height: 6),
                          Text(formatRp(price * entry.value),
                              style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFE08A00))),
                        ],
                      ),
                    ),
                    // Tombol jumlah
                    Container(
                      decoration: BoxDecoration(
                        color: kBg,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => changeQty(entry.key, -1),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.remove, size: 18),
                            ),
                          ),
                          Text("${entry.value}", style: const TextStyle(fontWeight: FontWeight.bold)),
                          InkWell(
                            onTap: () => changeQty(entry.key, 1),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.add, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            const SizedBox(height: 12),

            // ---------- Data pembeli (nama + selfie) ----------
            const Text("Data Pembeli", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  // Lingkaran foto: tekan untuk selfie / pilih foto
                  GestureDetector(
                    onTap: showPhotoOptions,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: kYellow.withAlpha(90),
                          backgroundImage: photoBytes != null ? MemoryImage(photoBytes!) : null,
                          child: photoBytes == null
                              ? const Icon(Icons.person, size: 38, color: kDark)
                              : null,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(color: kDark, shape: BoxShape.circle),
                            child: const Icon(Icons.camera_alt, size: 14, color: kYellow),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: "Nama Pembeli",
                        hintText: "Contoh: Budi Santoso",
                        filled: true,
                        fillColor: kBg,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ---------- Metode pembayaran ----------
            const Text("Metode Pembayaran", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                paymentOption("Cash", "Cash (Tunai)", Icons.payments_outlined),
                const SizedBox(width: 12),
                paymentOption("QRIS", "QRIS", Icons.qr_code_scanner),
              ],
            ),
            const SizedBox(height: 16),

            if (selectedPayment == "Cash") ...[
              TextField(
                controller: cashController,
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() {}),
                decoration: InputDecoration(
                  labelText: "Masukkan Nominal Uang Tunai",
                  prefixText: "Rp ",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Tombol nominal cepat
              Wrap(
                spacing: 8,
                children: [
                  ActionChip(
                    label: const Text("Uang Pas"),
                    backgroundColor: Colors.white,
                    onPressed: () => setState(() => cashController.text = totalPrice.toString()),
                  ),
                  for (final nominal in [10000, 20000, 50000])
                    ActionChip(
                      label: Text(formatRp(nominal)),
                      backgroundColor: Colors.white,
                      onPressed: () => setState(() => cashController.text = nominal.toString()),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: changeAmount >= 0 ? const Color(0xFFE3F6E8) : const Color(0xFFFDE5E5),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  changeAmount >= 0
                      ? "Kembalian: ${formatRp(changeAmount)}"
                      : "Uang kurang: ${formatRp(changeAmount.abs())}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: changeAmount >= 0 ? Colors.green.shade800 : Colors.red.shade700,
                  ),
                ),
              ),
            ] else ...[
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.qr_code_2, size: 180, color: kDark),
                      const SizedBox(height: 6),
                      const Text("Scan QRIS Kantin Assalaam",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text("Bayar ${formatRp(totalPrice)}",
                          style: const TextStyle(color: Colors.black54, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),

      // ---------- Bar total + tombol bayar ----------
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Total Pembayaran", style: TextStyle(color: Colors.black54, fontSize: 12)),
                  Text(formatRp(totalPrice),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kDark,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  ),
                  onPressed: () => confirmPayment(totalPrice),
                  child: const Text("Konfirmasi & Cetak Struk",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Kartu pilihan metode bayar
  Widget paymentOption(String value, String label, IconData icon) {
    final bool selected = selectedPayment == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedPayment = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: selected ? kYellow : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: selected ? kDark : Colors.black12, width: 1.5),
          ),
          child: Column(
            children: [
              Icon(icon, size: 28, color: kDark),
              const SizedBox(height: 6),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}