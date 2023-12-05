import 'package:reports/data/network/requests.dart';
import 'package:reports/data/response/responses.dart';

import '../network/app_api.dart';


abstract class RemoteDataSource {
  Future<LoginAuthenticationResponse> loginResponse(
    LoginRequest loginRequest,
  );


  // Future<void> sendEmailResponse(String email);

  // Future<RestPasswordResponse> restPasswordResponse(RestPasswordRequest restPasswordRequest);

// Future<StoresDetailsResponse>storeDetailsResponse();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final AppServicesClient _appServicesClient;
  RemoteDataSourceImpl(this._appServicesClient);

  @override
  Future<LoginAuthenticationResponse> loginResponse(LoginRequest loginRequest) async {
    return await _appServicesClient.login(loginRequest.email, loginRequest.password);
  }



// forgot password
 /* @override
  Future<void> sendEmailResponse(String email) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }*/

  // @override
  // Future<RestPasswordResponse> restPasswordResponse(RestPasswordRequest restPasswordRequest) async {
  //   return await
  // }

  // @override
  // Future<DocumentSnapshot> dashboardResponse() async {
  //   return await _appServicesClient.dashboard();
  // }
// @override
// Future<StoresDetailsResponse> storeDetailsResponse()async {
//   return await _appServicesClient.getStoreDetails();
// }
}
