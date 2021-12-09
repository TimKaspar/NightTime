import 'package:floor/floor.dart';

@Entity(tableName: 'time')
class Time {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String toSleep;

  final String sleepTime;

  final String wakeUp;

  Time(this.id, this.toSleep, this.sleepTime, this.wakeUp);
}