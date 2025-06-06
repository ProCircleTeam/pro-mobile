import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AgreementCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const AgreementCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<AgreementCheckbox> createState() => _AgreementCheckboxState();
}

class _AgreementCheckboxState extends State<AgreementCheckbox> {
  final TapGestureRecognizer _termsRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _privacyRecognizer = TapGestureRecognizer();

  @override
  void dispose() {
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: widget.value,
          onChanged: widget.onChanged,
          activeColor: Colors.blue.shade900,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black87, fontSize: 14),
              children: [
                const TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'terms & conditions',
                  style: const TextStyle(color: Colors.blue),
                  recognizer: _termsRecognizer
                    ..onTap = () {
                      print('Tapped terms & conditions');
                    },
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'privacy policy',
                  style: const TextStyle(color: Colors.blue),
                  recognizer: _privacyRecognizer
                    ..onTap = () {
                      print('Tapped privacy policy');
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
