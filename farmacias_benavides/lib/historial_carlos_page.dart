import 'package:flutter/material.dart';

import 'widgets/navbar.dart';

class HistorialMedicoCarlosPage extends StatelessWidget {
  final String userName;
  const HistorialMedicoCarlosPage({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      appBar: Navbar(userName: userName),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Historial Médico de Carlos Pérez',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E0D0C),
                  ),
                ),
                const SizedBox(height: 24),
                _tabsRow(),
                const Divider(height: 30, color: Color(0xFFE9DADA)),
                _sectionTitle('Información del Paciente'),
                const SizedBox(height: 12),
                _infoGrid(isMobile, const [
                  ['Nombre', 'Carlos Pérez'],
                  ['Fecha de Nacimiento', '20 de abril de 1990'],
                  ['Género', 'Masculino'],
                  ['Grupo Sanguíneo', 'A+'],
                  ['Dirección', 'Av. Central 456, Ciudad, Estado'],
                  ['Teléfono', '555-9876'],
                  ['Correo Electrónico', 'carlos.perez@email.com'],
                  ['CURP', 'PELC900420HDFRRL05'],
                  ['Ocupación', 'Ingeniero de Sistemas'],
                ]),
                const SizedBox(height: 36),
                _sectionTitle('Antecedentes Médicos'),
                const SizedBox(height: 12),
                _infoGrid(isMobile, const [
                  ['Enfermedades Crónicas', 'Hipertensión controlada'],
                  ['Cirugías Previas', 'Ninguna'],
                ]),
                const SizedBox(height: 36),
                _sectionTitle('Historial Familiar'),
                const SizedBox(height: 12),
                _infoGrid(isMobile, const [
                  ['Enfermedades Hereditarias', 'Hipertensión (madre)'],
                  ['Antecedentes de Cáncer', 'Cáncer de colon (abuelo paterno)'],
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabsRow() {
    const tabs = [
      'Antecedentes Personales',
      'Medicamentos Actuales',
      'Alergias',
      'Consultas Anteriores',
    ];

    return Row(
      children: tabs.map((tab) {
        final isSelected = tab == 'Antecedentes Personales';
        return Padding(
          padding: const EdgeInsets.only(right: 28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tab,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF934E51) : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (isSelected)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  height: 2,
                  width: 120,
                  color: const Color(0xFF934E51),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Color(0xFF2E0D0C),
      ),
    );
  }

  Widget _infoGrid(bool isMobile, List<List<String>> data) {
    const leftColor = Color(0xFF934E51);
    return Column(
      children: data.map((item) {
        final label = item[0];
        final value = item[1];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: TextStyle(
                            color: leftColor, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(value),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(label,
                          style: TextStyle(
                              color: leftColor, fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      child: Text(value),
                    ),
                  ],
                ),
        );
      }).toList(),
    );
  }
}
