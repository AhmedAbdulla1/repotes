class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class DoctorData {
  int id;
  String username;
  String image;

  // String location;
  bool isLive;
  bool isLiked;
  int views;
  String avgRating;
  int price;
  String specialist;

  DoctorData({
    required this.id,
    // required this.email,
    required this.username,
    // required this.phoneNumber,
    required this.image,
    // required this.location,
    required this.specialist,
    required this.isLive,
    required this.isLiked,
    required this.price,
    required this.avgRating,
    required this.views,
  });
}

class UserData {
  String username;
  String email;
  String bodyWeight;
  String image;
  String height;
  String age;
  String gender;

  UserData({
    required this.email,
    required this.username,
    required this.image,
    required this.age,
    required this.bodyWeight,
    required this.height,
    required this.gender,
  });
}

class Authentication {
  UserData? userData;
  String token;

  Authentication({
    required this.userData,
    required this.token,
  });
}

class LoginAuthentication {
  int id;
  String token;

  LoginAuthentication({
    required this.id,
    required this.token,
  });
}

// restPassword
class SendEmail {
  String otp;
  String message;

  SendEmail({
    required this.otp,
    required this.message,
  });
}

// home model
class Home {
  UserData? userData;
  // List<DoctorData>? liveDoctors;
  // List<DoctorData>? popularDoctors;
  // List<FeatureDoctor>? featureDoctors;

  Home({
    required this.userData,
    // required this.liveDoctors,
    // required this.popularDoctors,
    // required this.featureDoctors,
  });
}

class FeatureDoctor {
  DoctorData? featureDoctors;

  FeatureDoctor({required this.featureDoctors});
}
