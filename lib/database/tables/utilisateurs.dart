import 'package:drift/drift.dart';

class Utilisateurs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nom => text()();
  TextColumn get identifiant => text()();
  TextColumn get motDePasse => text()();
  TextColumn get role => text()(); // pharmacien ou vendeuse
  DateTimeColumn get dateCreation => dateTime()();
}
