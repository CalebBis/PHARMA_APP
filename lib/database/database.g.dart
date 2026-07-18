// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String> nom = GeneratedColumn<String>(
    'nom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nom];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String nom;
  const Category({required this.id, required this.nom});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nom'] = Variable<String>(nom);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(id: Value(id), nom: Value(nom));
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      nom: serializer.fromJson<String>(json['nom']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nom': serializer.toJson<String>(nom),
    };
  }

  Category copyWith({int? id, String? nom}) =>
      Category(id: id ?? this.id, nom: nom ?? this.nom);
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      nom: data.nom.present ? data.nom.value : this.nom,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('nom: $nom')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nom);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category && other.id == this.id && other.nom == this.nom);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> nom;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.nom = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String nom,
  }) : nom = Value(nom);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? nom,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nom != null) 'nom': nom,
    });
  }

  CategoriesCompanion copyWith({Value<int>? id, Value<String>? nom}) {
    return CategoriesCompanion(id: id ?? this.id, nom: nom ?? this.nom);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('nom: $nom')
          ..write(')'))
        .toString();
  }
}

class $ProduitsTable extends Produits with TableInfo<$ProduitsTable, Produit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProduitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String> nom = GeneratedColumn<String>(
    'nom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categorieIdMeta = const VerificationMeta(
    'categorieId',
  );
  @override
  late final GeneratedColumn<int> categorieId = GeneratedColumn<int>(
    'categorie_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _prixAchatMeta = const VerificationMeta(
    'prixAchat',
  );
  @override
  late final GeneratedColumn<double> prixAchat = GeneratedColumn<double>(
    'prix_achat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prixVenteMeta = const VerificationMeta(
    'prixVente',
  );
  @override
  late final GeneratedColumn<double> prixVente = GeneratedColumn<double>(
    'prix_vente',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantiteStockMeta = const VerificationMeta(
    'quantiteStock',
  );
  @override
  late final GeneratedColumn<int> quantiteStock = GeneratedColumn<int>(
    'quantite_stock',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seuilAlerteMeta = const VerificationMeta(
    'seuilAlerte',
  );
  @override
  late final GeneratedColumn<int> seuilAlerte = GeneratedColumn<int>(
    'seuil_alerte',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _datePeremptionMeta = const VerificationMeta(
    'datePeremption',
  );
  @override
  late final GeneratedColumn<DateTime> datePeremption =
      GeneratedColumn<DateTime>(
        'date_peremption',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _dateCreationMeta = const VerificationMeta(
    'dateCreation',
  );
  @override
  late final GeneratedColumn<DateTime> dateCreation = GeneratedColumn<DateTime>(
    'date_creation',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nom,
    categorieId,
    prixAchat,
    prixVente,
    quantiteStock,
    seuilAlerte,
    datePeremption,
    dateCreation,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'produits';
  @override
  VerificationContext validateIntegrity(
    Insertable<Produit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('categorie_id')) {
      context.handle(
        _categorieIdMeta,
        categorieId.isAcceptableOrUnknown(
          data['categorie_id']!,
          _categorieIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categorieIdMeta);
    }
    if (data.containsKey('prix_achat')) {
      context.handle(
        _prixAchatMeta,
        prixAchat.isAcceptableOrUnknown(data['prix_achat']!, _prixAchatMeta),
      );
    } else if (isInserting) {
      context.missing(_prixAchatMeta);
    }
    if (data.containsKey('prix_vente')) {
      context.handle(
        _prixVenteMeta,
        prixVente.isAcceptableOrUnknown(data['prix_vente']!, _prixVenteMeta),
      );
    } else if (isInserting) {
      context.missing(_prixVenteMeta);
    }
    if (data.containsKey('quantite_stock')) {
      context.handle(
        _quantiteStockMeta,
        quantiteStock.isAcceptableOrUnknown(
          data['quantite_stock']!,
          _quantiteStockMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quantiteStockMeta);
    }
    if (data.containsKey('seuil_alerte')) {
      context.handle(
        _seuilAlerteMeta,
        seuilAlerte.isAcceptableOrUnknown(
          data['seuil_alerte']!,
          _seuilAlerteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_seuilAlerteMeta);
    }
    if (data.containsKey('date_peremption')) {
      context.handle(
        _datePeremptionMeta,
        datePeremption.isAcceptableOrUnknown(
          data['date_peremption']!,
          _datePeremptionMeta,
        ),
      );
    }
    if (data.containsKey('date_creation')) {
      context.handle(
        _dateCreationMeta,
        dateCreation.isAcceptableOrUnknown(
          data['date_creation']!,
          _dateCreationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateCreationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Produit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Produit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      categorieId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}categorie_id'],
      )!,
      prixAchat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}prix_achat'],
      )!,
      prixVente: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}prix_vente'],
      )!,
      quantiteStock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantite_stock'],
      )!,
      seuilAlerte: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seuil_alerte'],
      )!,
      datePeremption: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_peremption'],
      ),
      dateCreation: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_creation'],
      )!,
    );
  }

  @override
  $ProduitsTable createAlias(String alias) {
    return $ProduitsTable(attachedDatabase, alias);
  }
}

