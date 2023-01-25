import '../../../models/entity.dart';
import '../../../repo/entity_repo.dart';

class ReportViewModel {
  final EntityRepo _repo;

  ReportViewModel(this._repo);

  Stream<List<Plane>> getEntities() => _repo.getEntities();

  List<Plane> getTop10BiggestPlanes(List<Plane> entities) {
    entities.sort((p1, p2) {
      if (p1.size != null && p2.size != null && p1.size! > p2.size!) {
        return -1;
      } else if (p1.size != null && p2.size != null && p1.size! < p2.size!) {
        return 1;
      } else {
        return 0;
      }
    });
    return entities.take(10).toList();
  }

  List<OwnerAndNrOfPlanes> getTop10Owners(List<Plane> entities) {
    entities.sort((p1, p2) {
      var owner1NrOfPlanes =
          entities.where((element) => p1.owner == element.owner).length;
      var owner2NrOfPlanes =
          entities.where((element) => p2.owner == element.owner).length;
      if (owner1NrOfPlanes > owner2NrOfPlanes) {
        return -1;
      } else if (owner1NrOfPlanes < owner2NrOfPlanes) {
        return 1;
      } else {
        return 0;
      }
    });
    return entities
        .map((e) => OwnerAndNrOfPlanes(
            e.owner ?? "",
            entities
                .where((element) => e.owner == element.owner)
                .length
                .toString()))
        .toList()
        .toSet()
        .take(10)
        .toList();
  }

  List<Plane> getTop5PlanesByCapacity(List<Plane> entities) {
    entities.sort((p1, p2) {
      if (p1.capacity != null &&
          p2.capacity != null &&
          p1.capacity! > p2.capacity!) {
        return -1;
      } else if (p1.capacity != null &&
          p2.capacity != null &&
          p1.capacity! < p2.capacity!) {
        return 1;
      } else {
        return 0;
      }
    });

    return entities.take(5).toList();
  }
}

class OwnerAndNrOfPlanes {
  final String name;
  final String nrOfPlanes;

  OwnerAndNrOfPlanes(this.name, this.nrOfPlanes);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OwnerAndNrOfPlanes &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          nrOfPlanes == other.nrOfPlanes;

  @override
  int get hashCode => name.hashCode ^ nrOfPlanes.hashCode;
}
