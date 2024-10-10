import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.label,
    this.initialValue,
    this.errorText,
    this.prefixIcon,
    this.enabled = true,
    this.inputFormatters,
    this.onChanged,
    this.keyboardType,
    this.isPasswordField = false,
    super.key,
  }) : assert(
          !(prefixIcon != null && !enabled),
          'Prefix icon não pode ser definido quando o campo está desabilitado.',
        );

  final String? initialValue;
  final String label;
  final String? errorText;
  final Widget? prefixIcon;
  final bool isPasswordField;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String value)? onChanged;
  final TextInputType? keyboardType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPasswordField && _isObscure ? true : false,
      decoration: InputDecoration(
        label: Text(widget.label),
        enabled: widget.enabled,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: widget.errorText != null
            ? Colors.red
            : Theme.of(context).primaryColor,
        suffixIcon: widget.isPasswordField
            ? IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                  color: widget.errorText != null
                      ? Colors.red
                      : Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              )
            : null,
      ),
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
    );
  }
}
