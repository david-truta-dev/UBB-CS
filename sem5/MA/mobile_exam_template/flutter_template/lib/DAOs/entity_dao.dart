import 'package:floor/floor.dart';
import 'package:flutter_template/models/entity.dart';

@dao
abstract class EntityDao {
  @Query('SELECT * FROM Plane')
  Future<List<Plane>> findAllEntities();

  @Query('DELETE FROM Plane')
  Future<void> deleteAllEntities();

  @insert
  Future<void> insertEntity(Plane entity);

  @delete
  Future<void> deleteEntity(Plane entity);

  @update
  Future<void> updateEntity(Plane entity);
}