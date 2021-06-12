import '../entities/entities.dart';

abstract class LoadCurrentUser {
  Future<UserEntity> load();
}
