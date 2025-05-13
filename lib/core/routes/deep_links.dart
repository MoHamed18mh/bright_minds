abstract class DeepLinks {
  static const String
      verify = 'https://brightminds.runasp.net${DeepPath.verify}',
      resetPassword = 'https://brightminds.runasp.net${DeepPath.resetPassword}',
      paymentSuccess =
          'https://brightminds.runasp.net${DeepPath.paymentSuccess}',
      paymentFailure =
          'https://brightminds.runasp.net${DeepPath.paymentFailure}';
}

abstract class DeepPath {
  static const String verify = '/verify',
      resetPassword = '/reset-password',
      paymentSuccess = '/payment-success',
      paymentFailure = '/payment-failure';
}
