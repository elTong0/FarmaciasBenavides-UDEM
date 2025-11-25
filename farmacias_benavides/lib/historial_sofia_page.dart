import 'package:flutter/material.dart';

import 'widgets/navbar.dart';

class HistorialMedicoSofiaPage extends StatelessWidget {
  final String userName;
  const HistorialMedicoSofiaPage({
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
                  'Historial Médico de Sofía Ramírez',
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
                  ['Nombre', 'Sofía Ramírez'],
                  ['Fecha de Nacimiento', '15 de marzo de 1988'],
                  ['Género', 'Femenino'],
                  ['Grupo Sanguíneo', 'O+'],
                  ['Dirección', 'Calle Principal 123, Ciudad, Estado'],
                  ['Teléfono', '555-1234'],
                  ['Correo Electrónico', 'sofia.ramirez@email.com'],
                  ['Ocupación', 'Profesora'],
                ]),
                const SizedBox(height: 36),
                _sectionTitle('Antecedentes Médicos'),
                const SizedBox(height: 12),
                _infoGrid(isMobile, const [
                  ['Enfermedades Crónicas', 'Asma'],
                  ['Cirugías Previas', 'Apéndice (2010)'],
                ]),
                const SizedBox(height: 36),
                _sectionTitle('Historial Familiar'),
                const SizedBox(height: 12),
                _infoGrid(isMobile, const [
                  ['Enfermedades Hereditarias', 'Diabetes (padre)'],
                  ['Antecedentes de Cáncer', 'Cáncer de mama (abuela materna)'],
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
