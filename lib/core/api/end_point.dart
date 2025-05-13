abstract class EndPoint {
  static const String baseUrl = 'https://brightminds.runasp.net',
      postLogin = '/api/Account/login',
      postRegister = '/api/Account/register',
      postAuthentication = '/api/Account/authnticate-email',
      postConfirm = '/api/Account/confirm-email',
      postForgotPass = '/api/Account/forget-password',
      postResetPass = '/api/Account/reset-password',
      getInstructors = '/api/Instructor',
      putUserEdit = '/api/Account',
      putChangePass = '/api/Account/changepassword',
      postAddToCart = '/api/Cart',
      getCart = '/api/Cart',
      postCheckOut = '/api/Payment/checkout',
      getCourses = '/api/Course',
      getUserCourses = '/api/Course/usercourses',
      getUser = '/api/Account/UserProfile',
      postFeedBack = '/api/Feedback';

  static String deletAccount(String userId) {
    return '/api/Account/$userId';
  }

  static String getSections(int courseId) {
    return '/api/Section/course/$courseId';
  }

  static String getCourseWhitId(String courseId) {
    return '/api/Course/$courseId';
  }

  static String getVideos(int sectionId) {
    return '/api/Video/section/$sectionId';
  }

  static String deleteFromCart(int courseId) {
    return '/api/Cart/$courseId';
  }
}

abstract class ApiKey {
  static final String statusCode = 'statusCode',
      errors = 'errors',
      message = 'message',
      token = 'token',
      email = 'email',
      password = 'password',
      confirmPass = 'confirmPassword',
      oldPass = 'oldPassword',
      newPass = 'newPassword',
      displayName = 'displayName',
      user = 'user',
      rEmail = 'Email',
      rPassword = 'Password',
      rConfirmPass = 'ConfirmPassword',
      rFirstName = 'FirstName',
      firstName = 'firstName',
      lastName = 'lastName',
      rLastName = 'LastName',
      rMobile = 'Mobile',
      rImage = 'Image',
      clientUrl = 'clientUrl',
      data = 'data',
      success = 'success',
      items = 'items',
      pageIndex = 'pageIndex',
      count = 'count',
      pageSize = 'pageSize',
      qualifications = 'qualifications',
      imageCover = 'imageCover',
      jobTitle = 'jobTitle',
      userId = 'userId',
      mobile = 'mobile',
      id = 'id',
      name = 'name',
      updatedDate = 'updatedDate',
      createdDate = 'createdDate',
      pictureUrl = 'pictureUrl',
      instructorName = 'instructorName',
      description = 'description',
      categoryName = 'categoryName',
      categoryId = 'categoryId',
      price = 'price',
      rate = 'rate',
      order = 'order',
      courseId = 'courseId',
      duration = 'duration',
      coverUrl = 'coverUrl',
      videoUrl = 'videoUrl',
      sectionName = 'sectionName',
      sectionId = 'sectionId',
      messaget = 'messaget',
      roles = 'roles',
      walletBalance = 'walletBalance',
      authorization = 'Authorization',
      totalPrice = 'totalPirce',
      courseName = 'courseName',
      imageUrl = 'imageUrl',
      sections = 'sections',
      basketId = 'basketId',
      url = 'url',
      rating = 'rating',
      content = 'content',
      isPaid = 'isPaid',
      paymentFailedUrl = 'paymentFailedUrl',
      paymentSucessUrl = 'paymentSucessUrl',

      // schemas
      imageNull = 'https://brightminds.runasp.net//files/UsersImages/',
      idSchema =
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier';
}
