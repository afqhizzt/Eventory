import 'package:flutter/material.dart';

class SignUpFormField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final bool isEmail;
  final double height;
  final double labelFontSize;
  final double textIndent;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const SignUpFormField({
    Key? key,
    required this.label,
    this.isPassword = false,
    this.isEmail = false,
    this.height = 10,
    this.labelFontSize = 12,
    this.textIndent = 8,
    required this.validator,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      obscureText: isPassword,
      controller: controller,
      style: TextStyle(
        color: Colors.grey[800],
        fontFamily: 'NotoSans-Thin',
        fontSize: 13,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey[800],
          fontSize: labelFontSize,
        ),
        contentPadding:
            EdgeInsets.fromLTRB(textIndent, height / 4, 0, height / 4),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      cursorColor: Colors.black,
      validator: validator,
    );
  }
}

class DropDownFormField extends StatefulWidget {
  final String label;
  final List<String> items;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onChanged;

  const DropDownFormField({
    Key? key,
    required this.label,
    required this.items,
    required this.validator,
    required this.onChanged,
  }) : super(key: key);

  @override
  _DropDownFormFieldState createState() => _DropDownFormFieldState();
}

class _DropDownFormFieldState extends State<DropDownFormField> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[200],
      ),
      child: DropdownButtonFormField<String>(
        dropdownColor: Color.fromARGB(255, 255, 255, 255),
        value: selectedValue,
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'NotoSans-Thin',
                fontSize: 13,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue;
          });
          widget.onChanged?.call(newValue);
        },
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: Colors.grey[800],
            fontSize: 12,
          ),
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: widget.validator,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'NotoSans-Thin',
          fontSize: 13,
        ),
      ),
    );
  }
}

class SignInFormField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final double height;
  final double labelFontSize;
  final double textIndent;
  final TextEditingController controller;

  const SignInFormField({
    Key? key,
    required this.label,
    this.isPassword = false,
    this.height = 10,
    this.labelFontSize = 12,
    this.textIndent = 8,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      obscureText: isPassword,
      style: TextStyle(
        color: Colors.grey[800],
        fontFamily: 'NotoSans-Thin',
        fontSize: 13,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey[800],
          fontSize: labelFontSize,
        ),
        contentPadding:
            EdgeInsets.fromLTRB(textIndent, height / 4, 0, height / 4),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      cursorColor: Colors.black,
    );
  }
}
