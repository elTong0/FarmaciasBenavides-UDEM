import 'package:flutter/material.dart';

import 'data/patient_repository.dart';
import 'widgets/navbar.dart';

class AntecedentesMedicosPage extends StatefulWidget {
  final String userName;
  final String patientName;
  final String patientId;

  const AntecedentesMedicosPage({
    super.key,
    required this.userName,
    required this.patientName,
    required this.patientId,
  });

  @override
  State<AntecedentesMedicosPage> createState() =>
      _AntecedentesMedicosPageState();
}

class _AntecedentesMedicosPageState extends State<AntecedentesMedicosPage> {
  late PatientRecord _record;

  @override
  void initState() {
    super.initState();
    _record = PatientRepository.instance.getRecord(widget.patientId);
  }

  String? get tipoSangre => _record.tipoSangre;
  String? get alergias => _record.alergias;
  String? get enfermedades => _record.enfermedadesCronicas;
  String? get medicamentos => _record.medicamentosActuales;
  String? get cirugias => _record.cirugiasPrevias;
  String? get vacunas => _record.vacunas;

  late final OutlineInputBorder _bordeRosa = OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xFFE0BFC4), width: 1),
    borderRadius: BorderRadius.circular(8),
  );

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      appBar: Navbar(userName: widget.userName),
      body: Container(
        color: const Color(0xFFFCF7F9),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Antecedentes médicos de ${widget.patientName}',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E0D0C),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Completa o actualiza la información del paciente.',
                    style: TextStyle(color: Color(0xFF934E51)),
                  ),
                  const SizedBox(height: 32),
                  _buildDropdown(
                    'Tipo de sangre',
                    tipoSangre,
                    [
                      'O+',
                      'O-',
                      'A+',
                      'A-',
                      'B+',
                      'B-',
                      'AB+',
                      'AB-'
                    ],
                    (v) => setState(() => _record.tipoSangre = v ?? ''),
                  ),
                  _buildDropdown(
                    'Alergias',
                    alergias,
                    [
                      'Ninguna',
                      'Polvo',
                      'Polen',
                      'Lácteos',
                      'Medicamentos',
                    ],
                    (v) => setState(() => _record.alergias = v ?? ''),
                  ),
                  _buildDropdown(
                    'Enfermedades crónicas',
                    enfermedades,
                    [
                      'Asma',
                      'Diabetes',
                      'Hipertensión',
                      'Otra',
                    ],
                    (v) => setState(() => _record.enfermedadesCronicas = v ?? ''),
                  ),
                  _buildDropdown(
                    'Medicamentos actuales',
                    medicamentos,
                    [
                      'Ninguno',
                      'Paracetamol',
                      'Antibióticos',
                      'Otros',
                    ],
                    (v) => setState(() => _record.medicamentosActuales = v ?? ''),
                  ),
                  _buildDropdown(
                    'Cirugías previas',
                    cirugias,
                    [
                      'Ninguna',
                      'Apéndice',
                      'Cesárea',
                      'Otra',
                    ],
                    (v) => setState(() => _record.cirugiasPrevias = v ?? ''),
                  ),
                  _buildDropdown(
                    'Vacunas',
                    vacunas,
                    [
                      'COVID-19',
                      'Influenza',
                      'Tétanos',
                      'Hepatitis',
                    ],
                    (v) => setState(() => _record.vacunas = v ?? ''),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB61B2E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        PatientRepository.instance
                            .updateRecord(widget.patientId, _record);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Cambios guardados.'),
                          ),
                        );
                        Navigator.of(context).pop(true);
                      },
                      icon: const Icon(Icons.save_outlined),
                      label: const Text('Guardar cambios'),
                    ),
                  ),
                  if (isMobile) const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String? value,
    List<String> opciones,
    void Function(String?) onChanged,
  ) {
    final items = {
      if (value != null) value,
      ...opciones,
    }.toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText: 'Seleccionar',
              hintStyle: const TextStyle(color: Colors.black54),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              enabledBorder: _bordeRosa,
              focusedBorder: _bordeRosa,
            ),
            initialValue: value,
            icon: const Icon(Icons.keyboard_arrow_down,
                color: Color(0xFF934E51)),
            onChanged: onChanged,
            items: items
                .map(
                  (op) => DropdownMenuItem<String>(
                    value: op,
                    child: Text(op),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

