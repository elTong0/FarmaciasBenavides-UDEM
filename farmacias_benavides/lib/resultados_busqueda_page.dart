import 'package:flutter/material.dart';

import 'historial_carlos_page.dart';
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

  List<Map<String, String>> get _pacientes => const [
        {'id': 'sofia', 'nombre': 'Sofía Ramírez', 'fecha': '15/03/1988'},
        {'id': 'carlos', 'nombre': 'Carlos Pérez', 'fecha': '20/04/1990'},
        {'id': 'carlos_m', 'nombre': 'Carlos Mendoza', 'fecha': '22/07/1992'},
        {'id': 'ana', 'nombre': 'Ana López', 'fecha': '10/11/1978'},
      ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final normalizedQuery = query.trim().toLowerCase();
    final resultados = normalizedQuery.isEmpty
        ? _pacientes
        : _pacientes
            .where(
              (p) => p['nombre']!
                  .toLowerCase()
                  .contains(normalizedQuery),
            )
            .toList();

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
                      final nombre = p['nombre']!;
                      final id = p['id']!;
                      final canNavigate = _hasDetailPage(id);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 28.0),
                        child: PacienteItem(
                          nombre: nombre,
                          fecha: p['fecha']!,
                          isMobile: isMobile,
                          onSelect: canNavigate
                              ? () => _navigateToPatientDetail(
                                    context,
                                    id,
                                    nombre,
                                  )
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
    Widget? destination;
    if (patientId == 'sofia') {
      destination = HistorialMedicoSofiaPage(userName: userName);
    } else if (patientId == 'carlos') {
      destination = HistorialMedicoCarlosPage(userName: userName);
    }

    final page = destination;
    if (page != null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => page),
      );
    }
  }

  bool _hasDetailPage(String id) {
    return id == 'sofia' || id == 'carlos';
  }
}
