import 'package:flutter/material.dart';

import 'widgets/navbar.dart';

class HistorialMedicoSofiaPage extends StatefulWidget {
  final String userName;
  const HistorialMedicoSofiaPage({
    super.key,
    required this.userName,
  });

  @override
  State<HistorialMedicoSofiaPage> createState() =>
      _HistorialMedicoSofiaPageState();
}

class _HistorialMedicoSofiaPageState extends State<HistorialMedicoSofiaPage> {
  final List<String> _tabs = const [
    'Antecedentes Personales',
    'Medicamentos Actuales',
    'Alergias',
    'Consultas Anteriores',
  ];

  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      appBar: Navbar(userName: widget.userName),
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
                _buildTabContent(isMobile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabsRow() {
    return Row(
      children: List.generate(_tabs.length, (index) {
        final tab = _tabs[index];
        final isSelected = _selectedTab == index;
        return Padding(
          padding: const EdgeInsets.only(right: 28.0),
          child: InkWell(
            onTap: () => setState(() => _selectedTab = index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tab,
                  style: TextStyle(
                    color:
                        isSelected ? const Color(0xFF934E51) : Colors.black87,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
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
          ),
        );
      }),
    );
  }

  Widget _buildTabContent(bool isMobile) {
    switch (_selectedTab) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              ['CURP', 'SARS880315MDFRMF08'],
              ['Ocupación', 'Profesora'],
            ]),
            const SizedBox(height: 36),
            _sectionTitle('Antecedentes Médicos'),
            const SizedBox(height: 12),
            _infoGrid(isMobile, const [
              ['Enfermedades Crónicas', 'Asma diagnosticada en 2005'],
              ['Cirugías Previas', 'Apéndice (2010)'],
              ['Hospitalizaciones Recientes', 'Ninguna desde 2021'],
            ]),
            const SizedBox(height: 36),
            _sectionTitle('Historial Familiar'),
            const SizedBox(height: 12),
            _infoGrid(isMobile, const [
              ['Enfermedades Hereditarias', 'Diabetes (padre)'],
              ['Antecedentes de Cáncer', 'Cáncer de mama (abuela materna)'],
              ['Otras Condiciones', 'Hipertensión (madre)'],
            ]),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Medicamentos Actuales'),
            const SizedBox(height: 12),
            _infoGrid(isMobile, const [
              ['Montelukast 10 mg', '1 tableta cada noche'],
              ['Salbutamol inhalador', '2 inhalaciones según necesidad'],
              ['Vitamina D', '1 cápsula semanal'],
            ]),
            const SizedBox(height: 24),
            _sectionTitle('Indicaciones'),
            const SizedBox(height: 12),
            _infoGrid(isMobile, const [
              ['Seguimiento', 'Control pulmonar cada 6 meses'],
              ['Recomendaciones', 'Evitar alérgenos ambientales'],
            ]),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Alergias Registradas'),
            const SizedBox(height: 12),
            _infoGrid(isMobile, const [
              ['Penicilina', 'Reacción cutánea moderada'],
              ['Polen de álamo', 'Estornudos y lagrimeo'],
              ['Polvo doméstico', 'Causa episodios leves de asma'],
            ]),
            const SizedBox(height: 24),
            _sectionTitle('Tratamiento Preventivo'),
            const SizedBox(height: 12),
            _infoGrid(isMobile, const [
              ['Inmunoterapia', 'Sesiones mensuales (2023-actualidad)'],
              ['Uso de purificador de aire', 'Habitación y sala'],
            ]),
          ],
        );
      case 3:
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Consultas Anteriores'),
            const SizedBox(height: 12),
            _infoGrid(isMobile, const [
              ['12 Feb 2024', 'Control general - síntomas estables'],
              ['03 Oct 2023', 'Revisión pulmonar - ajuste de inhalador'],
              ['18 Jun 2023', 'Consulta de alergias estacionales'],
            ]),
            const SizedBox(height: 24),
            _sectionTitle('Próximas Citas'),
            const SizedBox(height: 12),
            _infoGrid(isMobile, const [
              ['24 Feb 2025', 'Chequeo anual de control de asma'],
            ]),
          ],
        );
    }
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
