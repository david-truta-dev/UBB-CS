import '../../models/entity.dart';
import '../../repo/entity_repo.dart';

class RegisterViewModel {
  final EntityRepo _repo;

  RegisterViewModel(this._repo);

  Stream<List<Plane>> getEntities() => _repo.getEntities();

  Stream<String> deleteEntity(int id) => _repo.deleteEntity(id);
}
