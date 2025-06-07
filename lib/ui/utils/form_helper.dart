class FormHelper {
  String? validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (email.isEmpty) {
      return 'Email is required';
    }

    if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid email';
    }

    return null;
  }

  String? checkLength({
    required String txt,
    required String fieldname,
    required int len,
  }) {
    if (txt.length < len) {
      return "$fieldname must be greater than ${len - 1}";
    } else {
      return null;
    }
  }
}
