import 'package:drift/drift.dart';

class Utilisateurs extends Table {
  TextColumn get id => text()();          // id Supabase Auth (UUID)
  TextColumn get pharmacieId => text()();
  TextColumn get email => text()();
  TextColumn get prenom => text()();
  TextColumn get nom => text()();
  TextColumn get role => text()();         // 'pharmacien' ou 'vendeuse'
  DateTimeColumn get derniereConnexion => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
