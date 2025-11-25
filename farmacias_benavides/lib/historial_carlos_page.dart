import 'package:flutter/material.dart';

import 'widgets/navbar.dart';

class HistorialMedicoCarlosPage extends StatefulWidget {
  final String userName;
  const HistorialMedicoCarlosPage({
    super.key,
    required this.userName,
  });

  @override
  State<HistorialMedicoCarlosPage> createState() =>
      _HistorialMedicoCarlosPageState();
}

class _HistorialMedicoCarlosPageState
    extends State<HistorialMedicoCarlosPage> {
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
              ['Hospitalizaciones', 'Observación por hipertensión (2018)'],
            ]),
            const SizedBox(height: 36),
            _sectionTitle('Estilo de Vida'),
            const SizedBox(height: 12),
            _infoGrid(isMobile, const [
              ['Actividad Física', 'Corre 3 veces por semana'],
              ['Consumo de Alcohol', 'Ocasional'],
              ['Tabaquismo', 'No fumador'],
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
              ['Lisinopril 10 mg', '1 tableta cada mañana'],
              ['Aspirina 81 mg', '1 tableta diaria con alimentos'],
              ['Omega-3', '2 cápsulas al día'],
            ]),
            const SizedBox(height: 24),
            _sectionTitle('Monitoreo'),
            const SizedBox(height: 12),
            _infoGrid(isMobile, const [
              ['Presión arterial', 'Promedio 125/80 mmHg en casa'],
              ['Seguimiento', 'Control mensual con cardiólogo'],
              ['Indicaciones', 'Reducir consumo de sodio y azúcares'],
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
              ['Penicilina', 'Reacción cutánea leve en 2016'],
              ['Mariscos', 'Irritación estomacal moderada'],
              ['Polen', 'Congestión nasal en primavera'],
            ]),
            const SizedBox(height: 24),
            _sectionTitle('Medidas Preventivas'),
            const SizedBox(height: 12),
            _infoGrid(isMobile, const [
              ['EpiPen', 'Disponible en botiquín personal'],
              ['Dieta', 'Evita mariscos y productos derivados'],
              ['Antihistamínicos', 'Cetirizina 10 mg según necesidad'],
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
              ['10 Ene 2024', 'Control de hipertensión, sin cambios'],
              ['15 Ago 2023', 'Chequeo general, colesterol en rango'],
              ['22 Mar 2023', 'Evaluación de estrés laboral'],
            ]),
            const SizedBox(height: 24),
            _sectionTitle('Próximas Citas'),
            const SizedBox(height: 12),
            _infoGrid(isMobile, const [
              ['05 Mar 2025', 'Consulta cardiología preventiva'],
              ['18 Jul 2025', 'Examen general anual'],
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
