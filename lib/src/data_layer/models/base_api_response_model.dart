import 'package:loginapp/src/business_layer/network/exception_type.dart';

class BaseApiResponseModel {
  BaseApiResponseModel(
      {this.exceptionType = ExceptionType.noException, this.data});
  ExceptionType exceptionType;
  dynamic data;
}
