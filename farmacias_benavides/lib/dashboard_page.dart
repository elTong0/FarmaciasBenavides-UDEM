import 'package:flutter/material.dart';

// Colores base
const Color primaryColor = Color(0xFFB61B2E);
const Color backgroundColor = Color(0xFFFFF9FA);
const Color searchColor = Color(0xFFF4EAEA);
const Color textColor = Color(0xFF3B3B3B);

class DashboardPage extends StatelessWidget {
  final String userName;

  const DashboardPage({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopNavBar(),
            const SizedBox(height: 30),
            _buildSearchBar(),
            const SizedBox(height: 40),
            _buildRecentPatients(),
            const SizedBox(height: 50),
            _buildQuickAccess(context),
          ],
        ),
      ),
    );
  }

  // Barra superior
  Widget _buildTopNavBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Row(
        children: [
          Image.asset(
            'assets/images/Farmacia-Benavides-Logo.png',
            height: 40,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.local_pharmacy,
                size: 40,
                color: primaryColor,
              );
            },
          ),
          const SizedBox(width: 40),
          _buildNavItem("Inicio"),
          _buildNavItem("Pacientes"),
          _buildNavItem("Recetas"),
          _buildNavItem("Citas"),
          const Spacer(),
          Container(
            height: 38,
            width: 160,
            decoration: BoxDecoration(
              color: searchColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                SizedBox(width: 10),
                Icon(Icons.search, color: primaryColor, size: 18),
                SizedBox(width: 5),
                Text("Search", style: TextStyle(color: primaryColor)),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // Mostrar nombre de usuario con avatar
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://randomuser.me/api/portraits/women/44.jpg'),
                radius: 19,
              ),
              const SizedBox(width: 10),
              Text(
                userName,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  // Barra de búsqueda
  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 80),
      decoration: BoxDecoration(
        color: searchColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Buscar paciente por nombre o ID',
          hintStyle: TextStyle(color: Color(0xFFB67A7A)),
          prefixIcon: Icon(Icons.search, color: primaryColor),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  // Sección de pacientes
  Widget _buildRecentPatients() {
    final patients = [
      {'name': 'Sofía Rodríguez', 'date': '15 de Mayo, 2024'},
      {'name': 'Carlos Pérez', 'date': '20 de Abril, 2024'},
      {'name': 'Ana García', 'date': '10 de Marzo, 2024'},
      {'name': 'Luis Martínez', 'date': '5 de Febrero, 2024'},
      {'name': 'María López', 'date': '2 de Enero, 2024'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Pacientes Recientes",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w600, color: textColor)),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEDD9D9)),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withValues(alpha: 0.5),
            ),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1.2),
              },
              border: const TableBorder(
                horizontalInside:
                    BorderSide(color: Color(0xFFEDD9D9), width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              children: [
                const TableRow(
                  decoration: BoxDecoration(color: Colors.transparent),
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Text("Nombre del Paciente",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: textColor)),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Text("Fecha de Última Consulta",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: textColor)),
                    ),
                  ],
                ),
                ...patients.map((p) {
                  return TableRow(
                    children: [
                      _hoverableCell(p['name']!),
                      _hoverableCell(p['date']!, alignRight: true),
                    ],
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hoverableCell(String text, {bool alignRight = false}) {
    return MouseRegion(
      onEnter: (_) {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Text(
          text,
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }

  // Acceso rápido
  Widget _buildQuickAccess(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Acceso Rápido",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700, color: textColor)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Nuevo Paciente"),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: textColor,
                    side: const BorderSide(color: Color(0xFFD9CACA)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: const Color(0xFFF8EEEE),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 14),
                  ),
                  child: const Text("Ver Historial"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

