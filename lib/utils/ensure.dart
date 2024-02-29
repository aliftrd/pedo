class EnsureSafe {
  static String safeEmail(String email) {
    return email.replaceRange(2, email.indexOf("@") - 1, '****');
  }
}
