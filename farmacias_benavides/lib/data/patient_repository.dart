class PatientRecord {
  PatientRecord({
    required this.tipoSangre,
    required this.alergias,
    required this.enfermedadesCronicas,
    required this.medicamentosActuales,
    required this.cirugiasPrevias,
    required this.vacunas,
  });

  String tipoSangre;
  String alergias;
  String enfermedadesCronicas;
  String medicamentosActuales;
  String cirugiasPrevias;
  String vacunas;

  PatientRecord copy() => PatientRecord(
        tipoSangre: tipoSangre,
        alergias: alergias,
        enfermedadesCronicas: enfermedadesCronicas,
        medicamentosActuales: medicamentosActuales,
        cirugiasPrevias: cirugiasPrevias,
        vacunas: vacunas,
      );
}

class PatientDetails {
  PatientDetails({
    required this.id,
    required this.nombre,
    required this.fechaNacimiento,
    required this.genero,
    required this.grupoSanguineo,
    required this.direccion,
    required this.telefono,
    required this.correo,
    required this.curp,
    required this.ocupacion,
    this.antecedentesFamiliares = '',
    this.historialFamiliarNotas = '',
  });

  final String id;
  String nombre;
  String fechaNacimiento;
  String genero;
  String grupoSanguineo;
  String direccion;
  String telefono;
  String correo;
  String curp;
  String ocupacion;
  String antecedentesFamiliares;
  String historialFamiliarNotas;

  PatientDetails copy() => PatientDetails(
        id: id,
        nombre: nombre,
        fechaNacimiento: fechaNacimiento,
        genero: genero,
        grupoSanguineo: grupoSanguineo,
        direccion: direccion,
        telefono: telefono,
        correo: correo,
        curp: curp,
        ocupacion: ocupacion,
        antecedentesFamiliares: antecedentesFamiliares,
        historialFamiliarNotas: historialFamiliarNotas,
      );
}

class PatientSummary {
  PatientSummary({required this.id, required this.nombre, required this.fecha});

  final String id;
  final String nombre;
  final String fecha;
}

class PatientRepository {
  PatientRepository._();

  static final PatientRepository instance = PatientRepository._();

  final Map<String, PatientRecord> _records = {
    'sofia': PatientRecord(
      tipoSangre: 'O+',
      alergias: 'Polen',
      enfermedadesCronicas: 'Asma diagnosticada en 2005',
      medicamentosActuales: 'Montelukast 10 mg',
      cirugiasPrevias: 'Apéndice (2010)',
      vacunas: 'Influenza',
    ),
    'carlos': PatientRecord(
      tipoSangre: 'A+',
      alergias: 'Penicilina',
      enfermedadesCronicas: 'Hipertensión controlada',
      medicamentosActuales: 'Lisinopril 10 mg',
      cirugiasPrevias: 'Ninguna',
      vacunas: 'COVID-19',
    ),
  };

  final Map<String, PatientDetails> _details = {
    'sofia': PatientDetails(
      id: 'sofia',
      nombre: 'Sofía Ramírez',
      fechaNacimiento: '15 de marzo de 1988',
      genero: 'Femenino',
      grupoSanguineo: 'O+',
      direccion: 'Calle Principal 123, Ciudad, Estado',
      telefono: '555-1234',
      correo: 'sofia.ramirez@email.com',
      curp: 'SARS880315MDFRMF08',
      ocupacion: 'Profesora',
      antecedentesFamiliares: 'Diabetes (padre)',
      historialFamiliarNotas: 'Cáncer de mama (abuela materna)',
    ),
    'carlos': PatientDetails(
      id: 'carlos',
      nombre: 'Carlos Pérez',
      fechaNacimiento: '20 de abril de 1990',
      genero: 'Masculino',
      grupoSanguineo: 'A+',
      direccion: 'Av. Central 456, Ciudad, Estado',
      telefono: '555-9876',
      correo: 'carlos.perez@email.com',
      curp: 'PELC900420HDFRRL05',
      ocupacion: 'Ingeniero de Sistemas',
      antecedentesFamiliares: 'Hipertensión (madre)',
      historialFamiliarNotas: 'Cáncer de colon (abuelo paterno)',
    ),
  };

  PatientRecord getRecord(String id) {
    return _records[id]?.copy() ?? _records.values.first.copy();
  }

  PatientDetails getDetails(String id) {
    return _details[id]?.copy() ?? _details.values.first.copy();
  }

  void updateRecord(String id, PatientRecord record) {
    _records[id] = record.copy();
  }

  void updateDetails(PatientDetails details) {
    _details[details.id] = details.copy();
  }

  void addPatient({
    required PatientDetails details,
    required PatientRecord record,
  }) {
    _details[details.id] = details.copy();
    _records[details.id] = record.copy();
  }

  List<PatientSummary> searchSummaries(String query) {
    final normalized = query.trim().toLowerCase();
    final entries = _details.values.where((d) {
      if (normalized.isEmpty) return true;
      return d.nombre.toLowerCase().contains(normalized) ||
          d.curp.toLowerCase().contains(normalized);
    }).map(
      (d) => PatientSummary(
        id: d.id,
        nombre: d.nombre,
        fecha: d.fechaNacimiento,
      ),
    );
    return entries.toList()
      ..sort((a, b) => a.nombre.compareTo(b.nombre));
  }

  bool exists(String id) => _details.containsKey(id);
}

