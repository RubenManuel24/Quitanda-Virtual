import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isSecret;
  List<TextInputFormatter>? textInputFormatter;
  final String? initialValue;
  final bool readOly;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final TextInputType?  textInputType;
  final GlobalKey<FormFieldState>? formFieldKey;
  

  CustomTextField({
    Key? key,
    required this.label,
    required this.icon,
    this.isSecret = false,
    this.textInputFormatter, 
    this.initialValue, 
    this.readOly = false, 
    this.validator,
    this.onSaved,
    this.controller,
    this.textInputType,
    this.formFieldKey
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

   bool isobscrre = false;

   @override
  void initState() {
    super.initState();
    isobscrre = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
                key: widget.formFieldKey,
                keyboardType: widget.textInputType,
                controller: widget.controller,
                readOnly: widget.readOly,
                initialValue: widget.initialValue,
                onSaved: widget.onSaved,
                inputFormatters: widget.textInputFormatter,
                obscureText: isobscrre,
                validator: widget.validator,
                decoration: InputDecoration( 
                    prefixIcon: Icon(widget.icon),
                    suffixIcon: widget.isSecret ? IconButton(
                      color: Colors.green, 
                      icon: Icon(isobscrre ? Icons.visibility_off : Icons.visibility),
                      onPressed:(){
                        setState(() {
                          isobscrre = !isobscrre;
                        });
                      }
                    ) : null,
                    label: Text(widget.label),
                    isDense: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18)
                    ),
                ),
              ),
    );
  }
}