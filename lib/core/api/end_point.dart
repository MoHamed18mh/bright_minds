abstract class EndPoint {
  static const String baseUrl = 'https://brightminds.runasp.net',
      postLogin = '/api/Account/login',
      postRegister = '/api/Account/register',
      postAuthentication = '/api/Account/authnticate-email',
      postConfirm = '/api/Account/confirm-email',
      postForgotPass = '/api/Account/forget-password',
      postResetPass = '/api/Account/reset-password',
      getInstructors = '/api/Instructor',
      getCourses = '/api/Course';
  static String getSections(int courseId) {
    return '/api/Section/course/$courseId';
  }

  static String getVideos(int sectionId) {
    return '/api/Video/section/$sectionId';
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
      displayName = 'displayName',
      user = 'user',
      rEmail = 'Email',
      rPassword = 'Password',
      rConfirmPass = 'ConfirmPassword',
      rFirstName = 'FirstName',
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

      // schemas
      imageNull = 'https://brightminds.runasp.net//files/UsersImages/',
      idSchema =
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier';
}
