
import 'package:floor/floor.dart';

import 'Time.dart';

@dao
abstract class TimeDAO{
  @Query('SELECT * FROM time')
  Future<List<Time>> findAllTime();
  
  @Query('SELECT * FROM time WHERE id = :id')
  Stream<Time?> findTimeById(int id);

  @insert
  Future<void> insertTime(Time time);
}