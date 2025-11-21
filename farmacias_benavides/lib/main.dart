import 'package:flutter/material.dart';
import 'dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmacias Benavides',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFDA291C),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // Obtener el nombre de usuario (si está vacío, usar un valor por defecto)
    final userName = _usuarioController.text.trim().isEmpty
        ? 'Usuario'
        : _usuarioController.text.trim();

    // Navegar al dashboard pasando el nombre de usuario
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => DashboardPage(userName: userName),
      ),
    );
  }

  @override
  void dispose() {
    _usuarioController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F9),
      body: Center(
        child: Container(
          width: screenWidth * 0.85,
          constraints: const BoxConstraints(maxWidth: 900),
          padding: const EdgeInsets.all(20),
          child: isMobile
              ? _buildMobileLayout()
              : _buildDesktopLayout(),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: _buildLoginForm(),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 1,
          child: _buildLogo(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLoginForm(),
        const SizedBox(height: 30),
        _buildLogo(),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Iniciar sesión',
          style: TextStyle(
            color: Color(0xFF2B1B1B),
            fontSize: 27.2, // 1.7rem aproximado
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF2E8E8),
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextField(
            controller: _usuarioController,
            decoration: InputDecoration(
              hintText: 'Usuario',
              hintStyle: const TextStyle(
                color: Color(0xFF994D59),
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12.5,
              ),
            ),
            style: const TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF2E8E8),
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Contraseña',
              hintStyle: const TextStyle(
                color: Color(0xFF994D59),
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12.5,
              ),
            ),
            style: const TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 45,
          child: ElevatedButton(
            onPressed: _login,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDA291C),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Iniciar Sesión',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            // Acción para recuperar contraseña
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            '¿Olvidaste tu contraseña?',
            style: TextStyle(
              color: Color(0xFFB71C1C),
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Image.asset(
        'assets/images/Farmacia-Benavides-Logo.png',
        fit: BoxFit.contain,
        width: 300,
        height: 300,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Error cargando imagen: $error');
          debugPrint('Stack trace: $stackTrace');
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.local_pharmacy,
                size: 200,
                color: Color(0xFFDA291C),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error cargando imagen\nVer consola para detalles',
                  style: const TextStyle(fontSize: 12, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
