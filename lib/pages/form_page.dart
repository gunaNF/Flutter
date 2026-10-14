
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
      TextEditingController();

  final TextEditingController _alamatController =
      TextEditingController();

  DateTime? _tanggalLahir;
  String? _jenisKelamin;
  String? _agama;

  String _submittedName = '';
  String _submittedTanggalLahir = '';
  String _submittedJenisKelamin = '';
  String _submittedAlamat = '';
  String _submittedAgama = '';

  @override
  void dispose() {
    _nameController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  // Memilih tanggal lahir
  Future<void> _pilihTanggalLahir() async {
    final DateTime? tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime(2008),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: 'Pilih Tanggal Lahir',
    );

    if (tanggal != null && mounted) {
      setState(() {
        _tanggalLahir = tanggal;
      });
    }
  }

  // Fungsi submit
  void _submitForm() {
    // Validasi nama dan alamat
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama dan alamat wajib diisi!'),
        ),
      );
      return;
    }

    // Validasi tanggal lahir
    if (_tanggalLahir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih tanggal lahir terlebih dahulu!'),
        ),
      );
      return;
    }

    // Validasi jenis kelamin
    if (_jenisKelamin == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih jenis kelamin terlebih dahulu!'),
        ),
      );
      return;
    }

    // Validasi agama
    if (_agama == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih agama terlebih dahulu!'),
        ),
      );
      return;
    }

    // Simpan semua data yang diinput
    setState(() {
      _submittedName = _nameController.text.trim();

      _submittedTanggalLahir =
          '${_tanggalLahir!.day.toString().padLeft(2, '0')}/'
          '${_tanggalLahir!.month.toString().padLeft(2, '0')}/'
          '${_tanggalLahir!.year}';

      _submittedJenisKelamin = _jenisKelamin!;
      _submittedAlamat = _alamatController.text.trim();
      _submittedAgama = _agama!;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data berhasil disimpan!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Biodata'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama lengkap
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  hintText: 'Masukkan nama lengkap',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Tanggal lahir
              InkWell(
                onTap: _pilihTanggalLahir,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Lahir',
                    border: OutlineInputBorder(),
                    prefixIcon:
                        Icon(Icons.calendar_month),
                  ),
                  child: Text(
                    _tanggalLahir == null
                        ? 'Pilih tanggal lahir'
                        : '${_tanggalLahir!.day.toString().padLeft(2, '0')}/'
                          '${_tanggalLahir!.month.toString().padLeft(2, '0')}/'
                          '${_tanggalLahir!.year}',
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Jenis kelamin
              const Text(
                'Jenis Kelamin',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              RadioListTile<String>(
                title: const Text('Laki-laki'),
                value: 'Laki-laki',
                groupValue: _jenisKelamin,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    _jenisKelamin = value;
                  });
                },
              ),

              RadioListTile<String>(
                title: const Text('Perempuan'),
                value: 'Perempuan',
                groupValue: _jenisKelamin,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    _jenisKelamin = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Alamat
              TextFormField(
                controller: _alamatController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                  hintText: 'Masukkan alamat lengkap',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Agama
              DropdownButtonFormField<String>(
                value: _agama,
                decoration: const InputDecoration(
                  labelText: 'Agama',
                  border: OutlineInputBorder(),
                  prefixIcon:
                      Icon(Icons.account_balance),
                ),
                hint: const Text('Pilih agama'),
                items: const [
                  DropdownMenuItem(
                    value: 'Islam',
                    child: Text('Islam'),
                  ),
                  DropdownMenuItem(
                    value: 'Kristen',
                    child: Text('Kristen'),
                  ),
                  DropdownMenuItem(
                    value: 'Katolik',
                    child: Text('Katolik'),
                  ),
                  DropdownMenuItem(
                    value: 'Hindu',
                    child: Text('Hindu'),
                  ),
                  DropdownMenuItem(
                    value: 'Buddha',
                    child: Text('Buddha'),
                  ),
                  DropdownMenuItem(
                    value: 'Konghucu',
                    child: Text('Konghucu'),
                  ),
                ],
                validator: (value) {
                  if (value == null) {
                    return 'Silakan pilih agama';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _agama = value;
                  });
                },
              ),

              const SizedBox(height: 24),

              // Tombol Submit
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Hasil biodata
              if (_submittedName.isNotEmpty) ...[
                const Divider(thickness: 1.5),
                const SizedBox(height: 12),

                const Text(
                  'Hasil Biodata',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                _hasilItem(
                  Icons.person,
                  'Nama Lengkap',
                  _submittedName,
                ),

                _hasilItem(
                  Icons.calendar_month,
                  'Tanggal Lahir',
                  _submittedTanggalLahir,
                ),

                _hasilItem(
                  Icons.people,
                  'Jenis Kelamin',
                  _submittedJenisKelamin,
                ),

                _hasilItem(
                  Icons.home,
                  'Alamat',
                  _submittedAlamat,
                ),

                _hasilItem(
                  Icons.account_balance,
                  'Agama',
                  _submittedAgama,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan setiap hasil biodata
  Widget _hasilItem(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.blue,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}