import 'package:floor/floor.dart';

@Entity(tableName: 'time')
class Time {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String toSleep;

  final String wakeUp;

  Time(this.id, this.toSleep, this.wakeUp);

  @override
  String toString() {
    return 'Time{id: $id, toSleep: $toSleep, wakeUp: $wakeUp}';
  }
}