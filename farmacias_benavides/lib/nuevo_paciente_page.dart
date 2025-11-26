import 'package:flutter/material.dart';

import 'data/patient_repository.dart';
import 'widgets/navbar.dart';

class NuevoPacientePage extends StatefulWidget {
  final String userName;
  const NuevoPacientePage({super.key, required this.userName});

  @override
  State<NuevoPacientePage> createState() => _NuevoPacientePageState();
}

class _NuevoPacientePageState extends State<NuevoPacientePage> {
  final _formKey = GlobalKey<FormState>();

  final _nombreCtrl = TextEditingController();
  final _idCtrl = TextEditingController();
  final _fechaCtrl = TextEditingController();
  final _generoCtrl = TextEditingController(text: 'Femenino');
  final _direccionCtrl = TextEditingController();
  final _telefonoCtrl = TextEditingController();
  final _correoCtrl = TextEditingController();
  final _curpCtrl = TextEditingController();
  final _ocupacionCtrl = TextEditingController();
  final _antecedentesCtrl = TextEditingController();
  final _historialNotasCtrl = TextEditingController();
  final _alergiasCtrl = TextEditingController();
  final _enfermedadesCtrl = TextEditingController();
  final _medicamentosCtrl = TextEditingController();
  final _cirugiasCtrl = TextEditingController();
  final _vacunasCtrl = TextEditingController();

  String _grupoSanguineo = 'O+';

  bool _hoverGuardar = false;
  bool _hoverCancelar = false;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _idCtrl.dispose();
    _fechaCtrl.dispose();
    _generoCtrl.dispose();
    _direccionCtrl.dispose();
    _telefonoCtrl.dispose();
    _correoCtrl.dispose();
    _curpCtrl.dispose();
    _ocupacionCtrl.dispose();
    _antecedentesCtrl.dispose();
    _historialNotasCtrl.dispose();
    _alergiasCtrl.dispose();
    _enfermedadesCtrl.dispose();
    _medicamentosCtrl.dispose();
    _cirugiasCtrl.dispose();
    _vacunasCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borde = OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFE0BFC4)),
      borderRadius: BorderRadius.circular(6),
    );

    return Scaffold(
      appBar: Navbar(userName: widget.userName),
      backgroundColor: const Color(0xFFFCF7F9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Nuevo historial médico',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E0D0C),
                        ),
                      ),
                      Icon(Icons.medical_information_outlined,
                          color: Color(0xFFB61B2E)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildTextField('Nombre completo', _nombreCtrl, borde),
                  _buildTextField('Identificador (único)', _idCtrl, borde),
                  _buildTextField('CURP', _curpCtrl, borde),
                  _buildTextField('Fecha de nacimiento', _fechaCtrl, borde),
                  _buildTextField('Género', _generoCtrl, borde),
                  _buildDropdown(
                    label: 'Grupo sanguíneo',
                    value: _grupoSanguineo,
                    items: const [
                      'O+',
                      'O-',
                      'A+',
                      'A-',
                      'B+',
                      'B-',
                      'AB+',
                      'AB-'
                    ],
                    onChanged: (val) =>
                        setState(() => _grupoSanguineo = val ?? 'O+'),
                  ),
                  _buildTextField('Dirección', _direccionCtrl, borde),
                  _buildTextField('Teléfono', _telefonoCtrl, borde),
                  _buildTextField('Correo electrónico', _correoCtrl, borde),
                  _buildTextField('Ocupación', _ocupacionCtrl, borde),
                  _buildTextField('Antecedentes familiares', _antecedentesCtrl,
                      borde,
                      multiline: true),
                  _buildTextField('Notas de historial familiar',
                      _historialNotasCtrl, borde,
                      multiline: true),
                  _buildTextField(
                      'Alergias', _alergiasCtrl, borde,
                      multiline: true),
                  _buildTextField(
                      'Enfermedades crónicas', _enfermedadesCtrl, borde,
                      multiline: true),
                  _buildTextField('Medicamentos actuales', _medicamentosCtrl,
                      borde,
                      multiline: true),
                  _buildTextField(
                      'Cirugías previas', _cirugiasCtrl, borde,
                      multiline: true),
                  _buildTextField('Vacunas', _vacunasCtrl, borde,
                      multiline: true),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _hoverButton(
                        hover: _hoverCancelar,
                        label: 'Cancelar',
                        background: const Color(0xFFF4EAEA),
                        hoverColor: const Color(0xFFD7C7C6),
                        textColor: const Color(0xFF2E0D0C),
                        onHover: (hover) =>
                            setState(() => _hoverCancelar = hover),
                        onTap: () => Navigator.pop(context, false),
                      ),
                      _hoverButton(
                        hover: _hoverGuardar,
                        label: 'Guardar',
                        background: const Color(0xFFD52F45),
                        hoverColor: const Color(0xFFC82A3E),
                        textColor: Colors.white,
                        onHover: (hover) =>
                            setState(() => _hoverGuardar = hover),
                        onTap: _savePatient,
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _hoverButton({
    required bool hover,
    required String label,
    required Color background,
    required Color hoverColor,
    required Color textColor,
    required ValueChanged<bool> onHover,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      cursor: SystemMouseCursors.click,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: hover ? hoverColor : background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _savePatient() {
    if (!_formKey.currentState!.validate()) return;

    final repo = PatientRepository.instance;
    final name = _nombreCtrl.text.trim();
    var id = _idCtrl.text.trim().toLowerCase();
    if (id.isEmpty) {
      id = name
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
          .replaceAll(RegExp('_+'), '_')
          .replaceAll(RegExp(r'^_|_$'), '');
    }
    if (id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Define un ID válido para el paciente.')),
      );
      return;
    }
    if (repo.exists(id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ya existe un paciente con ese ID.')),
      );
      return;
    }

    final details = PatientDetails(
      id: id,
      nombre: name,
      fechaNacimiento: _fechaCtrl.text.trim(),
      genero: _generoCtrl.text.trim(),
      grupoSanguineo: _grupoSanguineo,
      direccion: _direccionCtrl.text.trim(),
      telefono: _telefonoCtrl.text.trim(),
      correo: _correoCtrl.text.trim(),
      curp: _curpCtrl.text.trim(),
      ocupacion: _ocupacionCtrl.text.trim(),
      antecedentesFamiliares: _antecedentesCtrl.text.trim(),
      historialFamiliarNotas: _historialNotasCtrl.text.trim(),
    );

    final record = PatientRecord(
      tipoSangre: _grupoSanguineo,
      alergias: _alergiasCtrl.text.trim(),
      enfermedadesCronicas: _enfermedadesCtrl.text.trim(),
      medicamentosActuales: _medicamentosCtrl.text.trim(),
      cirugiasPrevias: _cirugiasCtrl.text.trim(),
      vacunas: _vacunasCtrl.text.trim(),
    );

    repo.addPatient(details: details, record: record);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Paciente registrado correctamente.')),
    );
    Navigator.pop(context, true);
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    OutlineInputBorder borde, {
    bool multiline = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            maxLines: multiline ? 4 : 1,
            validator: (value) {
              if ((value ?? '').trim().isEmpty) {
                return 'Completa este campo';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: label,
              hintStyle: const TextStyle(
                color: Color(0xFFB48B90),
              ),
              enabledBorder: borde,
              focusedBorder: borde,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    final borde = OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFE0BFC4)),
      borderRadius: BorderRadius.circular(6),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: value,
            decoration: InputDecoration(
              enabledBorder: borde,
              focusedBorder: borde,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
            items: items
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

