import 'package:flutter/material.dart';

import 'data/patient_repository.dart';
import 'historial_carlos_page.dart';
import 'historial_generico_page.dart';
import 'historial_sofia_page.dart';
import 'widgets/navbar.dart';
import 'widgets/paciente_item.dart';

class ResultadosBusquedaPage extends StatelessWidget {
  final String query;
  final String userName;

  const ResultadosBusquedaPage({
    super.key,
    required this.query,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final repo = PatientRepository.instance;
    final resultados = repo.searchSummaries(query);

    return Scaffold(
      appBar: Navbar(userName: userName),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Resultados de Búsqueda',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E0D0C),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  resultados.isEmpty
                      ? 'No se encontraron pacientes para "$query".'
                      : 'Se encontraron ${resultados.length} paciente(s) que coinciden con su búsqueda.',
                  style: const TextStyle(color: Color(0xFF934E51)),
                ),
                const SizedBox(height: 40),
                if (resultados.isEmpty)
                  const Text(
                    'Prueba con otro nombre o ID.',
                    style: TextStyle(color: Color(0xFF934E51)),
                  )
                else
                  ...resultados.map(
                    (p) {
                      final canNavigate = _hasDetailPage(p.id);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 28.0),
                        child: PacienteItem(
                          nombre: p.nombre,
                          fecha: p.fecha,
                          isMobile: isMobile,
                          onSelect: canNavigate
                              ? () =>
                                  _navigateToPatientDetail(context, p.id, p.nombre)
                              : null,
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToPatientDetail(
    BuildContext context,
    String patientId,
    String nombre,
  ) {
    late final Widget destination;
    if (patientId == 'sofia') {
      destination = HistorialMedicoSofiaPage(userName: userName);
    } else if (patientId == 'carlos') {
      destination = HistorialMedicoCarlosPage(userName: userName);
    } else {
      destination = HistorialMedicoGenericoPage(
        userName: userName,
        patientId: patientId,
      );
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  bool _hasDetailPage(String id) {
    return PatientRepository.instance.exists(id);
  }
}
