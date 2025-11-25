import 'package:flutter/material.dart';

class PacienteItem extends StatefulWidget {
  final String nombre;
  final String fecha;
  final bool isMobile;
  final VoidCallback? onSelect;
  const PacienteItem({
    super.key,
    required this.nombre,
    required this.fecha,
    required this.isMobile,
    this.onSelect,
  });

  @override
  State<PacienteItem> createState() => _PacienteItemState();
}

class _PacienteItemState extends State<PacienteItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final actionButton = _buildActionButton();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: widget.isMobile
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF2E0D0C),
                  ),
                ),
                Text(
                  'Fecha de Nacimiento: ${widget.fecha}',
                  style: const TextStyle(
                    color: Color(0xFF934E51),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            if (!widget.isMobile) actionButton,
          ],
        ),
        if (widget.isMobile) ...[
          const SizedBox(height: 16),
          actionButton,
        ],
      ],
    );
  }

  Widget _buildActionButton() {
    final isEnabled = widget.onSelect != null;
    return MouseRegion(
      onEnter: (_) {
        if (isEnabled) setState(() => _isHovered = true);
      },
      onExit: (_) {
        if (isEnabled) setState(() => _isHovered = false);
      },
      cursor: isEnabled ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: widget.onSelect,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: _isHovered && isEnabled
                ? const Color(0xFFDCCBC9)
                : const Color(0xFFF5EDED),
            borderRadius: BorderRadius.circular(8),
            boxShadow: _isHovered && isEnabled
                ? const [BoxShadow(color: Colors.black26, blurRadius: 4)]
                : const [],
          ),
          child: Text(
            'Seleccionar Paciente',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              decoration:
                  isEnabled ? TextDecoration.none : TextDecoration.lineThrough,
              color:
                  isEnabled ? const Color(0xFF2E0D0C) : Colors.black45,
            ),
          ),
        ),
      ),
    );
  }
}
