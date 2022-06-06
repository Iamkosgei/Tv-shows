import 'package:flutter/material.dart';
import 'package:flutter_tv_shows/configs/colors.dart';

class PrimaryTextFormField extends StatefulWidget {
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final void Function(String?) onChanged;
  const PrimaryTextFormField({
    Key? key,
    required this.labelText,
    required this.onChanged,
    required this.keyboardType,
    this.obscureText = false,
  }) : super(key: key);

  @override
  State<PrimaryTextFormField> createState() => _PrimaryTextFormFieldState();
}

class _PrimaryTextFormFieldState extends State<PrimaryTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      autocorrect: false,
      style: const TextStyle(color: Colors.white),
      obscureText: widget.obscureText ? _obscureText : widget.obscureText,
      decoration: InputDecoration(
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  _obscureText = !_obscureText;
                  setState(() {});
                },
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
              )
            : null,
        labelText: widget.labelText,
        labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: Colors.white,
            ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: grey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        counter: const SizedBox.shrink(),
      ),
      onChanged: (value) {
        widget.onChanged(value);
      },
    );
  }
}
