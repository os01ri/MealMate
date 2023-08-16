import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/user_info_response_model.dart';

abstract class UserInfoRepository {
  Future<Either<Failure, UserInfoResponseModel>> getUserInfo();
}
