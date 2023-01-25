import '../../../models/entity.dart';
import '../../../repo/entity_repo.dart';

class ManageViewModel {
  final EntityRepo _repo;

  ManageViewModel(this._repo);

  Stream<String> deleteEntity(int id) => _repo.deleteEntity(id);

  Stream<List<String>> getEntityTypes() => _repo.getEntityTypes();

  Stream<List<Plane>> getEntitiesForType(String type) =>
      _repo.getEntitiesForType(type);
}
