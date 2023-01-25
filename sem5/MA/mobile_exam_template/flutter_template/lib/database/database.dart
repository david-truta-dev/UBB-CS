// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_template/DAOs/entity_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../models/entity.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Plane])
abstract class AppDatabase extends FloorDatabase {
  EntityDao get entityDao;
}

