import 'package:flutter/material.dart';

class OutputFormScreen extends StatelessWidget {
  final String nama, telepon, email, kelas, eskul, tglPendaftaran;

  const OutputFormScreen({
    super.key,
    required this.nama,
    required this.telepon,
    required this.email,
    required this.kelas,
    required this.eskul,
    required this.tglPendaftaran,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hasil Pendaftaran Eskul"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.black),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Detail Pendaftaran Ekstrakurikuler",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(height: 24, thickness: 1),
                    _textWidget("Nama Lengkap", nama),
                    _textWidget("No Telepon", telepon),
                    _textWidget("Email", email),
                    _textWidget("Kelas", kelas),
                    _textWidget("Pilihan Eskul", eskul),
                    _textWidget("Tgl Pendaftaran", tglPendaftaran),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textWidget(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(": $value")),
        ],
      ),
    );
  }
}