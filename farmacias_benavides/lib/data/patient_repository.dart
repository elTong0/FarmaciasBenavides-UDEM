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

  PatientRecord getRecord(String id) {
    return _records[id]?.copy() ?? _records.values.first.copy();
  }

  void updateRecord(String id, PatientRecord record) {
    _records[id] = record.copy();
  }
}

