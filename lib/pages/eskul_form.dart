import 'package:flutter/material.dart';
import 'package:projek_flutterpertama/helpers/size_helper.dart';
import 'package:projek_flutterpertama/pages/eskul_output.dart';
import 'package:intl/intl.dart';

class EskulForm extends StatefulWidget {
  const EskulForm({super.key});

  @override
  State<EskulForm> createState() => _EskulFormState();
}

class _EskulFormState extends State<EskulForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController namaController = TextEditingController();
  TextEditingController teleponController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController tglPendaftaranController = TextEditingController();

  String? _selectedKelas;
  String? _kelasError;
  String? _eskulError;

  final List<String> listKelas = [
    "X RPL 1",
    "X RPL 2",
    "XI RPL 1",
    "XI RPL 2",
    "XII RPL 1",
  ];

  final Map<String, bool> listEskul = {
    "Futsal": false,
    "Pramuka": false,
    "Paskibra": false,
    "Rohis": false,
    "Basket": false,
  };

  @override
  void initState() {
    super.initState();
    tglPendaftaranController.text = "";
  }

  @override
  void dispose() {
    namaController.dispose();
    teleponController.dispose();
    emailController.dispose();
    tglPendaftaranController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        color: Colors.blueGrey,
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Formulir Pendaftaran Ekstrakurikuler",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 18),

                      TextFormField(
                        controller: namaController,
                        decoration: const InputDecoration(
                          labelText: "Nama Lengkap",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama lengkap tidak boleh kosong';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      TextFormField(
                        controller: teleponController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: "No Telepon",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No telepon tidak boleh kosong';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          if (!value.contains('@')) {
                            return 'Format email tidak valid';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: "Pilih Kelas",
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedKelas,
                        items: listKelas
                            .map(
                              (kelas) => DropdownMenuItem(
                                value: kelas,
                                child: Text(kelas),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedKelas = value;
                            _kelasError = null;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pilih kelas terlebih dahulu';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Pilih Eskul (Minimal 1, Maksimal 2)",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      ...listEskul.keys.map((String eskulName) {
                        return CheckboxListTile(
                          title: Text(eskulName),
                          value: listEskul[eskulName],
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (bool? value) {
                            setState(() {
                              // Hitung berapa eskul yang sudah dicentang saat ini
                              int selectedCount = listEskul.values
                                  .where((selected) => selected)
                                  .length;

                              if (value == true && selectedCount >= 2) {
                                // Jika sudah 2 dan ingin menambah lagi, dicegah
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Maksimal hanya dapat memilih 2 eskul!"),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                                return;
                              }

                              listEskul[eskulName] = value ?? false;
                              _eskulError = null;
                            });
                          },
                        );
                      }).toList(),

                      if (_eskulError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            _eskulError!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),

                      const SizedBox(height: 18),

                      TextFormField(
                        controller: tglPendaftaranController,
                        decoration: const InputDecoration(
                          labelText: "Tanggal Pendaftaran",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.date_range),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            setState(() {
                              tglPendaftaranController.text =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tanggal pendaftaran tidak boleh kosong';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      // Tombol Submit / Simpan
                      SizedBox(
                        width: displayWidth(context) * 0.8,
                        height: displayHeight(context) * 0.075,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                              side: const BorderSide(color: Colors.black),
                            ),
                          ),
                          child: const Text(
                            "Simpan",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: _submit,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();

    // Hitung total checkbox eskul yang dipilih
    int selectedEskulCount =
        listEskul.values.where((selected) => selected).length;

    if (selectedEskulCount == 0) {
      setState(() {
        _eskulError = 'Pilih minimal 1 ekstrakurikuler';
      });
    }

    if (!isValid || selectedEskulCount == 0) return;

    List<String> selectedEskulList = listEskul.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OutputFormScreen(
          nama: namaController.text,
          telepon: teleponController.text,
          email: emailController.text,
          kelas: _selectedKelas ?? '',
          eskul: selectedEskulList.join(', '),
          tglPendaftaran: tglPendaftaranController.text,
        ),
      ),
    );
  }
}