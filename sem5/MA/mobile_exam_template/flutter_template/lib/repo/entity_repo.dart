import 'package:rxdart/rxdart.dart';

import '../DAOs/entity_dao.dart';
import '../models/entity.dart';
import '../networking/rest_client.dart';

class EntityRepo {
  static bool useLocal = false;
  static late final EntityDao entityDao;
  static late final RestClient client;

  Stream<String> addEntity(Plane entity) {
    if (!useLocal) {
      return client
          .postEntity(entity)
          .asStream()
          .flatMap((_) => Stream.value("ok"))
          .onErrorResume((error, stackTrace) => Stream.value(error.toString()));
    } else {
      entity.id = DateTime.now().millisecondsSinceEpoch;
      return entityDao
          .insertEntity(entity)
          .asStream()
          .flatMap((_) => Stream.value("ok"))
          .onErrorResume((error, stackTrace) => Stream.value(error.toString()));
    }
  }

  Stream<String> deleteEntity(int id) {
    /// Database version:
    // return entityDao
    //     .findEntityById(id)
    //     .asStream()
    //     .flatMap((entity) => entity != null
    //         ? entityDao
    //             .deleteEntity(entity)
    //             .asStream()
    //             .flatMap((_) => Stream.value("ok"))
    //         : Stream.value("The entity does not exist !"))
    //     .onErrorResume((error, stackTrace) => Stream.value(error.toString()));

    return client
        .deleteEntity(id)
        .asStream()
        .flatMap((_) => Stream.value("ok"))
        .onErrorResume((error, stackTrace) => Stream.value(error.toString()));
  }

  Stream<String> updateEntity(Plane entity) {
    /// Database version:
    // return entityDao
    //     .updateEntity(entity)
    //     .asStream()
    //     .flatMap((_) => Stream.value("ok"))
    //     .onErrorResume((error, stackTrace) => Stream.value(error.toString()));

    return client
        .putEntity(entity.id!, entity)
        .asStream()
        .flatMap((_) => Stream.value("ok"))
        .onErrorResume((error, stackTrace) => Stream.value(error.toString()));
  }

  Stream<List<Plane>> getEntities() {
    /// Database version:
    // return entityDao
    //     .findAllEntities()
    //     .asStream()
    //     .onErrorResume((error, stackTrace) => Stream.error(error.toString()));

    if (!useLocal) {
      return client
          .getEntities()
          .asStream()
          .onErrorResume((error, stackTrace) => Stream.error(error.toString()));
    } else {
      return entityDao
          .findAllEntities()
          .asStream()
          .onErrorResume((error, stackTrace) => Stream.error(error.toString()));
    }
  }

  Stream<List<String>> getEntityTypes() {
    /// mocked version:
    // return Stream.value(["manufacturer1", "manufacturer2"]);

    return client
        .getTypes()
        .asStream()
        .onErrorResume((error, stackTrace) => Stream.error(error.toString()));
  }

  Stream<List<Plane>> getEntitiesForType(String type) {
    /// mocked version:
    //return getEntities();

    return client
        .getEntitiesForType(type)
        .asStream()
        .onErrorResume((error, stackTrace) => Stream.error(error.toString()));
  }

  Stream<List<Plane>> getEntitiesForOwner(String owner) {
    /// mocked version:
    //return getEntities();

    return client
        .getEntitiesForOwner(owner)
        .asStream()
        .onErrorResume((error, stackTrace) => Stream.error(error.toString()));
  }
}
