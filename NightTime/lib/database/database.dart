import 'dart:async';

import 'package:floor/floor.dart';
import 'package:nighttime/database/Time.dart';
import 'package:nighttime/database/TimeDAO.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Time])
abstract class FloorDB extends FloorDatabase {
  TimeDAO get timeDAO;
}
