abstract class DeepLinks {
  static const String verify =
          'https://brightminds.runasp.net${DeepPath.verify}',
      resetPassword = 'https://brightminds.runasp.net${DeepPath.resetPassword}';
}

abstract class DeepPath {
  static const String verify = '/verify', resetPassword = '/reset-password';
}