class Produit extends DataClass implements Insertable<Produit> {
  final int id;
  final String nom;
  final int categorieId;
  final double prixAchat;
  final double prixVente;
  final int quantiteStock;
  final int seuilAlerte;
  final DateTime? datePeremption;
  final DateTime dateCreation;
  const Produit({
    required this.id,
    required this.nom,
    required this.categorieId,
    required this.prixAchat,
    required this.prixVente,
    required this.quantiteStock,
    required this.seuilAlerte,
    this.datePeremption,
    required this.dateCreation,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nom'] = Variable<String>(nom);
    map['categorie_id'] = Variable<int>(categorieId);
    map['prix_achat'] = Variable<double>(prixAchat);
    map['prix_vente'] = Variable<double>(prixVente);
    map['quantite_stock'] = Variable<int>(quantiteStock);
    map['seuil_alerte'] = Variable<int>(seuilAlerte);
    if (!nullToAbsent || datePeremption != null) {
      map['date_peremption'] = Variable<DateTime>(datePeremption);
    }
    map['date_creation'] = Variable<DateTime>(dateCreation);
    return map;
  }

  ProduitsCompanion toCompanion(bool nullToAbsent) {
    return ProduitsCompanion(
      id: Value(id),
      nom: Value(nom),
      categorieId: Value(categorieId),
      prixAchat: Value(prixAchat),
      prixVente: Value(prixVente),
      quantiteStock: Value(quantiteStock),
      seuilAlerte: Value(seuilAlerte),
      datePeremption: datePeremption == null && nullToAbsent
          ? const Value.absent()
          : Value(datePeremption),
      dateCreation: Value(dateCreation),
    );
  }

  factory Produit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Produit(
      id: serializer.fromJson<int>(json['id']),
      nom: serializer.fromJson<String>(json['nom']),
      categorieId: serializer.fromJson<int>(json['categorieId']),
      prixAchat: serializer.fromJson<double>(json['prixAchat']),
      prixVente: serializer.fromJson<double>(json['prixVente']),
      quantiteStock: serializer.fromJson<int>(json['quantiteStock']),
      seuilAlerte: serializer.fromJson<int>(json['seuilAlerte']),
      datePeremption: serializer.fromJson<DateTime?>(json['datePeremption']),
      dateCreation: serializer.fromJson<DateTime>(json['dateCreation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nom': serializer.toJson<String>(nom),
      'categorieId': serializer.toJson<int>(categorieId),
      'prixAchat': serializer.toJson<double>(prixAchat),
      'prixVente': serializer.toJson<double>(prixVente),
      'quantiteStock': serializer.toJson<int>(quantiteStock),
      'seuilAlerte': serializer.toJson<int>(seuilAlerte),
      'datePeremption': serializer.toJson<DateTime?>(datePeremption),
      'dateCreation': serializer.toJson<DateTime>(dateCreation),
    };
  }

  Produit copyWith({
    int? id,
    String? nom,
    int? categorieId,
    double? prixAchat,
    double? prixVente,
    int? quantiteStock,
    int? seuilAlerte,
    Value<DateTime?> datePeremption = const Value.absent(),
    DateTime? dateCreation,
  }) => Produit(
    id: id ?? this.id,
    nom: nom ?? this.nom,
    categorieId: categorieId ?? this.categorieId,
    prixAchat: prixAchat ?? this.prixAchat,
    prixVente: prixVente ?? this.prixVente,
    quantiteStock: quantiteStock ?? this.quantiteStock,
    seuilAlerte: seuilAlerte ?? this.seuilAlerte,
    datePeremption: datePeremption.present
        ? datePeremption.value
        : this.datePeremption,
    dateCreation: dateCreation ?? this.dateCreation,
  );
  Produit copyWithCompanion(ProduitsCompanion data) {
    return Produit(
      id: data.id.present ? data.id.value : this.id,
      nom: data.nom.present ? data.nom.value : this.nom,
      categorieId: data.categorieId.present
          ? data.categorieId.value
          : this.categorieId,
      prixAchat: data.prixAchat.present ? data.prixAchat.value : this.prixAchat,
      prixVente: data.prixVente.present ? data.prixVente.value : this.prixVente,
      quantiteStock: data.quantiteStock.present
          ? data.quantiteStock.value
          : this.quantiteStock,
      seuilAlerte: data.seuilAlerte.present
          ? data.seuilAlerte.value
          : this.seuilAlerte,
      datePeremption: data.datePeremption.present
          ? data.datePeremption.value
          : this.datePeremption,
      dateCreation: data.dateCreation.present
          ? data.dateCreation.value
          : this.dateCreation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Produit(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('categorieId: $categorieId, ')
          ..write('prixAchat: $prixAchat, ')
          ..write('prixVente: $prixVente, ')
          ..write('quantiteStock: $quantiteStock, ')
          ..write('seuilAlerte: $seuilAlerte, ')
          ..write('datePeremption: $datePeremption, ')
          ..write('dateCreation: $dateCreation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nom,
    categorieId,
    prixAchat,
    prixVente,
    quantiteStock,
    seuilAlerte,
    datePeremption,
    dateCreation,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Produit &&
          other.id == this.id &&
          other.nom == this.nom &&
          other.categorieId == this.categorieId &&
          other.prixAchat == this.prixAchat &&
          other.prixVente == this.prixVente &&
          other.quantiteStock == this.quantiteStock &&
          other.seuilAlerte == this.seuilAlerte &&
          other.datePeremption == this.datePeremption &&
          other.dateCreation == this.dateCreation);
}

class ProduitsCompanion extends UpdateCompanion<Produit> {
  final Value<int> id;
  final Value<String> nom;
  final Value<int> categorieId;
  final Value<double> prixAchat;
  final Value<double> prixVente;
  final Value<int> quantiteStock;
  final Value<int> seuilAlerte;
  final Value<DateTime?> datePeremption;
  final Value<DateTime> dateCreation;
  const ProduitsCompanion({
    this.id = const Value.absent(),
    this.nom = const Value.absent(),
    this.categorieId = const Value.absent(),
    this.prixAchat = const Value.absent(),
    this.prixVente = const Value.absent(),
    this.quantiteStock = const Value.absent(),
    this.seuilAlerte = const Value.absent(),
    this.datePeremption = const Value.absent(),
    this.dateCreation = const Value.absent(),
  });
  ProduitsCompanion.insert({
    this.id = const Value.absent(),
    required String nom,
    required int categorieId,
    required double prixAchat,
    required double prixVente,
    required int quantiteStock,
    required int seuilAlerte,
    this.datePeremption = const Value.absent(),
    required DateTime dateCreation,
  }) : nom = Value(nom),
       categorieId = Value(categorieId),
       prixAchat = Value(prixAchat),
       prixVente = Value(prixVente),
       quantiteStock = Value(quantiteStock),
       seuilAlerte = Value(seuilAlerte),
       dateCreation = Value(dateCreation);
  static Insertable<Produit> custom({
    Expression<int>? id,
    Expression<String>? nom,
    Expression<int>? categorieId,
    Expression<double>? prixAchat,
    Expression<double>? prixVente,
    Expression<int>? quantiteStock,
    Expression<int>? seuilAlerte,
    Expression<DateTime>? datePeremption,
    Expression<DateTime>? dateCreation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nom != null) 'nom': nom,
      if (categorieId != null) 'categorie_id': categorieId,
      if (prixAchat != null) 'prix_achat': prixAchat,
      if (prixVente != null) 'prix_vente': prixVente,
      if (quantiteStock != null) 'quantite_stock': quantiteStock,
      if (seuilAlerte != null) 'seuil_alerte': seuilAlerte,
      if (datePeremption != null) 'date_peremption': datePeremption,
      if (dateCreation != null) 'date_creation': dateCreation,
    });
  }

  ProduitsCompanion copyWith({
    Value<int>? id,
    Value<String>? nom,
    Value<int>? categorieId,
    Value<double>? prixAchat,
    Value<double>? prixVente,
    Value<int>? quantiteStock,
    Value<int>? seuilAlerte,
    Value<DateTime?>? datePeremption,
    Value<DateTime>? dateCreation,
  }) {
    return ProduitsCompanion(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      categorieId: categorieId ?? this.categorieId,
      prixAchat: prixAchat ?? this.prixAchat,
      prixVente: prixVente ?? this.prixVente,
      quantiteStock: quantiteStock ?? this.quantiteStock,
      seuilAlerte: seuilAlerte ?? this.seuilAlerte,
      datePeremption: datePeremption ?? this.datePeremption,
      dateCreation: dateCreation ?? this.dateCreation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (categorieId.present) {
      map['categorie_id'] = Variable<int>(categorieId.value);
    }
    if (prixAchat.present) {
      map['prix_achat'] = Variable<double>(prixAchat.value);
    }
    if (prixVente.present) {
      map['prix_vente'] = Variable<double>(prixVente.value);
    }
    if (quantiteStock.present) {
      map['quantite_stock'] = Variable<int>(quantiteStock.value);
    }
    if (seuilAlerte.present) {
      map['seuil_alerte'] = Variable<int>(seuilAlerte.value);
    }
    if (datePeremption.present) {
      map['date_peremption'] = Variable<DateTime>(datePeremption.value);
    }
    if (dateCreation.present) {
      map['date_creation'] = Variable<DateTime>(dateCreation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProduitsCompanion(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('categorieId: $categorieId, ')
          ..write('prixAchat: $prixAchat, ')
          ..write('prixVente: $prixVente, ')
          ..write('quantiteStock: $quantiteStock, ')
          ..write('seuilAlerte: $seuilAlerte, ')
          ..write('datePeremption: $datePeremption, ')
          ..write('dateCreation: $dateCreation')
          ..write(')'))
        .toString();
  }
}

class $UtilisateursTable extends Utilisateurs
    with TableInfo<$UtilisateursTable, Utilisateur> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UtilisateursTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String> nom = GeneratedColumn<String>(
    'nom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _identifiantMeta = const VerificationMeta(
    'identifiant',
  );
  @override
  late final GeneratedColumn<String> identifiant = GeneratedColumn<String>(
    'identifiant',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _motDePasseMeta = const VerificationMeta(
    'motDePasse',
  );
  @override
  late final GeneratedColumn<String> motDePasse = GeneratedColumn<String>(
    'mot_de_passe',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateCreationMeta = const VerificationMeta(
    'dateCreation',
  );
  @override
  late final GeneratedColumn<DateTime> dateCreation = GeneratedColumn<DateTime>(
    'date_creation',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nom,
    identifiant,
    motDePasse,
    role,
    dateCreation,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'utilisateurs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Utilisateur> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('identifiant')) {
      context.handle(
        _identifiantMeta,
        identifiant.isAcceptableOrUnknown(
          data['identifiant']!,
          _identifiantMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_identifiantMeta);
    }
    if (data.containsKey('mot_de_passe')) {
      context.handle(
        _motDePasseMeta,
        motDePasse.isAcceptableOrUnknown(
          data['mot_de_passe']!,
          _motDePasseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_motDePasseMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('date_creation')) {
      context.handle(
        _dateCreationMeta,
        dateCreation.isAcceptableOrUnknown(
          data['date_creation']!,
          _dateCreationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateCreationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Utilisateur map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Utilisateur(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      identifiant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}identifiant'],
      )!,
      motDePasse: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mot_de_passe'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      dateCreation: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_creation'],
      )!,
    );
  }

  @override
  $UtilisateursTable createAlias(String alias) {
    return $UtilisateursTable(attachedDatabase, alias);
  }
}

class Utilisateur extends DataClass implements Insertable<Utilisateur> {
  final int id;
  final String nom;
  final String identifiant;
  final String motDePasse;
  final String role;
  final DateTime dateCreation;
  const Utilisateur({
    required this.id,
    required this.nom,
    required this.identifiant,
    required this.motDePasse,
    required this.role,
    required this.dateCreation,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nom'] = Variable<String>(nom);
    map['identifiant'] = Variable<String>(identifiant);
    map['mot_de_passe'] = Variable<String>(motDePasse);
    map['role'] = Variable<String>(role);
    map['date_creation'] = Variable<DateTime>(dateCreation);
    return map;
  }

  UtilisateursCompanion toCompanion(bool nullToAbsent) {
    return UtilisateursCompanion(
      id: Value(id),
      nom: Value(nom),
      identifiant: Value(identifiant),
      motDePasse: Value(motDePasse),
      role: Value(role),
      dateCreation: Value(dateCreation),
    );
  }

  factory Utilisateur.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Utilisateur(
      id: serializer.fromJson<int>(json['id']),
      nom: serializer.fromJson<String>(json['nom']),
      identifiant: serializer.fromJson<String>(json['identifiant']),
      motDePasse: serializer.fromJson<String>(json['motDePasse']),
      role: serializer.fromJson<String>(json['role']),
      dateCreation: serializer.fromJson<DateTime>(json['dateCreation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nom': serializer.toJson<String>(nom),
      'identifiant': serializer.toJson<String>(identifiant),
      'motDePasse': serializer.toJson<String>(motDePasse),
      'role': serializer.toJson<String>(role),
      'dateCreation': serializer.toJson<DateTime>(dateCreation),
    };
  }

  Utilisateur copyWith({
    int? id,
    String? nom,
    String? identifiant,
    String? motDePasse,
    String? role,
    DateTime? dateCreation,
  }) => Utilisateur(
    id: id ?? this.id,
    nom: nom ?? this.nom,
    identifiant: identifiant ?? this.identifiant,
    motDePasse: motDePasse ?? this.motDePasse,
    role: role ?? this.role,
    dateCreation: dateCreation ?? this.dateCreation,
  );
  Utilisateur copyWithCompanion(UtilisateursCompanion data) {
    return Utilisateur(
      id: data.id.present ? data.id.value : this.id,
      nom: data.nom.present ? data.nom.value : this.nom,
      identifiant: data.identifiant.present
          ? data.identifiant.value
          : this.identifiant,
      motDePasse: data.motDePasse.present
          ? data.motDePasse.value
          : this.motDePasse,
      role: data.role.present ? data.role.value : this.role,
      dateCreation: data.dateCreation.present
          ? data.dateCreation.value
          : this.dateCreation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Utilisateur(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('identifiant: $identifiant, ')
          ..write('motDePasse: $motDePasse, ')
          ..write('role: $role, ')
          ..write('dateCreation: $dateCreation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nom, identifiant, motDePasse, role, dateCreation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Utilisateur &&
          other.id == this.id &&
          other.nom == this.nom &&
          other.identifiant == this.identifiant &&
          other.motDePasse == this.motDePasse &&
          other.role == this.role &&
          other.dateCreation == this.dateCreation);
}

class UtilisateursCompanion extends UpdateCompanion<Utilisateur> {
  final Value<int> id;
  final Value<String> nom;
  final Value<String> identifiant;
  final Value<String> motDePasse;
  final Value<String> role;
  final Value<DateTime> dateCreation;
  const UtilisateursCompanion({
    this.id = const Value.absent(),
    this.nom = const Value.absent(),
    this.identifiant = const Value.absent(),
    this.motDePasse = const Value.absent(),
    this.role = const Value.absent(),
    this.dateCreation = const Value.absent(),
  });
  UtilisateursCompanion.insert({
    this.id = const Value.absent(),
    required String nom,
    required String identifiant,
    required String motDePasse,
    required String role,
    required DateTime dateCreation,
  }) : nom = Value(nom),
       identifiant = Value(identifiant),
       motDePasse = Value(motDePasse),
       role = Value(role),
       dateCreation = Value(dateCreation);
  static Insertable<Utilisateur> custom({
    Expression<int>? id,
    Expression<String>? nom,
    Expression<String>? identifiant,
    Expression<String>? motDePasse,
    Expression<String>? role,
    Expression<DateTime>? dateCreation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nom != null) 'nom': nom,
      if (identifiant != null) 'identifiant': identifiant,
      if (motDePasse != null) 'mot_de_passe': motDePasse,
      if (role != null) 'role': role,
      if (dateCreation != null) 'date_creation': dateCreation,
    });
  }

  UtilisateursCompanion copyWith({
    Value<int>? id,
    Value<String>? nom,
    Value<String>? identifiant,
    Value<String>? motDePasse,
    Value<String>? role,
    Value<DateTime>? dateCreation,
  }) {
    return UtilisateursCompanion(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      identifiant: identifiant ?? this.identifiant,
      motDePasse: motDePasse ?? this.motDePasse,
      role: role ?? this.role,
      dateCreation: dateCreation ?? this.dateCreation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (identifiant.present) {
      map['identifiant'] = Variable<String>(identifiant.value);
    }
    if (motDePasse.present) {
      map['mot_de_passe'] = Variable<String>(motDePasse.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (dateCreation.present) {
      map['date_creation'] = Variable<DateTime>(dateCreation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UtilisateursCompanion(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('identifiant: $identifiant, ')
          ..write('motDePasse: $motDePasse, ')
          ..write('role: $role, ')
          ..write('dateCreation: $dateCreation')
          ..write(')'))
        .toString();
  }
}

class $VentesTable extends Ventes with TableInfo<$VentesTable, Vente> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VentesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateVenteMeta = const VerificationMeta(
    'dateVente',
  );
  @override
  late final GeneratedColumn<DateTime> dateVente = GeneratedColumn<DateTime>(
    'date_vente',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _montantTotalMeta = const VerificationMeta(
    'montantTotal',
  );
  @override
  late final GeneratedColumn<double> montantTotal = GeneratedColumn<double>(
    'montant_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modePaiementMeta = const VerificationMeta(
    'modePaiement',
  );
  @override
  late final GeneratedColumn<String> modePaiement = GeneratedColumn<String>(
    'mode_paiement',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dateVente,
    montantTotal,
    modePaiement,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ventes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Vente> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date_vente')) {
      context.handle(
        _dateVenteMeta,
        dateVente.isAcceptableOrUnknown(data['date_vente']!, _dateVenteMeta),
      );
    } else if (isInserting) {
      context.missing(_dateVenteMeta);
    }
    if (data.containsKey('montant_total')) {
      context.handle(
        _montantTotalMeta,
        montantTotal.isAcceptableOrUnknown(
          data['montant_total']!,
          _montantTotalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_montantTotalMeta);
    }
    if (data.containsKey('mode_paiement')) {
      context.handle(
        _modePaiementMeta,
        modePaiement.isAcceptableOrUnknown(
          data['mode_paiement']!,
          _modePaiementMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_modePaiementMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vente map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vente(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dateVente: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_vente'],
      )!,
      montantTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}montant_total'],
      )!,
      modePaiement: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode_paiement'],
      )!,
    );
  }

  @override
  $VentesTable createAlias(String alias) {
    return $VentesTable(attachedDatabase, alias);
  }
}

class Vente extends DataClass implements Insertable<Vente> {
  final int id;
  final DateTime dateVente;
  final double montantTotal;
  final String modePaiement;
  const Vente({
    required this.id,
    required this.dateVente,
    required this.montantTotal,
    required this.modePaiement,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date_vente'] = Variable<DateTime>(dateVente);
    map['montant_total'] = Variable<double>(montantTotal);
    map['mode_paiement'] = Variable<String>(modePaiement);
    return map;
  }

  VentesCompanion toCompanion(bool nullToAbsent) {
    return VentesCompanion(
      id: Value(id),
      dateVente: Value(dateVente),
      montantTotal: Value(montantTotal),
      modePaiement: Value(modePaiement),
    );
  }

  factory Vente.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vente(
      id: serializer.fromJson<int>(json['id']),
      dateVente: serializer.fromJson<DateTime>(json['dateVente']),
      montantTotal: serializer.fromJson<double>(json['montantTotal']),
      modePaiement: serializer.fromJson<String>(json['modePaiement']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dateVente': serializer.toJson<DateTime>(dateVente),
      'montantTotal': serializer.toJson<double>(montantTotal),
      'modePaiement': serializer.toJson<String>(modePaiement),
    };
  }

  Vente copyWith({
    int? id,
    DateTime? dateVente,
    double? montantTotal,
    String? modePaiement,
  }) => Vente(
    id: id ?? this.id,
    dateVente: dateVente ?? this.dateVente,
    montantTotal: montantTotal ?? this.montantTotal,
    modePaiement: modePaiement ?? this.modePaiement,
  );
  Vente copyWithCompanion(VentesCompanion data) {
    return Vente(
      id: data.id.present ? data.id.value : this.id,
      dateVente: data.dateVente.present ? data.dateVente.value : this.dateVente,
      montantTotal: data.montantTotal.present
          ? data.montantTotal.value
          : this.montantTotal,
      modePaiement: data.modePaiement.present
          ? data.modePaiement.value
          : this.modePaiement,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vente(')
          ..write('id: $id, ')
          ..write('dateVente: $dateVente, ')
          ..write('montantTotal: $montantTotal, ')
          ..write('modePaiement: $modePaiement')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dateVente, montantTotal, modePaiement);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vente &&
          other.id == this.id &&
          other.dateVente == this.dateVente &&
          other.montantTotal == this.montantTotal &&
          other.modePaiement == this.modePaiement);
}

class VentesCompanion extends UpdateCompanion<Vente> {
  final Value<int> id;
  final Value<DateTime> dateVente;
  final Value<double> montantTotal;
  final Value<String> modePaiement;
  const VentesCompanion({
    this.id = const Value.absent(),
    this.dateVente = const Value.absent(),
    this.montantTotal = const Value.absent(),
    this.modePaiement = const Value.absent(),
  });
  VentesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime dateVente,
    required double montantTotal,
    required String modePaiement,
  }) : dateVente = Value(dateVente),
       montantTotal = Value(montantTotal),
       modePaiement = Value(modePaiement);
  static Insertable<Vente> custom({
    Expression<int>? id,
    Expression<DateTime>? dateVente,
    Expression<double>? montantTotal,
    Expression<String>? modePaiement,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dateVente != null) 'date_vente': dateVente,
      if (montantTotal != null) 'montant_total': montantTotal,
      if (modePaiement != null) 'mode_paiement': modePaiement,
    });
  }

  VentesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? dateVente,
    Value<double>? montantTotal,
    Value<String>? modePaiement,
  }) {
    return VentesCompanion(
      id: id ?? this.id,
      dateVente: dateVente ?? this.dateVente,
      montantTotal: montantTotal ?? this.montantTotal,
      modePaiement: modePaiement ?? this.modePaiement,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dateVente.present) {
      map['date_vente'] = Variable<DateTime>(dateVente.value);
    }
    if (montantTotal.present) {
      map['montant_total'] = Variable<double>(montantTotal.value);
    }
    if (modePaiement.present) {
      map['mode_paiement'] = Variable<String>(modePaiement.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VentesCompanion(')
          ..write('id: $id, ')
          ..write('dateVente: $dateVente, ')
          ..write('montantTotal: $montantTotal, ')
          ..write('modePaiement: $modePaiement')
          ..write(')'))
        .toString();
  }
}

class $VenteDetailsTable extends VenteDetails
    with TableInfo<$VenteDetailsTable, VenteDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VenteDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _venteIdMeta = const VerificationMeta(
    'venteId',
  );
  @override
  late final GeneratedColumn<int> venteId = GeneratedColumn<int>(
    'vente_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ventes (id)',
    ),
  );
  static const VerificationMeta _produitIdMeta = const VerificationMeta(
    'produitId',
  );
  @override
  late final GeneratedColumn<int> produitId = GeneratedColumn<int>(
    'produit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES produits (id)',
    ),
  );
  static const VerificationMeta _quantiteMeta = const VerificationMeta(
    'quantite',
  );
  @override
  late final GeneratedColumn<int> quantite = GeneratedColumn<int>(
    'quantite',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prixUnitaireMeta = const VerificationMeta(
    'prixUnitaire',
  );
  @override
  late final GeneratedColumn<double> prixUnitaire = GeneratedColumn<double>(
    'prix_unitaire',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sousTotalMeta = const VerificationMeta(
    'sousTotal',
  );
  @override
  late final GeneratedColumn<double> sousTotal = GeneratedColumn<double>(
    'sous_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    venteId,
    produitId,
    quantite,
    prixUnitaire,
    sousTotal,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vente_details';
  @override
  VerificationContext validateIntegrity(
    Insertable<VenteDetail> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vente_id')) {
      context.handle(
        _venteIdMeta,
        venteId.isAcceptableOrUnknown(data['vente_id']!, _venteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venteIdMeta);
    }
    if (data.containsKey('produit_id')) {
      context.handle(
        _produitIdMeta,
        produitId.isAcceptableOrUnknown(data['produit_id']!, _produitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_produitIdMeta);
    }
    if (data.containsKey('quantite')) {
      context.handle(
        _quantiteMeta,
        quantite.isAcceptableOrUnknown(data['quantite']!, _quantiteMeta),
      );
    } else if (isInserting) {
      context.missing(_quantiteMeta);
    }
    if (data.containsKey('prix_unitaire')) {
      context.handle(
        _prixUnitaireMeta,
        prixUnitaire.isAcceptableOrUnknown(
          data['prix_unitaire']!,
          _prixUnitaireMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_prixUnitaireMeta);
    }
    if (data.containsKey('sous_total')) {
      context.handle(
        _sousTotalMeta,
        sousTotal.isAcceptableOrUnknown(data['sous_total']!, _sousTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_sousTotalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VenteDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VenteDetail(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      venteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vente_id'],
      )!,
      produitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}produit_id'],
      )!,
      quantite: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantite'],
      )!,
      prixUnitaire: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}prix_unitaire'],
      )!,
      sousTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sous_total'],
      )!,
    );
  }

  @override
  $VenteDetailsTable createAlias(String alias) {
    return $VenteDetailsTable(attachedDatabase, alias);
  }
}

class VenteDetail extends DataClass implements Insertable<VenteDetail> {
  final int id;
  final int venteId;
  final int produitId;
  final int quantite;
  final double prixUnitaire;
  final double sousTotal;
  const VenteDetail({
    required this.id,
    required this.venteId,
    required this.produitId,
    required this.quantite,
    required this.prixUnitaire,
    required this.sousTotal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vente_id'] = Variable<int>(venteId);
    map['produit_id'] = Variable<int>(produitId);
    map['quantite'] = Variable<int>(quantite);
    map['prix_unitaire'] = Variable<double>(prixUnitaire);
    map['sous_total'] = Variable<double>(sousTotal);
    return map;
  }

  VenteDetailsCompanion toCompanion(bool nullToAbsent) {
    return VenteDetailsCompanion(
      id: Value(id),
      venteId: Value(venteId),
      produitId: Value(produitId),
      quantite: Value(quantite),
      prixUnitaire: Value(prixUnitaire),
      sousTotal: Value(sousTotal),
    );
  }

  factory VenteDetail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VenteDetail(
      id: serializer.fromJson<int>(json['id']),
      venteId: serializer.fromJson<int>(json['venteId']),
      produitId: serializer.fromJson<int>(json['produitId']),
      quantite: serializer.fromJson<int>(json['quantite']),
      prixUnitaire: serializer.fromJson<double>(json['prixUnitaire']),
      sousTotal: serializer.fromJson<double>(json['sousTotal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'venteId': serializer.toJson<int>(venteId),
      'produitId': serializer.toJson<int>(produitId),
      'quantite': serializer.toJson<int>(quantite),
      'prixUnitaire': serializer.toJson<double>(prixUnitaire),
      'sousTotal': serializer.toJson<double>(sousTotal),
    };
  }

  VenteDetail copyWith({
    int? id,
    int? venteId,
    int? produitId,
    int? quantite,
    double? prixUnitaire,
    double? sousTotal,
  }) => VenteDetail(
    id: id ?? this.id,
    venteId: venteId ?? this.venteId,
    produitId: produitId ?? this.produitId,
    quantite: quantite ?? this.quantite,
    prixUnitaire: prixUnitaire ?? this.prixUnitaire,
    sousTotal: sousTotal ?? this.sousTotal,
  );
  VenteDetail copyWithCompanion(VenteDetailsCompanion data) {
    return VenteDetail(
      id: data.id.present ? data.id.value : this.id,
      venteId: data.venteId.present ? data.venteId.value : this.venteId,
      produitId: data.produitId.present ? data.produitId.value : this.produitId,
      quantite: data.quantite.present ? data.quantite.value : this.quantite,
      prixUnitaire: data.prixUnitaire.present
          ? data.prixUnitaire.value
          : this.prixUnitaire,
      sousTotal: data.sousTotal.present ? data.sousTotal.value : this.sousTotal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VenteDetail(')
          ..write('id: $id, ')
          ..write('venteId: $venteId, ')
          ..write('produitId: $produitId, ')
          ..write('quantite: $quantite, ')
          ..write('prixUnitaire: $prixUnitaire, ')
          ..write('sousTotal: $sousTotal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, venteId, produitId, quantite, prixUnitaire, sousTotal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VenteDetail &&
          other.id == this.id &&
          other.venteId == this.venteId &&
          other.produitId == this.produitId &&
          other.quantite == this.quantite &&
          other.prixUnitaire == this.prixUnitaire &&
          other.sousTotal == this.sousTotal);
}

class VenteDetailsCompanion extends UpdateCompanion<VenteDetail> {
  final Value<int> id;
  final Value<int> venteId;
  final Value<int> produitId;
  final Value<int> quantite;
  final Value<double> prixUnitaire;
  final Value<double> sousTotal;
  const VenteDetailsCompanion({
    this.id = const Value.absent(),
    this.venteId = const Value.absent(),
    this.produitId = const Value.absent(),
    this.quantite = const Value.absent(),
    this.prixUnitaire = const Value.absent(),
    this.sousTotal = const Value.absent(),
  });
  VenteDetailsCompanion.insert({
    this.id = const Value.absent(),
    required int venteId,
    required int produitId,
    required int quantite,
    required double prixUnitaire,
    required double sousTotal,
  }) : venteId = Value(venteId),
       produitId = Value(produitId),
       quantite = Value(quantite),
       prixUnitaire = Value(prixUnitaire),
       sousTotal = Value(sousTotal);
  static Insertable<VenteDetail> custom({
    Expression<int>? id,
    Expression<int>? venteId,
    Expression<int>? produitId,
    Expression<int>? quantite,
    Expression<double>? prixUnitaire,
    Expression<double>? sousTotal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (venteId != null) 'vente_id': venteId,
      if (produitId != null) 'produit_id': produitId,
      if (quantite != null) 'quantite': quantite,
      if (prixUnitaire != null) 'prix_unitaire': prixUnitaire,
      if (sousTotal != null) 'sous_total': sousTotal,
    });
  }

  VenteDetailsCompanion copyWith({
    Value<int>? id,
    Value<int>? venteId,
    Value<int>? produitId,
    Value<int>? quantite,
    Value<double>? prixUnitaire,
    Value<double>? sousTotal,
  }) {
    return VenteDetailsCompanion(
      id: id ?? this.id,
      venteId: venteId ?? this.venteId,
      produitId: produitId ?? this.produitId,
      quantite: quantite ?? this.quantite,
      prixUnitaire: prixUnitaire ?? this.prixUnitaire,
      sousTotal: sousTotal ?? this.sousTotal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (venteId.present) {
      map['vente_id'] = Variable<int>(venteId.value);
    }
    if (produitId.present) {
      map['produit_id'] = Variable<int>(produitId.value);
    }
    if (quantite.present) {
      map['quantite'] = Variable<int>(quantite.value);
    }
    if (prixUnitaire.present) {
      map['prix_unitaire'] = Variable<double>(prixUnitaire.value);
    }
    if (sousTotal.present) {
      map['sous_total'] = Variable<double>(sousTotal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VenteDetailsCompanion(')
          ..write('id: $id, ')
          ..write('venteId: $venteId, ')
          ..write('produitId: $produitId, ')
          ..write('quantite: $quantite, ')
          ..write('prixUnitaire: $prixUnitaire, ')
          ..write('sousTotal: $sousTotal')
          ..write(')'))
        .toString();
  }
}

class $FacturesTable extends Factures with TableInfo<$FacturesTable, Facture> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FacturesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _venteIdMeta = const VerificationMeta(
    'venteId',
  );
  @override
  late final GeneratedColumn<int> venteId = GeneratedColumn<int>(
    'vente_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ventes (id)',
    ),
  );
  static const VerificationMeta _numeroFactureMeta = const VerificationMeta(
    'numeroFacture',
  );
  @override
  late final GeneratedColumn<String> numeroFacture = GeneratedColumn<String>(
    'numero_facture',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _dateEmissionMeta = const VerificationMeta(
    'dateEmission',
  );
  @override
  late final GeneratedColumn<DateTime> dateEmission = GeneratedColumn<DateTime>(
    'date_emission',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cheminPdfMeta = const VerificationMeta(
    'cheminPdf',
  );
  @override
  late final GeneratedColumn<String> cheminPdf = GeneratedColumn<String>(
    'chemin_pdf',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    venteId,
    numeroFacture,
    dateEmission,
    cheminPdf,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'factures';
  @override
  VerificationContext validateIntegrity(
    Insertable<Facture> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vente_id')) {
      context.handle(
        _venteIdMeta,
        venteId.isAcceptableOrUnknown(data['vente_id']!, _venteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venteIdMeta);
    }
    if (data.containsKey('numero_facture')) {
      context.handle(
        _numeroFactureMeta,
        numeroFacture.isAcceptableOrUnknown(
          data['numero_facture']!,
          _numeroFactureMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numeroFactureMeta);
    }
    if (data.containsKey('date_emission')) {
      context.handle(
        _dateEmissionMeta,
        dateEmission.isAcceptableOrUnknown(
          data['date_emission']!,
          _dateEmissionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateEmissionMeta);
    }
    if (data.containsKey('chemin_pdf')) {
      context.handle(
        _cheminPdfMeta,
        cheminPdf.isAcceptableOrUnknown(data['chemin_pdf']!, _cheminPdfMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Facture map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Facture(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      venteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vente_id'],
      )!,
      numeroFacture: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}numero_facture'],
      )!,
      dateEmission: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_emission'],
      )!,
      cheminPdf: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chemin_pdf'],
      ),
    );
  }

  @override
  $FacturesTable createAlias(String alias) {
    return $FacturesTable(attachedDatabase, alias);
  }
}

class Facture extends DataClass implements Insertable<Facture> {
  final int id;
  final int venteId;
  final String numeroFacture;
  final DateTime dateEmission;
  final String? cheminPdf;
  const Facture({
    required this.id,
    required this.venteId,
    required this.numeroFacture,
    required this.dateEmission,
    this.cheminPdf,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vente_id'] = Variable<int>(venteId);
    map['numero_facture'] = Variable<String>(numeroFacture);
    map['date_emission'] = Variable<DateTime>(dateEmission);
    if (!nullToAbsent || cheminPdf != null) {
      map['chemin_pdf'] = Variable<String>(cheminPdf);
    }
    return map;
  }

  FacturesCompanion toCompanion(bool nullToAbsent) {
    return FacturesCompanion(
      id: Value(id),
      venteId: Value(venteId),
      numeroFacture: Value(numeroFacture),
      dateEmission: Value(dateEmission),
      cheminPdf: cheminPdf == null && nullToAbsent
          ? const Value.absent()
          : Value(cheminPdf),
    );
  }

  factory Facture.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Facture(
      id: serializer.fromJson<int>(json['id']),
      venteId: serializer.fromJson<int>(json['venteId']),
      numeroFacture: serializer.fromJson<String>(json['numeroFacture']),
      dateEmission: serializer.fromJson<DateTime>(json['dateEmission']),
      cheminPdf: serializer.fromJson<String?>(json['cheminPdf']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'venteId': serializer.toJson<int>(venteId),
      'numeroFacture': serializer.toJson<String>(numeroFacture),
      'dateEmission': serializer.toJson<DateTime>(dateEmission),
      'cheminPdf': serializer.toJson<String?>(cheminPdf),
    };
  }

  Facture copyWith({
    int? id,
    int? venteId,
    String? numeroFacture,
    DateTime? dateEmission,
    Value<String?> cheminPdf = const Value.absent(),
  }) => Facture(
    id: id ?? this.id,
    venteId: venteId ?? this.venteId,
    numeroFacture: numeroFacture ?? this.numeroFacture,
    dateEmission: dateEmission ?? this.dateEmission,
    cheminPdf: cheminPdf.present ? cheminPdf.value : this.cheminPdf,
  );
  Facture copyWithCompanion(FacturesCompanion data) {
    return Facture(
      id: data.id.present ? data.id.value : this.id,
      venteId: data.venteId.present ? data.venteId.value : this.venteId,
      numeroFacture: data.numeroFacture.present
          ? data.numeroFacture.value
          : this.numeroFacture,
      dateEmission: data.dateEmission.present
          ? data.dateEmission.value
          : this.dateEmission,
      cheminPdf: data.cheminPdf.present ? data.cheminPdf.value : this.cheminPdf,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Facture(')
          ..write('id: $id, ')
          ..write('venteId: $venteId, ')
          ..write('numeroFacture: $numeroFacture, ')
          ..write('dateEmission: $dateEmission, ')
          ..write('cheminPdf: $cheminPdf')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, venteId, numeroFacture, dateEmission, cheminPdf);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Facture &&
          other.id == this.id &&
          other.venteId == this.venteId &&
          other.numeroFacture == this.numeroFacture &&
          other.dateEmission == this.dateEmission &&
          other.cheminPdf == this.cheminPdf);
}

class FacturesCompanion extends UpdateCompanion<Facture> {
  final Value<int> id;
  final Value<int> venteId;
  final Value<String> numeroFacture;
  final Value<DateTime> dateEmission;
  final Value<String?> cheminPdf;
  const FacturesCompanion({
    this.id = const Value.absent(),
    this.venteId = const Value.absent(),
    this.numeroFacture = const Value.absent(),
    this.dateEmission = const Value.absent(),
    this.cheminPdf = const Value.absent(),
  });
  FacturesCompanion.insert({
    this.id = const Value.absent(),
    required int venteId,
    required String numeroFacture,
    required DateTime dateEmission,
    this.cheminPdf = const Value.absent(),
  }) : venteId = Value(venteId),
       numeroFacture = Value(numeroFacture),
       dateEmission = Value(dateEmission);
  static Insertable<Facture> custom({
    Expression<int>? id,
    Expression<int>? venteId,
    Expression<String>? numeroFacture,
    Expression<DateTime>? dateEmission,
    Expression<String>? cheminPdf,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (venteId != null) 'vente_id': venteId,
      if (numeroFacture != null) 'numero_facture': numeroFacture,
      if (dateEmission != null) 'date_emission': dateEmission,
      if (cheminPdf != null) 'chemin_pdf': cheminPdf,
    });
  }

  FacturesCompanion copyWith({
    Value<int>? id,
    Value<int>? venteId,
    Value<String>? numeroFacture,
    Value<DateTime>? dateEmission,
    Value<String?>? cheminPdf,
  }) {
    return FacturesCompanion(
      id: id ?? this.id,
      venteId: venteId ?? this.venteId,
      numeroFacture: numeroFacture ?? this.numeroFacture,
      dateEmission: dateEmission ?? this.dateEmission,
      cheminPdf: cheminPdf ?? this.cheminPdf,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (venteId.present) {
      map['vente_id'] = Variable<int>(venteId.value);
    }
    if (numeroFacture.present) {
      map['numero_facture'] = Variable<String>(numeroFacture.value);
    }
    if (dateEmission.present) {
      map['date_emission'] = Variable<DateTime>(dateEmission.value);
    }
    if (cheminPdf.present) {
      map['chemin_pdf'] = Variable<String>(cheminPdf.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FacturesCompanion(')
          ..write('id: $id, ')
          ..write('venteId: $venteId, ')
          ..write('numeroFacture: $numeroFacture, ')
          ..write('dateEmission: $dateEmission, ')
          ..write('cheminPdf: $cheminPdf')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ProduitsTable produits = $ProduitsTable(this);
  late final $UtilisateursTable utilisateurs = $UtilisateursTable(this);
  late final $VentesTable ventes = $VentesTable(this);
  late final $VenteDetailsTable venteDetails = $VenteDetailsTable(this);
  late final $FacturesTable factures = $FacturesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categories,
    produits,
    utilisateurs,
    ventes,
    venteDetails,
    factures,
  ];
}

typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({Value<int> id, required String nom});
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({Value<int> id, Value<String> nom});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProduitsTable, List<Produit>> _produitsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.produits,
    aliasName: $_aliasNameGenerator(db.categories.id, db.produits.categorieId),
  );

  $$ProduitsTableProcessedTableManager get produitsRefs {
    final manager = $$ProduitsTableTableManager(
      $_db,
      $_db.produits,
    ).filter((f) => f.categorieId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_produitsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> produitsRefs(
    Expression<bool> Function($$ProduitsTableFilterComposer f) f,
  ) {
    final $$ProduitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.produits,
      getReferencedColumn: (t) => t.categorieId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProduitsTableFilterComposer(
            $db: $db,
            $table: $db.produits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  Expression<T> produitsRefs<T extends Object>(
    Expression<T> Function($$ProduitsTableAnnotationComposer a) f,
  ) {
    final $$ProduitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.produits,
      getReferencedColumn: (t) => t.categorieId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProduitsTableAnnotationComposer(
            $db: $db,
            $table: $db.produits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({bool produitsRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nom = const Value.absent(),
              }) => CategoriesCompanion(id: id, nom: nom),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String nom}) =>
                  CategoriesCompanion.insert(id: id, nom: nom),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({produitsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (produitsRefs) db.produits],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (produitsRefs)
                    await $_getPrefetchedData<
                      Category,
                      $CategoriesTable,
                      Produit
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._produitsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).produitsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.categorieId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({bool produitsRefs})
    >;
typedef $$ProduitsTableCreateCompanionBuilder =
    ProduitsCompanion Function({
      Value<int> id,
      required String nom,
      required int categorieId,
      required double prixAchat,
      required double prixVente,
      required int quantiteStock,
      required int seuilAlerte,
      Value<DateTime?> datePeremption,
      required DateTime dateCreation,
    });
typedef $$ProduitsTableUpdateCompanionBuilder =
    ProduitsCompanion Function({
      Value<int> id,
      Value<String> nom,
      Value<int> categorieId,
      Value<double> prixAchat,
      Value<double> prixVente,
      Value<int> quantiteStock,
      Value<int> seuilAlerte,
      Value<DateTime?> datePeremption,
      Value<DateTime> dateCreation,
    });

final class $$ProduitsTableReferences
    extends BaseReferences<_$AppDatabase, $ProduitsTable, Produit> {
  $$ProduitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categorieIdTable(_$AppDatabase db) =>
      db.categories.createAlias(
        $_aliasNameGenerator(db.produits.categorieId, db.categories.id),
      );

  $$CategoriesTableProcessedTableManager get categorieId {
    final $_column = $_itemColumn<int>('categorie_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categorieIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$VenteDetailsTable, List<VenteDetail>>
  _venteDetailsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.venteDetails,
    aliasName: $_aliasNameGenerator(db.produits.id, db.venteDetails.produitId),
  );

  $$VenteDetailsTableProcessedTableManager get venteDetailsRefs {
    final manager = $$VenteDetailsTableTableManager(
      $_db,
      $_db.venteDetails,
    ).filter((f) => f.produitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_venteDetailsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProduitsTableFilterComposer
    extends Composer<_$AppDatabase, $ProduitsTable> {
  $$ProduitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get prixAchat => $composableBuilder(
    column: $table.prixAchat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get prixVente => $composableBuilder(
    column: $table.prixVente,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantiteStock => $composableBuilder(
    column: $table.quantiteStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seuilAlerte => $composableBuilder(
    column: $table.seuilAlerte,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get datePeremption => $composableBuilder(
    column: $table.datePeremption,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateCreation => $composableBuilder(
    column: $table.dateCreation,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categorieId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categorieId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> venteDetailsRefs(
    Expression<bool> Function($$VenteDetailsTableFilterComposer f) f,
  ) {
    final $$VenteDetailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.venteDetails,
      getReferencedColumn: (t) => t.produitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VenteDetailsTableFilterComposer(
            $db: $db,
            $table: $db.venteDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProduitsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProduitsTable> {
  $$ProduitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get prixAchat => $composableBuilder(
    column: $table.prixAchat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get prixVente => $composableBuilder(
    column: $table.prixVente,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantiteStock => $composableBuilder(
    column: $table.quantiteStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seuilAlerte => $composableBuilder(
    column: $table.seuilAlerte,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get datePeremption => $composableBuilder(
    column: $table.datePeremption,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateCreation => $composableBuilder(
    column: $table.dateCreation,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categorieId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categorieId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProduitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProduitsTable> {
  $$ProduitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<double> get prixAchat =>
      $composableBuilder(column: $table.prixAchat, builder: (column) => column);

  GeneratedColumn<double> get prixVente =>
      $composableBuilder(column: $table.prixVente, builder: (column) => column);

  GeneratedColumn<int> get quantiteStock => $composableBuilder(
    column: $table.quantiteStock,
    builder: (column) => column,
  );

  GeneratedColumn<int> get seuilAlerte => $composableBuilder(
    column: $table.seuilAlerte,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get datePeremption => $composableBuilder(
    column: $table.datePeremption,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateCreation => $composableBuilder(
    column: $table.dateCreation,
    builder: (column) => column,
  );

  $$CategoriesTableAnnotationComposer get categorieId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categorieId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> venteDetailsRefs<T extends Object>(
    Expression<T> Function($$VenteDetailsTableAnnotationComposer a) f,
  ) {
    final $$VenteDetailsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.venteDetails,
      getReferencedColumn: (t) => t.produitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VenteDetailsTableAnnotationComposer(
            $db: $db,
            $table: $db.venteDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProduitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProduitsTable,
          Produit,
          $$ProduitsTableFilterComposer,
          $$ProduitsTableOrderingComposer,
          $$ProduitsTableAnnotationComposer,
          $$ProduitsTableCreateCompanionBuilder,
          $$ProduitsTableUpdateCompanionBuilder,
          (Produit, $$ProduitsTableReferences),
          Produit,
          PrefetchHooks Function({bool categorieId, bool venteDetailsRefs})
        > {
  $$ProduitsTableTableManager(_$AppDatabase db, $ProduitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProduitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProduitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProduitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<int> categorieId = const Value.absent(),
                Value<double> prixAchat = const Value.absent(),
                Value<double> prixVente = const Value.absent(),
                Value<int> quantiteStock = const Value.absent(),
                Value<int> seuilAlerte = const Value.absent(),
                Value<DateTime?> datePeremption = const Value.absent(),
                Value<DateTime> dateCreation = const Value.absent(),
              }) => ProduitsCompanion(
                id: id,
                nom: nom,
                categorieId: categorieId,
                prixAchat: prixAchat,
                prixVente: prixVente,
                quantiteStock: quantiteStock,
                seuilAlerte: seuilAlerte,
                datePeremption: datePeremption,
                dateCreation: dateCreation,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nom,
                required int categorieId,
                required double prixAchat,
                required double prixVente,
                required int quantiteStock,
                required int seuilAlerte,
                Value<DateTime?> datePeremption = const Value.absent(),
                required DateTime dateCreation,
              }) => ProduitsCompanion.insert(
                id: id,
                nom: nom,
                categorieId: categorieId,
                prixAchat: prixAchat,
                prixVente: prixVente,
                quantiteStock: quantiteStock,
                seuilAlerte: seuilAlerte,
                datePeremption: datePeremption,
                dateCreation: dateCreation,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProduitsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({categorieId = false, venteDetailsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (venteDetailsRefs) db.venteDetails,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categorieId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categorieId,
                                    referencedTable: $$ProduitsTableReferences
                                        ._categorieIdTable(db),
                                    referencedColumn: $$ProduitsTableReferences
                                        ._categorieIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (venteDetailsRefs)
                        await $_getPrefetchedData<
                          Produit,
                          $ProduitsTable,
                          VenteDetail
                        >(
                          currentTable: table,
                          referencedTable: $$ProduitsTableReferences
                              ._venteDetailsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProduitsTableReferences(
                                db,
                                table,
                                p0,
                              ).venteDetailsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.produitId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProduitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProduitsTable,
      Produit,
      $$ProduitsTableFilterComposer,
      $$ProduitsTableOrderingComposer,
      $$ProduitsTableAnnotationComposer,
      $$ProduitsTableCreateCompanionBuilder,
      $$ProduitsTableUpdateCompanionBuilder,
      (Produit, $$ProduitsTableReferences),
      Produit,
      PrefetchHooks Function({bool categorieId, bool venteDetailsRefs})
    >;
typedef $$UtilisateursTableCreateCompanionBuilder =
    UtilisateursCompanion Function({
      Value<int> id,
      required String nom,
      required String identifiant,
      required String motDePasse,
      required String role,
      required DateTime dateCreation,
    });
typedef $$UtilisateursTableUpdateCompanionBuilder =
    UtilisateursCompanion Function({
      Value<int> id,
      Value<String> nom,
      Value<String> identifiant,
      Value<String> motDePasse,
      Value<String> role,
      Value<DateTime> dateCreation,
    });

class $$UtilisateursTableFilterComposer
    extends Composer<_$AppDatabase, $UtilisateursTable> {
  $$UtilisateursTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get identifiant => $composableBuilder(
    column: $table.identifiant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motDePasse => $composableBuilder(
    column: $table.motDePasse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateCreation => $composableBuilder(
    column: $table.dateCreation,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UtilisateursTableOrderingComposer
    extends Composer<_$AppDatabase, $UtilisateursTable> {
  $$UtilisateursTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get identifiant => $composableBuilder(
    column: $table.identifiant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motDePasse => $composableBuilder(
    column: $table.motDePasse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateCreation => $composableBuilder(
    column: $table.dateCreation,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UtilisateursTableAnnotationComposer
    extends Composer<_$AppDatabase, $UtilisateursTable> {
  $$UtilisateursTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<String> get identifiant => $composableBuilder(
    column: $table.identifiant,
    builder: (column) => column,
  );

  GeneratedColumn<String> get motDePasse => $composableBuilder(
    column: $table.motDePasse,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get dateCreation => $composableBuilder(
    column: $table.dateCreation,
    builder: (column) => column,
  );
}

class $$UtilisateursTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UtilisateursTable,
          Utilisateur,
          $$UtilisateursTableFilterComposer,
          $$UtilisateursTableOrderingComposer,
          $$UtilisateursTableAnnotationComposer,
          $$UtilisateursTableCreateCompanionBuilder,
          $$UtilisateursTableUpdateCompanionBuilder,
          (
            Utilisateur,
            BaseReferences<_$AppDatabase, $UtilisateursTable, Utilisateur>,
          ),
          Utilisateur,
          PrefetchHooks Function()
        > {
  $$UtilisateursTableTableManager(_$AppDatabase db, $UtilisateursTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UtilisateursTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UtilisateursTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UtilisateursTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<String> identifiant = const Value.absent(),
                Value<String> motDePasse = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<DateTime> dateCreation = const Value.absent(),
              }) => UtilisateursCompanion(
                id: id,
                nom: nom,
                identifiant: identifiant,
                motDePasse: motDePasse,
                role: role,
                dateCreation: dateCreation,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nom,
                required String identifiant,
                required String motDePasse,
                required String role,
                required DateTime dateCreation,
              }) => UtilisateursCompanion.insert(
                id: id,
                nom: nom,
                identifiant: identifiant,
                motDePasse: motDePasse,
                role: role,
                dateCreation: dateCreation,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UtilisateursTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UtilisateursTable,
      Utilisateur,
      $$UtilisateursTableFilterComposer,
      $$UtilisateursTableOrderingComposer,
      $$UtilisateursTableAnnotationComposer,
      $$UtilisateursTableCreateCompanionBuilder,
      $$UtilisateursTableUpdateCompanionBuilder,
      (
        Utilisateur,
        BaseReferences<_$AppDatabase, $UtilisateursTable, Utilisateur>,
      ),
      Utilisateur,
      PrefetchHooks Function()
    >;
typedef $$VentesTableCreateCompanionBuilder =
    VentesCompanion Function({
      Value<int> id,
      required DateTime dateVente,
      required double montantTotal,
      required String modePaiement,
    });
typedef $$VentesTableUpdateCompanionBuilder =
    VentesCompanion Function({
      Value<int> id,
      Value<DateTime> dateVente,
      Value<double> montantTotal,
      Value<String> modePaiement,
    });

final class $$VentesTableReferences
    extends BaseReferences<_$AppDatabase, $VentesTable, Vente> {
  $$VentesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VenteDetailsTable, List<VenteDetail>>
  _venteDetailsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.venteDetails,
    aliasName: $_aliasNameGenerator(db.ventes.id, db.venteDetails.venteId),
  );

  $$VenteDetailsTableProcessedTableManager get venteDetailsRefs {
    final manager = $$VenteDetailsTableTableManager(
      $_db,
      $_db.venteDetails,
    ).filter((f) => f.venteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_venteDetailsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FacturesTable, List<Facture>> _facturesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.factures,
    aliasName: $_aliasNameGenerator(db.ventes.id, db.factures.venteId),
  );

  $$FacturesTableProcessedTableManager get facturesRefs {
    final manager = $$FacturesTableTableManager(
      $_db,
      $_db.factures,
    ).filter((f) => f.venteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_facturesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VentesTableFilterComposer
    extends Composer<_$AppDatabase, $VentesTable> {
  $$VentesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateVente => $composableBuilder(
    column: $table.dateVente,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get montantTotal => $composableBuilder(
    column: $table.montantTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modePaiement => $composableBuilder(
    column: $table.modePaiement,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> venteDetailsRefs(
    Expression<bool> Function($$VenteDetailsTableFilterComposer f) f,
  ) {
    final $$VenteDetailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.venteDetails,
      getReferencedColumn: (t) => t.venteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VenteDetailsTableFilterComposer(
            $db: $db,
            $table: $db.venteDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> facturesRefs(
    Expression<bool> Function($$FacturesTableFilterComposer f) f,
  ) {
    final $$FacturesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.factures,
      getReferencedColumn: (t) => t.venteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FacturesTableFilterComposer(
            $db: $db,
            $table: $db.factures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VentesTableOrderingComposer
    extends Composer<_$AppDatabase, $VentesTable> {
  $$VentesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateVente => $composableBuilder(
    column: $table.dateVente,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get montantTotal => $composableBuilder(
    column: $table.montantTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modePaiement => $composableBuilder(
    column: $table.modePaiement,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VentesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VentesTable> {
  $$VentesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get dateVente =>
      $composableBuilder(column: $table.dateVente, builder: (column) => column);

  GeneratedColumn<double> get montantTotal => $composableBuilder(
    column: $table.montantTotal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modePaiement => $composableBuilder(
    column: $table.modePaiement,
    builder: (column) => column,
  );

  Expression<T> venteDetailsRefs<T extends Object>(
    Expression<T> Function($$VenteDetailsTableAnnotationComposer a) f,
  ) {
    final $$VenteDetailsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.venteDetails,
      getReferencedColumn: (t) => t.venteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VenteDetailsTableAnnotationComposer(
            $db: $db,
            $table: $db.venteDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> facturesRefs<T extends Object>(
    Expression<T> Function($$FacturesTableAnnotationComposer a) f,
  ) {
    final $$FacturesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.factures,
      getReferencedColumn: (t) => t.venteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FacturesTableAnnotationComposer(
            $db: $db,
            $table: $db.factures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VentesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VentesTable,
          Vente,
          $$VentesTableFilterComposer,
          $$VentesTableOrderingComposer,
          $$VentesTableAnnotationComposer,
          $$VentesTableCreateCompanionBuilder,
          $$VentesTableUpdateCompanionBuilder,
          (Vente, $$VentesTableReferences),
          Vente,
          PrefetchHooks Function({bool venteDetailsRefs, bool facturesRefs})
        > {
  $$VentesTableTableManager(_$AppDatabase db, $VentesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VentesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VentesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VentesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> dateVente = const Value.absent(),
                Value<double> montantTotal = const Value.absent(),
                Value<String> modePaiement = const Value.absent(),
              }) => VentesCompanion(
                id: id,
                dateVente: dateVente,
                montantTotal: montantTotal,
                modePaiement: modePaiement,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime dateVente,
                required double montantTotal,
                required String modePaiement,
              }) => VentesCompanion.insert(
                id: id,
                dateVente: dateVente,
                montantTotal: montantTotal,
                modePaiement: modePaiement,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$VentesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({venteDetailsRefs = false, facturesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (venteDetailsRefs) db.venteDetails,
                    if (facturesRefs) db.factures,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (venteDetailsRefs)
                        await $_getPrefetchedData<
                          Vente,
                          $VentesTable,
                          VenteDetail
                        >(
                          currentTable: table,
                          referencedTable: $$VentesTableReferences
                              ._venteDetailsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VentesTableReferences(
                                db,
                                table,
                                p0,
                              ).venteDetailsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.venteId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (facturesRefs)
                        await $_getPrefetchedData<Vente, $VentesTable, Facture>(
                          currentTable: table,
                          referencedTable: $$VentesTableReferences
                              ._facturesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VentesTableReferences(
                                db,
                                table,
                                p0,
                              ).facturesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.venteId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VentesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VentesTable,
      Vente,
      $$VentesTableFilterComposer,
      $$VentesTableOrderingComposer,
      $$VentesTableAnnotationComposer,
      $$VentesTableCreateCompanionBuilder,
      $$VentesTableUpdateCompanionBuilder,
      (Vente, $$VentesTableReferences),
      Vente,
      PrefetchHooks Function({bool venteDetailsRefs, bool facturesRefs})
    >;
typedef $$VenteDetailsTableCreateCompanionBuilder =
    VenteDetailsCompanion Function({
      Value<int> id,
      required int venteId,
      required int produitId,
      required int quantite,
      required double prixUnitaire,
      required double sousTotal,
    });
typedef $$VenteDetailsTableUpdateCompanionBuilder =
    VenteDetailsCompanion Function({
      Value<int> id,
      Value<int> venteId,
      Value<int> produitId,
      Value<int> quantite,
      Value<double> prixUnitaire,
      Value<double> sousTotal,
    });

final class $$VenteDetailsTableReferences
    extends BaseReferences<_$AppDatabase, $VenteDetailsTable, VenteDetail> {
  $$VenteDetailsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VentesTable _venteIdTable(_$AppDatabase db) => db.ventes.createAlias(
    $_aliasNameGenerator(db.venteDetails.venteId, db.ventes.id),
  );

  $$VentesTableProcessedTableManager get venteId {
    final $_column = $_itemColumn<int>('vente_id')!;

    final manager = $$VentesTableTableManager(
      $_db,
      $_db.ventes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_venteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProduitsTable _produitIdTable(_$AppDatabase db) =>
      db.produits.createAlias(
        $_aliasNameGenerator(db.venteDetails.produitId, db.produits.id),
      );

  $$ProduitsTableProcessedTableManager get produitId {
    final $_column = $_itemColumn<int>('produit_id')!;

    final manager = $$ProduitsTableTableManager(
      $_db,
      $_db.produits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_produitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VenteDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $VenteDetailsTable> {
  $$VenteDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantite => $composableBuilder(
    column: $table.quantite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get prixUnitaire => $composableBuilder(
    column: $table.prixUnitaire,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sousTotal => $composableBuilder(
    column: $table.sousTotal,
    builder: (column) => ColumnFilters(column),
  );

  $$VentesTableFilterComposer get venteId {
    final $$VentesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.venteId,
      referencedTable: $db.ventes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentesTableFilterComposer(
            $db: $db,
            $table: $db.ventes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProduitsTableFilterComposer get produitId {
    final $$ProduitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.produitId,
      referencedTable: $db.produits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProduitsTableFilterComposer(
            $db: $db,
            $table: $db.produits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VenteDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $VenteDetailsTable> {
  $$VenteDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantite => $composableBuilder(
    column: $table.quantite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get prixUnitaire => $composableBuilder(
    column: $table.prixUnitaire,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sousTotal => $composableBuilder(
    column: $table.sousTotal,
    builder: (column) => ColumnOrderings(column),
  );

  $$VentesTableOrderingComposer get venteId {
    final $$VentesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.venteId,
      referencedTable: $db.ventes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentesTableOrderingComposer(
            $db: $db,
            $table: $db.ventes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProduitsTableOrderingComposer get produitId {
    final $$ProduitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.produitId,
      referencedTable: $db.produits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProduitsTableOrderingComposer(
            $db: $db,
            $table: $db.produits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VenteDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VenteDetailsTable> {
  $$VenteDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get quantite =>
      $composableBuilder(column: $table.quantite, builder: (column) => column);

  GeneratedColumn<double> get prixUnitaire => $composableBuilder(
    column: $table.prixUnitaire,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sousTotal =>
      $composableBuilder(column: $table.sousTotal, builder: (column) => column);

  $$VentesTableAnnotationComposer get venteId {
    final $$VentesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.venteId,
      referencedTable: $db.ventes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentesTableAnnotationComposer(
            $db: $db,
            $table: $db.ventes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProduitsTableAnnotationComposer get produitId {
    final $$ProduitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.produitId,
      referencedTable: $db.produits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProduitsTableAnnotationComposer(
            $db: $db,
            $table: $db.produits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VenteDetailsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VenteDetailsTable,
          VenteDetail,
          $$VenteDetailsTableFilterComposer,
          $$VenteDetailsTableOrderingComposer,
          $$VenteDetailsTableAnnotationComposer,
          $$VenteDetailsTableCreateCompanionBuilder,
          $$VenteDetailsTableUpdateCompanionBuilder,
          (VenteDetail, $$VenteDetailsTableReferences),
          VenteDetail,
          PrefetchHooks Function({bool venteId, bool produitId})
        > {
  $$VenteDetailsTableTableManager(_$AppDatabase db, $VenteDetailsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VenteDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VenteDetailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VenteDetailsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> venteId = const Value.absent(),
                Value<int> produitId = const Value.absent(),
                Value<int> quantite = const Value.absent(),
                Value<double> prixUnitaire = const Value.absent(),
                Value<double> sousTotal = const Value.absent(),
              }) => VenteDetailsCompanion(
                id: id,
                venteId: venteId,
                produitId: produitId,
                quantite: quantite,
                prixUnitaire: prixUnitaire,
                sousTotal: sousTotal,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int venteId,
                required int produitId,
                required int quantite,
                required double prixUnitaire,
                required double sousTotal,
              }) => VenteDetailsCompanion.insert(
                id: id,
                venteId: venteId,
                produitId: produitId,
                quantite: quantite,
                prixUnitaire: prixUnitaire,
                sousTotal: sousTotal,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VenteDetailsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({venteId = false, produitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (venteId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.venteId,
                                referencedTable: $$VenteDetailsTableReferences
                                    ._venteIdTable(db),
                                referencedColumn: $$VenteDetailsTableReferences
                                    ._venteIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (produitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.produitId,
                                referencedTable: $$VenteDetailsTableReferences
                                    ._produitIdTable(db),
                                referencedColumn: $$VenteDetailsTableReferences
                                    ._produitIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VenteDetailsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VenteDetailsTable,
      VenteDetail,
      $$VenteDetailsTableFilterComposer,
      $$VenteDetailsTableOrderingComposer,
      $$VenteDetailsTableAnnotationComposer,
      $$VenteDetailsTableCreateCompanionBuilder,
      $$VenteDetailsTableUpdateCompanionBuilder,
      (VenteDetail, $$VenteDetailsTableReferences),
      VenteDetail,
      PrefetchHooks Function({bool venteId, bool produitId})
    >;
typedef $$FacturesTableCreateCompanionBuilder =
    FacturesCompanion Function({
      Value<int> id,
      required int venteId,
      required String numeroFacture,
      required DateTime dateEmission,
      Value<String?> cheminPdf,
    });
typedef $$FacturesTableUpdateCompanionBuilder =
    FacturesCompanion Function({
      Value<int> id,
      Value<int> venteId,
      Value<String> numeroFacture,
      Value<DateTime> dateEmission,
      Value<String?> cheminPdf,
    });

final class $$FacturesTableReferences
    extends BaseReferences<_$AppDatabase, $FacturesTable, Facture> {
  $$FacturesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VentesTable _venteIdTable(_$AppDatabase db) => db.ventes.createAlias(
    $_aliasNameGenerator(db.factures.venteId, db.ventes.id),
  );

  $$VentesTableProcessedTableManager get venteId {
    final $_column = $_itemColumn<int>('vente_id')!;

    final manager = $$VentesTableTableManager(
      $_db,
      $_db.ventes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_venteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FacturesTableFilterComposer
    extends Composer<_$AppDatabase, $FacturesTable> {
  $$FacturesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get numeroFacture => $composableBuilder(
    column: $table.numeroFacture,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateEmission => $composableBuilder(
    column: $table.dateEmission,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cheminPdf => $composableBuilder(
    column: $table.cheminPdf,
    builder: (column) => ColumnFilters(column),
  );

  $$VentesTableFilterComposer get venteId {
    final $$VentesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.venteId,
      referencedTable: $db.ventes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentesTableFilterComposer(
            $db: $db,
            $table: $db.ventes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FacturesTableOrderingComposer
    extends Composer<_$AppDatabase, $FacturesTable> {
  $$FacturesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get numeroFacture => $composableBuilder(
    column: $table.numeroFacture,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateEmission => $composableBuilder(
    column: $table.dateEmission,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cheminPdf => $composableBuilder(
    column: $table.cheminPdf,
    builder: (column) => ColumnOrderings(column),
  );

  $$VentesTableOrderingComposer get venteId {
    final $$VentesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.venteId,
      referencedTable: $db.ventes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentesTableOrderingComposer(
            $db: $db,
            $table: $db.ventes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FacturesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FacturesTable> {
  $$FacturesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get numeroFacture => $composableBuilder(
    column: $table.numeroFacture,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateEmission => $composableBuilder(
    column: $table.dateEmission,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cheminPdf =>
      $composableBuilder(column: $table.cheminPdf, builder: (column) => column);

  $$VentesTableAnnotationComposer get venteId {
    final $$VentesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.venteId,
      referencedTable: $db.ventes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentesTableAnnotationComposer(
            $db: $db,
            $table: $db.ventes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FacturesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FacturesTable,
          Facture,
          $$FacturesTableFilterComposer,
          $$FacturesTableOrderingComposer,
          $$FacturesTableAnnotationComposer,
          $$FacturesTableCreateCompanionBuilder,
          $$FacturesTableUpdateCompanionBuilder,
          (Facture, $$FacturesTableReferences),
          Facture,
          PrefetchHooks Function({bool venteId})
        > {
  $$FacturesTableTableManager(_$AppDatabase db, $FacturesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FacturesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FacturesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FacturesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> venteId = const Value.absent(),
                Value<String> numeroFacture = const Value.absent(),
                Value<DateTime> dateEmission = const Value.absent(),
                Value<String?> cheminPdf = const Value.absent(),
              }) => FacturesCompanion(
                id: id,
                venteId: venteId,
                numeroFacture: numeroFacture,
                dateEmission: dateEmission,
                cheminPdf: cheminPdf,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int venteId,
                required String numeroFacture,
                required DateTime dateEmission,
                Value<String?> cheminPdf = const Value.absent(),
              }) => FacturesCompanion.insert(
                id: id,
                venteId: venteId,
                numeroFacture: numeroFacture,
                dateEmission: dateEmission,
                cheminPdf: cheminPdf,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FacturesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({venteId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (venteId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.venteId,
                                referencedTable: $$FacturesTableReferences
                                    ._venteIdTable(db),
                                referencedColumn: $$FacturesTableReferences
                                    ._venteIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FacturesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FacturesTable,
      Facture,
      $$FacturesTableFilterComposer,
      $$FacturesTableOrderingComposer,
      $$FacturesTableAnnotationComposer,
      $$FacturesTableCreateCompanionBuilder,
      $$FacturesTableUpdateCompanionBuilder,
      (Facture, $$FacturesTableReferences),
      Facture,
      PrefetchHooks Function({bool venteId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$ProduitsTableTableManager get produits =>
      $$ProduitsTableTableManager(_db, _db.produits);
  $$UtilisateursTableTableManager get utilisateurs =>
      $$UtilisateursTableTableManager(_db, _db.utilisateurs);
  $$VentesTableTableManager get ventes =>
      $$VentesTableTableManager(_db, _db.ventes);
  $$VenteDetailsTableTableManager get venteDetails =>
      $$VenteDetailsTableTableManager(_db, _db.venteDetails);
  $$FacturesTableTableManager get factures =>
      $$FacturesTableTableManager(_db, _db.factures);
}
