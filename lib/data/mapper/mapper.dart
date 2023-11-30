import 'package:reports/app/constant.dart';
import 'package:reports/app/extensions.dart';
import 'package:reports/data/response/responses.dart';
import 'package:reports/domain/models/models.dart';

extension UserDataResponseMapper on UserDataResponse? {
  UserData toDomain() {
    return UserData(
      username: this?.username.orEmpty() ?? Constant.empty,

    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        userData: this?.userData.toDomain(),
        token: this?.token.orEmpty() ?? Constant.empty);
  }
}

extension LoginAuthenticationMapper on LoginAuthenticationResponse? {
  LoginAuthentication toDomain() {
    return LoginAuthentication(
      id: this?.id.orZero() ?? Constant.zero,
      token: this?.token.orEmpty() ?? Constant.empty,
    );
  }
}


extension RestPasswordResponsMapper on RestPasswordResponse? {
  String toDomain() {
    return this?.message.orEmpty() ?? Constant.empty;
  }
}



// extension PopularDoctorsResponseMapper on PopularDoctorsResponse? {
//   DoctorData toDomain() {
//     return DoctorData(
//       id: this?.id.orZero()??Constant.zero,
//       username: this?.username.orEmpty() ?? Constant.empty,
//       image: this?.image ?? Constant.image,
//       avgRating: this?.avgRating.orEmpty()??Constant.zero.toString(),
//       isLive: this?.isLive??false,
//       isLiked: this?.isLive??false,
//       price: this?.price.orZero()??Constant.zero,
//       views: this?.views.orZero()??Constant.zero,
//       specialist: this?.specialist.orEmpty()??Constant.empty,
//     );
//   }
// }

// extension LiveDoctorResponseMapper on LiveDoctorResponse? {
//   DoctorData toDomain() {
//     return DoctorData(
//       id: this?.id.orZero()??Constant.zero,
//       username: this?.username.orEmpty() ?? Constant.empty,
//       image: this?.image ?? Constant.image,
//       avgRating: this?.avgRating.orEmpty()??Constant.zero.toString(),
//       isLive: this?.isLive??false,
//       isLiked: this?.isLive??false,
//       price: this?.price.orZero()??Constant.zero,
//       views: this?.views.orZero()??Constant.zero,
//       specialist: this?.specialist.orEmpty()??Constant.empty,
//     );
//   }
// }
//


// extension StoresDetailsResponseMapper on StoresDetailsResponse? {
//   StoresDetails toDomain() {
//     return StoresDetails(
//         id: this?.id.orZero() ?? Constant.zero,
//         image: this?.image.orEmpty() ?? Constant.image,
//         title: this?.title.orEmpty() ?? Constant.empty,
//         details: this?.details.orEmpty() ?? Constant.empty,
//         service: this?.services.orEmpty() ?? Constant.empty,
//         about: this?.about.orEmpty() ?? Constant.empty);
//   }
// }
