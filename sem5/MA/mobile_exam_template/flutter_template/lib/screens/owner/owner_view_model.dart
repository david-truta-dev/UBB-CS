import 'package:flutter_template/repo/entity_repo.dart';
import 'package:flutter_template/repo/shared_pref_repo.dart';

import '../../models/entity.dart';

class OwnerViewModel {
  final SharedPrefsRepo _repo;
  final EntityRepo _entityRepo;

  OwnerViewModel(this._repo, this._entityRepo);

  Stream<String?> getOwnerName() => _repo.getOwnerName();

  Stream<bool> setOwnerName(String name) => _repo.setOwnerName(name);

  Stream<List<Plane>> getPlanesOfOwner(String owner) {
    return _entityRepo
        .getEntities()
        .map((entities) => entities.where((entity) => owner == entity.owner).toList());
  }
}
