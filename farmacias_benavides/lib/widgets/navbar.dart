import 'package:flutter/material.dart';

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
          _navItem('Inicio'),
          _navItem('Pacientes'),
          _navItem('Citas'),
          _navItem('Recetas'),
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

  Widget _navItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
