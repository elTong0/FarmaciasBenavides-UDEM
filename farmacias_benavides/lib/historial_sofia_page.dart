import 'package:flutter/material.dart';

import 'data/patient_repository.dart';
import 'antecedentes_medicos_page.dart';
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
  late PatientRecord _record;
  late PatientDetails _details;

  @override
  void initState() {
    super.initState();
    _loadRecord();
  }

  void _loadRecord() {
    final repo = PatientRepository.instance;
    _record = repo.getRecord('sofia');
    _details = repo.getDetails('sofia');
  }

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
            _infoGrid(isMobile, [
              ['Nombre', _details.nombre],
              ['Fecha de Nacimiento', _details.fechaNacimiento],
              ['Género', _details.genero],
              ['Grupo Sanguíneo', _record.tipoSangre],
              ['Dirección', _details.direccion],
              ['Teléfono', _details.telefono],
              ['Correo Electrónico', _details.correo],
              ['CURP', _details.curp],
              ['Ocupación', _details.ocupacion],
            ]),
            const SizedBox(height: 36),
            _sectionTitle(
              'Antecedentes Médicos',
              onEdit: _openAntecedentesMedicos,
            ),
            const SizedBox(height: 12),
            _infoGrid(isMobile, [
              ['Enfermedades Crónicas', _record.enfermedadesCronicas],
              ['Cirugías Previas', _record.cirugiasPrevias],
              ['Vacunas', _record.vacunas],
            ]),
            const SizedBox(height: 36),
            _sectionTitle('Historial Familiar'),
            const SizedBox(height: 12),
            _infoGrid(isMobile, [
              ['Enfermedades Hereditarias', _details.antecedentesFamiliares],
              ['Antecedentes de Cáncer', 'Cáncer de mama (abuela materna)'],
              ['Otras Condiciones', _details.historialFamiliarNotas],
            ]),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Medicamentos Actuales'),
            const SizedBox(height: 12),
            _infoGrid(isMobile, [
              ['Medicamento principal', _record.medicamentosActuales],
              ['Inhalador de rescate', 'Salbutamol según necesidad'],
              ['Suplementos', 'Vitamina D - 1 cápsula semanal'],
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
            _infoGrid(isMobile, [
              ['Alergia principal', _record.alergias],
              ['Polvo doméstico', 'Causa episodios leves de asma'],
              ['Polen de álamo', 'Estornudos y lagrimeo'],
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

  Future<void> _openAntecedentesMedicos() async {
    final updated = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => AntecedentesMedicosPage(
          userName: widget.userName,
          patientName: 'Sofía Ramírez',
          patientId: 'sofia',
        ),
      ),
    );
    if (updated == true) {
      setState(() {
        _loadRecord();
      });
    }
  }

  Widget _sectionTitle(String title, {VoidCallback? onEdit}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF2E0D0C),
          ),
        ),
        if (onEdit != null)
          IconButton(
            tooltip: 'Editar $title',
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined, color: Color(0xFFB61B2E)),
          ),
      ],
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
