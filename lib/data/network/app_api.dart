

import 'package:dio/dio.dart';
import 'package:reports/app/constant.dart';
import 'package:reports/data/response/responses.dart';
import 'package:retrofit/http.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseurl,)
abstract class  AppServicesClient{
  factory AppServicesClient(Dio dio,{String baseUrl}) =_AppServicesClient;
  @GET("api/Userstbls")
  Future<LoginAuthenticationResponse> login(
      @Query("Email") String email,
      @Query("Password") String password,
      );


  @POST("/users/sendemail/")
  Future<SendEmailResponse> forgotPassword(@Field("email") String email,);

  @POST("/users/register/")
  Future<AuthenticationResponse> register(
      @Field("username") String userName,
      @Field("email") String email,
      @Field("password") String password,
      );
  // @GET("/home")
  // Future<HomeResponse> home();
  //
  // @GET("/store_details")
  // Future<StoresDetailsResponse> getStoreDetails();

}

// body:
// email , password, username,image,phonenumber,databirth(mm/dd/yyyy),location