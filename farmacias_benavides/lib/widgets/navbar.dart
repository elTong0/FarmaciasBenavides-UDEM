import 'package:flutter/material.dart';

import '../dashboard_page.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;

  const Navbar({
    super.key,
    required this.userName,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.5,
      backgroundColor: Colors.white,
      titleSpacing: 24,
      title: Row(
        children: [
          Image.asset(
            'assets/images/Farmacia-Benavides-Logo.png',
            height: 40,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.local_pharmacy,
              color: Color(0xFFB61B2E),
            ),
          ),
          const SizedBox(width: 30),
          _navItem(context, 'Inicio', onTap: () => _navigateHome(context)),
          _navItem(context, 'Pacientes'),
          _navItem(context, 'Citas'),
          _navItem(context, 'Recetas'),
          const Spacer(),
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/Doctor.jpg'),
                radius: 18,
              ),
              const SizedBox(width: 10),
              Text(
                userName,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => DashboardPage(userName: userName),
      ),
      (route) => false,
    );
  }

  Widget _navItem(BuildContext context, String title,
      {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: MouseRegion(
        cursor: onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            title,
            style: TextStyle(
              color: onTap != null ? Colors.black87 : Colors.black54,
              fontSize: 15,
              fontWeight: onTap != null ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
