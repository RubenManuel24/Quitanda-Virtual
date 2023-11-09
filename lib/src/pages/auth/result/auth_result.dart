import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../models/userModels.dart';

part 'auth_result.freezed.dart';

@freezed
abstract class AuthResult with _$AuthResult {
  factory AuthResult.sucess(UserModel user) = Success;
  factory AuthResult.error(String message) = Error;
}
