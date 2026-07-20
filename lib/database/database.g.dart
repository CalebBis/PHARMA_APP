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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _pharmacieIdMeta = const VerificationMeta(
    'pharmacieId',
  );
  @override
  late final GeneratedColumn<String> pharmacieId = GeneratedColumn<String>(
    'pharmacie_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pharmacieId,
    nom,
    updatedAt,
    isSynced,
    isDeleted,
  ];
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
    if (data.containsKey('pharmacie_id')) {
      context.handle(
        _pharmacieIdMeta,
        pharmacieId.isAcceptableOrUnknown(
          data['pharmacie_id']!,
          _pharmacieIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pharmacieIdMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
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
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pharmacieId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pharmacie_id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String pharmacieId;
  final String nom;
  final DateTime updatedAt;
  final bool isSynced;
  final bool isDeleted;
  const Category({
    required this.id,
    required this.pharmacieId,
    required this.nom,
    required this.updatedAt,
    required this.isSynced,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pharmacie_id'] = Variable<String>(pharmacieId);
    map['nom'] = Variable<String>(nom);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      pharmacieId: Value(pharmacieId),
      nom: Value(nom),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
      isDeleted: Value(isDeleted),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      pharmacieId: serializer.fromJson<String>(json['pharmacieId']),
      nom: serializer.fromJson<String>(json['nom']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pharmacieId': serializer.toJson<String>(pharmacieId),
      'nom': serializer.toJson<String>(nom),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Category copyWith({
    String? id,
    String? pharmacieId,
    String? nom,
    DateTime? updatedAt,
    bool? isSynced,
    bool? isDeleted,
  }) => Category(
    id: id ?? this.id,
    pharmacieId: pharmacieId ?? this.pharmacieId,
    nom: nom ?? this.nom,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      pharmacieId: data.pharmacieId.present
          ? data.pharmacieId.value
          : this.pharmacieId,
      nom: data.nom.present ? data.nom.value : this.nom,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('pharmacieId: $pharmacieId, ')
          ..write('nom: $nom, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, pharmacieId, nom, updatedAt, isSynced, isDeleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.pharmacieId == this.pharmacieId &&
          other.nom == this.nom &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced &&
          other.isDeleted == this.isDeleted);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> pharmacieId;
  final Value<String> nom;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.pharmacieId = const Value.absent(),
    this.nom = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String pharmacieId,
    required String nom,
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : pharmacieId = Value(pharmacieId),
       nom = Value(nom);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? pharmacieId,
    Expression<String>? nom,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pharmacieId != null) 'pharmacie_id': pharmacieId,
      if (nom != null) 'nom': nom,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? pharmacieId,
    Value<String>? nom,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<bool>? isDeleted,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      pharmacieId: pharmacieId ?? this.pharmacieId,
      nom: nom ?? this.nom,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pharmacieId.present) {
      map['pharmacie_id'] = Variable<String>(pharmacieId.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('pharmacieId: $pharmacieId, ')
          ..write('nom: $nom, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _pharmacieIdMeta = const VerificationMeta(
    'pharmacieId',
  );
  @override
  late final GeneratedColumn<String> pharmacieId = GeneratedColumn<String>(
    'pharmacie_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  late final GeneratedColumn<String> categorieId = GeneratedColumn<String>(
    'categorie_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pharmacieId,
    nom,
    categorieId,
    prixAchat,
    prixVente,
    quantiteStock,
    seuilAlerte,
    datePeremption,
    dateCreation,
    updatedAt,
    isSynced,
    isDeleted,
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
    if (data.containsKey('pharmacie_id')) {
      context.handle(
        _pharmacieIdMeta,
        pharmacieId.isAcceptableOrUnknown(
          data['pharmacie_id']!,
          _pharmacieIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pharmacieIdMeta);
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
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
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
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pharmacieId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pharmacie_id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      categorieId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categorie_id'],
      ),
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
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $ProduitsTable createAlias(String alias) {
    return $ProduitsTable(attachedDatabase, alias);
  }
}

class Produit extends DataClass implements Insertable<Produit> {
  final String id;
  final String pharmacieId;
  final String nom;
  final String? categorieId;
  final double prixAchat;
  final double prixVente;
  final int quantiteStock;
  final int seuilAlerte;
  final DateTime? datePeremption;
  final DateTime dateCreation;
  final DateTime updatedAt;
  final bool isSynced;
  final bool isDeleted;
  const Produit({
    required this.id,
    required this.pharmacieId,
    required this.nom,
    this.categorieId,
    required this.prixAchat,
    required this.prixVente,
    required this.quantiteStock,
    required this.seuilAlerte,
    this.datePeremption,
    required this.dateCreation,
    required this.updatedAt,
    required this.isSynced,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pharmacie_id'] = Variable<String>(pharmacieId);
    map['nom'] = Variable<String>(nom);
    if (!nullToAbsent || categorieId != null) {
      map['categorie_id'] = Variable<String>(categorieId);
    }
    map['prix_achat'] = Variable<double>(prixAchat);
    map['prix_vente'] = Variable<double>(prixVente);
    map['quantite_stock'] = Variable<int>(quantiteStock);
    map['seuil_alerte'] = Variable<int>(seuilAlerte);
    if (!nullToAbsent || datePeremption != null) {
      map['date_peremption'] = Variable<DateTime>(datePeremption);
    }
    map['date_creation'] = Variable<DateTime>(dateCreation);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  ProduitsCompanion toCompanion(bool nullToAbsent) {
    return ProduitsCompanion(
      id: Value(id),
      pharmacieId: Value(pharmacieId),
      nom: Value(nom),
      categorieId: categorieId == null && nullToAbsent
          ? const Value.absent()
          : Value(categorieId),
      prixAchat: Value(prixAchat),
      prixVente: Value(prixVente),
      quantiteStock: Value(quantiteStock),
      seuilAlerte: Value(seuilAlerte),
      datePeremption: datePeremption == null && nullToAbsent
          ? const Value.absent()
          : Value(datePeremption),
      dateCreation: Value(dateCreation),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
      isDeleted: Value(isDeleted),
    );
  }

  factory Produit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Produit(
      id: serializer.fromJson<String>(json['id']),
      pharmacieId: serializer.fromJson<String>(json['pharmacieId']),
      nom: serializer.fromJson<String>(json['nom']),
      categorieId: serializer.fromJson<String?>(json['categorieId']),
      prixAchat: serializer.fromJson<double>(json['prixAchat']),
      prixVente: serializer.fromJson<double>(json['prixVente']),
      quantiteStock: serializer.fromJson<int>(json['quantiteStock']),
      seuilAlerte: serializer.fromJson<int>(json['seuilAlerte']),
      datePeremption: serializer.fromJson<DateTime?>(json['datePeremption']),
      dateCreation: serializer.fromJson<DateTime>(json['dateCreation']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pharmacieId': serializer.toJson<String>(pharmacieId),
      'nom': serializer.toJson<String>(nom),
      'categorieId': serializer.toJson<String?>(categorieId),
      'prixAchat': serializer.toJson<double>(prixAchat),
      'prixVente': serializer.toJson<double>(prixVente),
      'quantiteStock': serializer.toJson<int>(quantiteStock),
      'seuilAlerte': serializer.toJson<int>(seuilAlerte),
      'datePeremption': serializer.toJson<DateTime?>(datePeremption),
      'dateCreation': serializer.toJson<DateTime>(dateCreation),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Produit copyWith({
    String? id,
    String? pharmacieId,
    String? nom,
    Value<String?> categorieId = const Value.absent(),
    double? prixAchat,
    double? prixVente,
    int? quantiteStock,
    int? seuilAlerte,
    Value<DateTime?> datePeremption = const Value.absent(),
    DateTime? dateCreation,
    DateTime? updatedAt,
    bool? isSynced,
    bool? isDeleted,
  }) => Produit(
    id: id ?? this.id,
    pharmacieId: pharmacieId ?? this.pharmacieId,
    nom: nom ?? this.nom,
    categorieId: categorieId.present ? categorieId.value : this.categorieId,
    prixAchat: prixAchat ?? this.prixAchat,
    prixVente: prixVente ?? this.prixVente,
    quantiteStock: quantiteStock ?? this.quantiteStock,
    seuilAlerte: seuilAlerte ?? this.seuilAlerte,
    datePeremption: datePeremption.present
        ? datePeremption.value
        : this.datePeremption,
    dateCreation: dateCreation ?? this.dateCreation,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Produit copyWithCompanion(ProduitsCompanion data) {
    return Produit(
      id: data.id.present ? data.id.value : this.id,
      pharmacieId: data.pharmacieId.present
          ? data.pharmacieId.value
          : this.pharmacieId,
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
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Produit(')
          ..write('id: $id, ')
          ..write('pharmacieId: $pharmacieId, ')
          ..write('nom: $nom, ')
          ..write('categorieId: $categorieId, ')
          ..write('prixAchat: $prixAchat, ')
          ..write('prixVente: $prixVente, ')
          ..write('quantiteStock: $quantiteStock, ')
          ..write('seuilAlerte: $seuilAlerte, ')
          ..write('datePeremption: $datePeremption, ')
          ..write('dateCreation: $dateCreation, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pharmacieId,
    nom,
    categorieId,
    prixAchat,
    prixVente,
    quantiteStock,
    seuilAlerte,
    datePeremption,
    dateCreation,
    updatedAt,
    isSynced,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Produit &&
          other.id == this.id &&
          other.pharmacieId == this.pharmacieId &&
          other.nom == this.nom &&
          other.categorieId == this.categorieId &&
          other.prixAchat == this.prixAchat &&
          other.prixVente == this.prixVente &&
          other.quantiteStock == this.quantiteStock &&
          other.seuilAlerte == this.seuilAlerte &&
          other.datePeremption == this.datePeremption &&
          other.dateCreation == this.dateCreation &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced &&
          other.isDeleted == this.isDeleted);
}

class ProduitsCompanion extends UpdateCompanion<Produit> {
  final Value<String> id;
  final Value<String> pharmacieId;
  final Value<String> nom;
  final Value<String?> categorieId;
  final Value<double> prixAchat;
  final Value<double> prixVente;
  final Value<int> quantiteStock;
  final Value<int> seuilAlerte;
  final Value<DateTime?> datePeremption;
  final Value<DateTime> dateCreation;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const ProduitsCompanion({
    this.id = const Value.absent(),
    this.pharmacieId = const Value.absent(),
    this.nom = const Value.absent(),
    this.categorieId = const Value.absent(),
    this.prixAchat = const Value.absent(),
    this.prixVente = const Value.absent(),
    this.quantiteStock = const Value.absent(),
    this.seuilAlerte = const Value.absent(),
    this.datePeremption = const Value.absent(),
    this.dateCreation = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProduitsCompanion.insert({
    this.id = const Value.absent(),
    required String pharmacieId,
    required String nom,
    this.categorieId = const Value.absent(),
    required double prixAchat,
    required double prixVente,
    required int quantiteStock,
    required int seuilAlerte,
    this.datePeremption = const Value.absent(),
    required DateTime dateCreation,
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : pharmacieId = Value(pharmacieId),
       nom = Value(nom),
       prixAchat = Value(prixAchat),
       prixVente = Value(prixVente),
       quantiteStock = Value(quantiteStock),
       seuilAlerte = Value(seuilAlerte),
       dateCreation = Value(dateCreation);
  static Insertable<Produit> custom({
    Expression<String>? id,
    Expression<String>? pharmacieId,
    Expression<String>? nom,
    Expression<String>? categorieId,
    Expression<double>? prixAchat,
    Expression<double>? prixVente,
    Expression<int>? quantiteStock,
    Expression<int>? seuilAlerte,
    Expression<DateTime>? datePeremption,
    Expression<DateTime>? dateCreation,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pharmacieId != null) 'pharmacie_id': pharmacieId,
      if (nom != null) 'nom': nom,
      if (categorieId != null) 'categorie_id': categorieId,
      if (prixAchat != null) 'prix_achat': prixAchat,
      if (prixVente != null) 'prix_vente': prixVente,
      if (quantiteStock != null) 'quantite_stock': quantiteStock,
      if (seuilAlerte != null) 'seuil_alerte': seuilAlerte,
      if (datePeremption != null) 'date_peremption': datePeremption,
      if (dateCreation != null) 'date_creation': dateCreation,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProduitsCompanion copyWith({
    Value<String>? id,
    Value<String>? pharmacieId,
    Value<String>? nom,
    Value<String?>? categorieId,
    Value<double>? prixAchat,
    Value<double>? prixVente,
    Value<int>? quantiteStock,
    Value<int>? seuilAlerte,
    Value<DateTime?>? datePeremption,
    Value<DateTime>? dateCreation,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<bool>? isDeleted,
    Value<int>? rowid,
  }) {
    return ProduitsCompanion(
      id: id ?? this.id,
      pharmacieId: pharmacieId ?? this.pharmacieId,
      nom: nom ?? this.nom,
      categorieId: categorieId ?? this.categorieId,
      prixAchat: prixAchat ?? this.prixAchat,
      prixVente: prixVente ?? this.prixVente,
      quantiteStock: quantiteStock ?? this.quantiteStock,
      seuilAlerte: seuilAlerte ?? this.seuilAlerte,
      datePeremption: datePeremption ?? this.datePeremption,
      dateCreation: dateCreation ?? this.dateCreation,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pharmacieId.present) {
      map['pharmacie_id'] = Variable<String>(pharmacieId.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (categorieId.present) {
      map['categorie_id'] = Variable<String>(categorieId.value);
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
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProduitsCompanion(')
          ..write('id: $id, ')
          ..write('pharmacieId: $pharmacieId, ')
          ..write('nom: $nom, ')
          ..write('categorieId: $categorieId, ')
          ..write('prixAchat: $prixAchat, ')
          ..write('prixVente: $prixVente, ')
          ..write('quantiteStock: $quantiteStock, ')
          ..write('seuilAlerte: $seuilAlerte, ')
          ..write('datePeremption: $datePeremption, ')
          ..write('dateCreation: $dateCreation, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pharmacieIdMeta = const VerificationMeta(
    'pharmacieId',
  );
  @override
  late final GeneratedColumn<String> pharmacieId = GeneratedColumn<String>(
    'pharmacie_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prenomMeta = const VerificationMeta('prenom');
  @override
  late final GeneratedColumn<String> prenom = GeneratedColumn<String>(
    'prenom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _derniereConnexionMeta = const VerificationMeta(
    'derniereConnexion',
  );
  @override
  late final GeneratedColumn<DateTime> derniereConnexion =
      GeneratedColumn<DateTime>(
        'derniere_connexion',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pharmacieId,
    email,
    prenom,
    nom,
    role,
    derniereConnexion,
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
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pharmacie_id')) {
      context.handle(
        _pharmacieIdMeta,
        pharmacieId.isAcceptableOrUnknown(
          data['pharmacie_id']!,
          _pharmacieIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pharmacieIdMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('prenom')) {
      context.handle(
        _prenomMeta,
        prenom.isAcceptableOrUnknown(data['prenom']!, _prenomMeta),
      );
    } else if (isInserting) {
      context.missing(_prenomMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('derniere_connexion')) {
      context.handle(
        _derniereConnexionMeta,
        derniereConnexion.isAcceptableOrUnknown(
          data['derniere_connexion']!,
          _derniereConnexionMeta,
        ),
      );
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
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pharmacieId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pharmacie_id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      prenom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prenom'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      derniereConnexion: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}derniere_connexion'],
      ),
    );
  }

  @override
  $UtilisateursTable createAlias(String alias) {
    return $UtilisateursTable(attachedDatabase, alias);
  }
}

class Utilisateur extends DataClass implements Insertable<Utilisateur> {
  final String id;
  final String pharmacieId;
  final String email;
  final String prenom;
  final String nom;
  final String role;
  final DateTime? derniereConnexion;
  const Utilisateur({
    required this.id,
    required this.pharmacieId,
    required this.email,
    required this.prenom,
    required this.nom,
    required this.role,
    this.derniereConnexion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pharmacie_id'] = Variable<String>(pharmacieId);
    map['email'] = Variable<String>(email);
    map['prenom'] = Variable<String>(prenom);
    map['nom'] = Variable<String>(nom);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || derniereConnexion != null) {
      map['derniere_connexion'] = Variable<DateTime>(derniereConnexion);
    }
    return map;
  }

  UtilisateursCompanion toCompanion(bool nullToAbsent) {
    return UtilisateursCompanion(
      id: Value(id),
      pharmacieId: Value(pharmacieId),
      email: Value(email),
      prenom: Value(prenom),
      nom: Value(nom),
      role: Value(role),
      derniereConnexion: derniereConnexion == null && nullToAbsent
          ? const Value.absent()
          : Value(derniereConnexion),
    );
  }

  factory Utilisateur.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Utilisateur(
      id: serializer.fromJson<String>(json['id']),
      pharmacieId: serializer.fromJson<String>(json['pharmacieId']),
      email: serializer.fromJson<String>(json['email']),
      prenom: serializer.fromJson<String>(json['prenom']),
      nom: serializer.fromJson<String>(json['nom']),
      role: serializer.fromJson<String>(json['role']),
      derniereConnexion: serializer.fromJson<DateTime?>(
        json['derniereConnexion'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pharmacieId': serializer.toJson<String>(pharmacieId),
      'email': serializer.toJson<String>(email),
      'prenom': serializer.toJson<String>(prenom),
      'nom': serializer.toJson<String>(nom),
      'role': serializer.toJson<String>(role),
      'derniereConnexion': serializer.toJson<DateTime?>(derniereConnexion),
    };
  }

  Utilisateur copyWith({
    String? id,
    String? pharmacieId,
    String? email,
    String? prenom,
    String? nom,
    String? role,
    Value<DateTime?> derniereConnexion = const Value.absent(),
  }) => Utilisateur(
    id: id ?? this.id,
    pharmacieId: pharmacieId ?? this.pharmacieId,
    email: email ?? this.email,
    prenom: prenom ?? this.prenom,
    nom: nom ?? this.nom,
    role: role ?? this.role,
    derniereConnexion: derniereConnexion.present
        ? derniereConnexion.value
        : this.derniereConnexion,
  );
  Utilisateur copyWithCompanion(UtilisateursCompanion data) {
    return Utilisateur(
      id: data.id.present ? data.id.value : this.id,
      pharmacieId: data.pharmacieId.present
          ? data.pharmacieId.value
          : this.pharmacieId,
      email: data.email.present ? data.email.value : this.email,
      prenom: data.prenom.present ? data.prenom.value : this.prenom,
      nom: data.nom.present ? data.nom.value : this.nom,
      role: data.role.present ? data.role.value : this.role,
      derniereConnexion: data.derniereConnexion.present
          ? data.derniereConnexion.value
          : this.derniereConnexion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Utilisateur(')
          ..write('id: $id, ')
          ..write('pharmacieId: $pharmacieId, ')
          ..write('email: $email, ')
          ..write('prenom: $prenom, ')
          ..write('nom: $nom, ')
          ..write('role: $role, ')
          ..write('derniereConnexion: $derniereConnexion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, pharmacieId, email, prenom, nom, role, derniereConnexion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Utilisateur &&
          other.id == this.id &&
          other.pharmacieId == this.pharmacieId &&
          other.email == this.email &&
          other.prenom == this.prenom &&
          other.nom == this.nom &&
          other.role == this.role &&
          other.derniereConnexion == this.derniereConnexion);
}

class UtilisateursCompanion extends UpdateCompanion<Utilisateur> {
  final Value<String> id;
  final Value<String> pharmacieId;
  final Value<String> email;
  final Value<String> prenom;
  final Value<String> nom;
  final Value<String> role;
  final Value<DateTime?> derniereConnexion;
  final Value<int> rowid;
  const UtilisateursCompanion({
    this.id = const Value.absent(),
    this.pharmacieId = const Value.absent(),
    this.email = const Value.absent(),
    this.prenom = const Value.absent(),
    this.nom = const Value.absent(),
    this.role = const Value.absent(),
    this.derniereConnexion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UtilisateursCompanion.insert({
    required String id,
    required String pharmacieId,
    required String email,
    required String prenom,
    required String nom,
    required String role,
    this.derniereConnexion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       pharmacieId = Value(pharmacieId),
       email = Value(email),
       prenom = Value(prenom),
       nom = Value(nom),
       role = Value(role);
  static Insertable<Utilisateur> custom({
    Expression<String>? id,
    Expression<String>? pharmacieId,
    Expression<String>? email,
    Expression<String>? prenom,
    Expression<String>? nom,
    Expression<String>? role,
    Expression<DateTime>? derniereConnexion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pharmacieId != null) 'pharmacie_id': pharmacieId,
      if (email != null) 'email': email,
      if (prenom != null) 'prenom': prenom,
      if (nom != null) 'nom': nom,
      if (role != null) 'role': role,
      if (derniereConnexion != null) 'derniere_connexion': derniereConnexion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UtilisateursCompanion copyWith({
    Value<String>? id,
    Value<String>? pharmacieId,
    Value<String>? email,
    Value<String>? prenom,
    Value<String>? nom,
    Value<String>? role,
    Value<DateTime?>? derniereConnexion,
    Value<int>? rowid,
  }) {
    return UtilisateursCompanion(
      id: id ?? this.id,
      pharmacieId: pharmacieId ?? this.pharmacieId,
      email: email ?? this.email,
      prenom: prenom ?? this.prenom,
      nom: nom ?? this.nom,
      role: role ?? this.role,
      derniereConnexion: derniereConnexion ?? this.derniereConnexion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pharmacieId.present) {
      map['pharmacie_id'] = Variable<String>(pharmacieId.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (prenom.present) {
      map['prenom'] = Variable<String>(prenom.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (derniereConnexion.present) {
      map['derniere_connexion'] = Variable<DateTime>(derniereConnexion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UtilisateursCompanion(')
          ..write('id: $id, ')
          ..write('pharmacieId: $pharmacieId, ')
          ..write('email: $email, ')
          ..write('prenom: $prenom, ')
          ..write('nom: $nom, ')
          ..write('role: $role, ')
          ..write('derniereConnexion: $derniereConnexion, ')
          ..write('rowid: $rowid')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _pharmacieIdMeta = const VerificationMeta(
    'pharmacieId',
  );
  @override
  late final GeneratedColumn<String> pharmacieId = GeneratedColumn<String>(
    'pharmacie_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pharmacieId,
    dateVente,
    montantTotal,
    modePaiement,
    updatedAt,
    isSynced,
    isDeleted,
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
    if (data.containsKey('pharmacie_id')) {
      context.handle(
        _pharmacieIdMeta,
        pharmacieId.isAcceptableOrUnknown(
          data['pharmacie_id']!,
          _pharmacieIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pharmacieIdMeta);
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
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
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
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pharmacieId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pharmacie_id'],
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
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $VentesTable createAlias(String alias) {
    return $VentesTable(attachedDatabase, alias);
  }
}

class Vente extends DataClass implements Insertable<Vente> {
  final String id;
  final String pharmacieId;
  final DateTime dateVente;
  final double montantTotal;
  final String modePaiement;
  final DateTime updatedAt;
  final bool isSynced;
  final bool isDeleted;
  const Vente({
    required this.id,
    required this.pharmacieId,
    required this.dateVente,
    required this.montantTotal,
    required this.modePaiement,
    required this.updatedAt,
    required this.isSynced,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pharmacie_id'] = Variable<String>(pharmacieId);
    map['date_vente'] = Variable<DateTime>(dateVente);
    map['montant_total'] = Variable<double>(montantTotal);
    map['mode_paiement'] = Variable<String>(modePaiement);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  VentesCompanion toCompanion(bool nullToAbsent) {
    return VentesCompanion(
      id: Value(id),
      pharmacieId: Value(pharmacieId),
      dateVente: Value(dateVente),
      montantTotal: Value(montantTotal),
      modePaiement: Value(modePaiement),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
      isDeleted: Value(isDeleted),
    );
  }

  factory Vente.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vente(
      id: serializer.fromJson<String>(json['id']),
      pharmacieId: serializer.fromJson<String>(json['pharmacieId']),
      dateVente: serializer.fromJson<DateTime>(json['dateVente']),
      montantTotal: serializer.fromJson<double>(json['montantTotal']),
      modePaiement: serializer.fromJson<String>(json['modePaiement']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pharmacieId': serializer.toJson<String>(pharmacieId),
      'dateVente': serializer.toJson<DateTime>(dateVente),
      'montantTotal': serializer.toJson<double>(montantTotal),
      'modePaiement': serializer.toJson<String>(modePaiement),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Vente copyWith({
    String? id,
    String? pharmacieId,
    DateTime? dateVente,
    double? montantTotal,
    String? modePaiement,
    DateTime? updatedAt,
    bool? isSynced,
    bool? isDeleted,
  }) => Vente(
    id: id ?? this.id,
    pharmacieId: pharmacieId ?? this.pharmacieId,
    dateVente: dateVente ?? this.dateVente,
    montantTotal: montantTotal ?? this.montantTotal,
    modePaiement: modePaiement ?? this.modePaiement,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Vente copyWithCompanion(VentesCompanion data) {
    return Vente(
      id: data.id.present ? data.id.value : this.id,
      pharmacieId: data.pharmacieId.present
          ? data.pharmacieId.value
          : this.pharmacieId,
      dateVente: data.dateVente.present ? data.dateVente.value : this.dateVente,
      montantTotal: data.montantTotal.present
          ? data.montantTotal.value
          : this.montantTotal,
      modePaiement: data.modePaiement.present
          ? data.modePaiement.value
          : this.modePaiement,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vente(')
          ..write('id: $id, ')
          ..write('pharmacieId: $pharmacieId, ')
          ..write('dateVente: $dateVente, ')
          ..write('montantTotal: $montantTotal, ')
          ..write('modePaiement: $modePaiement, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pharmacieId,
    dateVente,
    montantTotal,
    modePaiement,
    updatedAt,
    isSynced,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vente &&
          other.id == this.id &&
          other.pharmacieId == this.pharmacieId &&
          other.dateVente == this.dateVente &&
          other.montantTotal == this.montantTotal &&
          other.modePaiement == this.modePaiement &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced &&
          other.isDeleted == this.isDeleted);
}

class VentesCompanion extends UpdateCompanion<Vente> {
  final Value<String> id;
  final Value<String> pharmacieId;
  final Value<DateTime> dateVente;
  final Value<double> montantTotal;
  final Value<String> modePaiement;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const VentesCompanion({
    this.id = const Value.absent(),
    this.pharmacieId = const Value.absent(),
    this.dateVente = const Value.absent(),
    this.montantTotal = const Value.absent(),
    this.modePaiement = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VentesCompanion.insert({
    this.id = const Value.absent(),
    required String pharmacieId,
    required DateTime dateVente,
    required double montantTotal,
    required String modePaiement,
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : pharmacieId = Value(pharmacieId),
       dateVente = Value(dateVente),
       montantTotal = Value(montantTotal),
       modePaiement = Value(modePaiement);
  static Insertable<Vente> custom({
    Expression<String>? id,
    Expression<String>? pharmacieId,
    Expression<DateTime>? dateVente,
    Expression<double>? montantTotal,
    Expression<String>? modePaiement,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pharmacieId != null) 'pharmacie_id': pharmacieId,
      if (dateVente != null) 'date_vente': dateVente,
      if (montantTotal != null) 'montant_total': montantTotal,
      if (modePaiement != null) 'mode_paiement': modePaiement,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VentesCompanion copyWith({
    Value<String>? id,
    Value<String>? pharmacieId,
    Value<DateTime>? dateVente,
    Value<double>? montantTotal,
    Value<String>? modePaiement,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<bool>? isDeleted,
    Value<int>? rowid,
  }) {
    return VentesCompanion(
      id: id ?? this.id,
      pharmacieId: pharmacieId ?? this.pharmacieId,
      dateVente: dateVente ?? this.dateVente,
      montantTotal: montantTotal ?? this.montantTotal,
      modePaiement: modePaiement ?? this.modePaiement,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pharmacieId.present) {
      map['pharmacie_id'] = Variable<String>(pharmacieId.value);
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
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VentesCompanion(')
          ..write('id: $id, ')
          ..write('pharmacieId: $pharmacieId, ')
          ..write('dateVente: $dateVente, ')
          ..write('montantTotal: $montantTotal, ')
          ..write('modePaiement: $modePaiement, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _pharmacieIdMeta = const VerificationMeta(
    'pharmacieId',
  );
  @override
  late final GeneratedColumn<String> pharmacieId = GeneratedColumn<String>(
    'pharmacie_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venteIdMeta = const VerificationMeta(
    'venteId',
  );
  @override
  late final GeneratedColumn<String> venteId = GeneratedColumn<String>(
    'vente_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ventes (id)',
    ),
  );
  static const VerificationMeta _produitIdMeta = const VerificationMeta(
    'produitId',
  );
  @override
  late final GeneratedColumn<String> produitId = GeneratedColumn<String>(
    'produit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pharmacieId,
    venteId,
    produitId,
    quantite,
    prixUnitaire,
    sousTotal,
    updatedAt,
    isSynced,
    isDeleted,
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
    if (data.containsKey('pharmacie_id')) {
      context.handle(
        _pharmacieIdMeta,
        pharmacieId.isAcceptableOrUnknown(
          data['pharmacie_id']!,
          _pharmacieIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pharmacieIdMeta);
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
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
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
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pharmacieId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pharmacie_id'],
      )!,
      venteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vente_id'],
      )!,
      produitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
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
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $VenteDetailsTable createAlias(String alias) {
    return $VenteDetailsTable(attachedDatabase, alias);
  }
}

class VenteDetail extends DataClass implements Insertable<VenteDetail> {
  final String id;
  final String pharmacieId;
  final String venteId;
  final String produitId;
  final int quantite;
  final double prixUnitaire;
  final double sousTotal;
  final DateTime updatedAt;
  final bool isSynced;
  final bool isDeleted;
  const VenteDetail({
    required this.id,
    required this.pharmacieId,
    required this.venteId,
    required this.produitId,
    required this.quantite,
    required this.prixUnitaire,
    required this.sousTotal,
    required this.updatedAt,
    required this.isSynced,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pharmacie_id'] = Variable<String>(pharmacieId);
    map['vente_id'] = Variable<String>(venteId);
    map['produit_id'] = Variable<String>(produitId);
    map['quantite'] = Variable<int>(quantite);
    map['prix_unitaire'] = Variable<double>(prixUnitaire);
    map['sous_total'] = Variable<double>(sousTotal);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  VenteDetailsCompanion toCompanion(bool nullToAbsent) {
    return VenteDetailsCompanion(
      id: Value(id),
      pharmacieId: Value(pharmacieId),
      venteId: Value(venteId),
      produitId: Value(produitId),
      quantite: Value(quantite),
      prixUnitaire: Value(prixUnitaire),
      sousTotal: Value(sousTotal),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
      isDeleted: Value(isDeleted),
    );
  }

  factory VenteDetail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VenteDetail(
      id: serializer.fromJson<String>(json['id']),
      pharmacieId: serializer.fromJson<String>(json['pharmacieId']),
      venteId: serializer.fromJson<String>(json['venteId']),
      produitId: serializer.fromJson<String>(json['produitId']),
      quantite: serializer.fromJson<int>(json['quantite']),
      prixUnitaire: serializer.fromJson<double>(json['prixUnitaire']),
      sousTotal: serializer.fromJson<double>(json['sousTotal']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pharmacieId': serializer.toJson<String>(pharmacieId),
      'venteId': serializer.toJson<String>(venteId),
      'produitId': serializer.toJson<String>(produitId),
      'quantite': serializer.toJson<int>(quantite),
      'prixUnitaire': serializer.toJson<double>(prixUnitaire),
      'sousTotal': serializer.toJson<double>(sousTotal),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  VenteDetail copyWith({
    String? id,
    String? pharmacieId,
    String? venteId,
    String? produitId,
    int? quantite,
    double? prixUnitaire,
    double? sousTotal,
    DateTime? updatedAt,
    bool? isSynced,
    bool? isDeleted,
  }) => VenteDetail(
    id: id ?? this.id,
    pharmacieId: pharmacieId ?? this.pharmacieId,
    venteId: venteId ?? this.venteId,
    produitId: produitId ?? this.produitId,
    quantite: quantite ?? this.quantite,
    prixUnitaire: prixUnitaire ?? this.prixUnitaire,
    sousTotal: sousTotal ?? this.sousTotal,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  VenteDetail copyWithCompanion(VenteDetailsCompanion data) {
    return VenteDetail(
      id: data.id.present ? data.id.value : this.id,
      pharmacieId: data.pharmacieId.present
          ? data.pharmacieId.value
          : this.pharmacieId,
      venteId: data.venteId.present ? data.venteId.value : this.venteId,
      produitId: data.produitId.present ? data.produitId.value : this.produitId,
      quantite: data.quantite.present ? data.quantite.value : this.quantite,
      prixUnitaire: data.prixUnitaire.present
          ? data.prixUnitaire.value
          : this.prixUnitaire,
      sousTotal: data.sousTotal.present ? data.sousTotal.value : this.sousTotal,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VenteDetail(')
          ..write('id: $id, ')
          ..write('pharmacieId: $pharmacieId, ')
          ..write('venteId: $venteId, ')
          ..write('produitId: $produitId, ')
          ..write('quantite: $quantite, ')
          ..write('prixUnitaire: $prixUnitaire, ')
          ..write('sousTotal: $sousTotal, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pharmacieId,
    venteId,
    produitId,
    quantite,
    prixUnitaire,
    sousTotal,
    updatedAt,
    isSynced,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VenteDetail &&
          other.id == this.id &&
          other.pharmacieId == this.pharmacieId &&
          other.venteId == this.venteId &&
          other.produitId == this.produitId &&
          other.quantite == this.quantite &&
          other.prixUnitaire == this.prixUnitaire &&
          other.sousTotal == this.sousTotal &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced &&
          other.isDeleted == this.isDeleted);
}

class VenteDetailsCompanion extends UpdateCompanion<VenteDetail> {
  final Value<String> id;
  final Value<String> pharmacieId;
  final Value<String> venteId;
  final Value<String> produitId;
  final Value<int> quantite;
  final Value<double> prixUnitaire;
  final Value<double> sousTotal;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const VenteDetailsCompanion({
    this.id = const Value.absent(),
    this.pharmacieId = const Value.absent(),
    this.venteId = const Value.absent(),
    this.produitId = const Value.absent(),
    this.quantite = const Value.absent(),
    this.prixUnitaire = const Value.absent(),
    this.sousTotal = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VenteDetailsCompanion.insert({
    this.id = const Value.absent(),
    required String pharmacieId,
    required String venteId,
    required String produitId,
    required int quantite,
    required double prixUnitaire,
    required double sousTotal,
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : pharmacieId = Value(pharmacieId),
       venteId = Value(venteId),
       produitId = Value(produitId),
       quantite = Value(quantite),
       prixUnitaire = Value(prixUnitaire),
       sousTotal = Value(sousTotal);
  static Insertable<VenteDetail> custom({
    Expression<String>? id,
    Expression<String>? pharmacieId,
    Expression<String>? venteId,
    Expression<String>? produitId,
    Expression<int>? quantite,
    Expression<double>? prixUnitaire,
    Expression<double>? sousTotal,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pharmacieId != null) 'pharmacie_id': pharmacieId,
      if (venteId != null) 'vente_id': venteId,
      if (produitId != null) 'produit_id': produitId,
      if (quantite != null) 'quantite': quantite,
      if (prixUnitaire != null) 'prix_unitaire': prixUnitaire,
      if (sousTotal != null) 'sous_total': sousTotal,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VenteDetailsCompanion copyWith({
    Value<String>? id,
    Value<String>? pharmacieId,
    Value<String>? venteId,
    Value<String>? produitId,
    Value<int>? quantite,
    Value<double>? prixUnitaire,
    Value<double>? sousTotal,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<bool>? isDeleted,
    Value<int>? rowid,
  }) {
    return VenteDetailsCompanion(
      id: id ?? this.id,
      pharmacieId: pharmacieId ?? this.pharmacieId,
      venteId: venteId ?? this.venteId,
      produitId: produitId ?? this.produitId,
      quantite: quantite ?? this.quantite,
      prixUnitaire: prixUnitaire ?? this.prixUnitaire,
      sousTotal: sousTotal ?? this.sousTotal,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pharmacieId.present) {
      map['pharmacie_id'] = Variable<String>(pharmacieId.value);
    }
    if (venteId.present) {
      map['vente_id'] = Variable<String>(venteId.value);
    }
    if (produitId.present) {
      map['produit_id'] = Variable<String>(produitId.value);
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
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VenteDetailsCompanion(')
          ..write('id: $id, ')
          ..write('pharmacieId: $pharmacieId, ')
          ..write('venteId: $venteId, ')
          ..write('produitId: $produitId, ')
          ..write('quantite: $quantite, ')
          ..write('prixUnitaire: $prixUnitaire, ')
          ..write('sousTotal: $sousTotal, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _pharmacieIdMeta = const VerificationMeta(
    'pharmacieId',
  );
  @override
  late final GeneratedColumn<String> pharmacieId = GeneratedColumn<String>(
    'pharmacie_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venteIdMeta = const VerificationMeta(
    'venteId',
  );
  @override
  late final GeneratedColumn<String> venteId = GeneratedColumn<String>(
    'vente_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pharmacieId,
    venteId,
    numeroFacture,
    dateEmission,
    cheminPdf,
    updatedAt,
    isSynced,
    isDeleted,
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
    if (data.containsKey('pharmacie_id')) {
      context.handle(
        _pharmacieIdMeta,
        pharmacieId.isAcceptableOrUnknown(
          data['pharmacie_id']!,
          _pharmacieIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pharmacieIdMeta);
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
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
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
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pharmacieId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pharmacie_id'],
      )!,
      venteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
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
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $FacturesTable createAlias(String alias) {
    return $FacturesTable(attachedDatabase, alias);
  }
}

class Facture extends DataClass implements Insertable<Facture> {
  final String id;
  final String pharmacieId;
  final String venteId;
  final String numeroFacture;
  final DateTime dateEmission;
  final String? cheminPdf;
  final DateTime updatedAt;
  final bool isSynced;
  final bool isDeleted;
  const Facture({
    required this.id,
    required this.pharmacieId,
    required this.venteId,
    required this.numeroFacture,
    required this.dateEmission,
    this.cheminPdf,
    required this.updatedAt,
    required this.isSynced,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pharmacie_id'] = Variable<String>(pharmacieId);
    map['vente_id'] = Variable<String>(venteId);
    map['numero_facture'] = Variable<String>(numeroFacture);
    map['date_emission'] = Variable<DateTime>(dateEmission);
    if (!nullToAbsent || cheminPdf != null) {
      map['chemin_pdf'] = Variable<String>(cheminPdf);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  FacturesCompanion toCompanion(bool nullToAbsent) {
    return FacturesCompanion(
      id: Value(id),
      pharmacieId: Value(pharmacieId),
      venteId: Value(venteId),
      numeroFacture: Value(numeroFacture),
      dateEmission: Value(dateEmission),
      cheminPdf: cheminPdf == null && nullToAbsent
          ? const Value.absent()
          : Value(cheminPdf),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
      isDeleted: Value(isDeleted),
    );
  }

  factory Facture.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Facture(
      id: serializer.fromJson<String>(json['id']),
      pharmacieId: serializer.fromJson<String>(json['pharmacieId']),
      venteId: serializer.fromJson<String>(json['venteId']),
      numeroFacture: serializer.fromJson<String>(json['numeroFacture']),
      dateEmission: serializer.fromJson<DateTime>(json['dateEmission']),
      cheminPdf: serializer.fromJson<String?>(json['cheminPdf']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pharmacieId': serializer.toJson<String>(pharmacieId),
      'venteId': serializer.toJson<String>(venteId),
      'numeroFacture': serializer.toJson<String>(numeroFacture),
      'dateEmission': serializer.toJson<DateTime>(dateEmission),
      'cheminPdf': serializer.toJson<String?>(cheminPdf),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Facture copyWith({
    String? id,
    String? pharmacieId,
    String? venteId,
    String? numeroFacture,
    DateTime? dateEmission,
    Value<String?> cheminPdf = const Value.absent(),
    DateTime? updatedAt,
    bool? isSynced,
    bool? isDeleted,
  }) => Facture(
    id: id ?? this.id,
    pharmacieId: pharmacieId ?? this.pharmacieId,
    venteId: venteId ?? this.venteId,
    numeroFacture: numeroFacture ?? this.numeroFacture,
    dateEmission: dateEmission ?? this.dateEmission,
    cheminPdf: cheminPdf.present ? cheminPdf.value : this.cheminPdf,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Facture copyWithCompanion(FacturesCompanion data) {
    return Facture(
      id: data.id.present ? data.id.value : this.id,
      pharmacieId: data.pharmacieId.present
          ? data.pharmacieId.value
          : this.pharmacieId,
      venteId: data.venteId.present ? data.venteId.value : this.venteId,
      numeroFacture: data.numeroFacture.present
          ? data.numeroFacture.value
          : this.numeroFacture,
      dateEmission: data.dateEmission.present
          ? data.dateEmission.value
          : this.dateEmission,
      cheminPdf: data.cheminPdf.present ? data.cheminPdf.value : this.cheminPdf,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Facture(')
          ..write('id: $id, ')
          ..write('pharmacieId: $pharmacieId, ')
          ..write('venteId: $venteId, ')
          ..write('numeroFacture: $numeroFacture, ')
          ..write('dateEmission: $dateEmission, ')
          ..write('cheminPdf: $cheminPdf, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pharmacieId,
    venteId,
    numeroFacture,
    dateEmission,
    cheminPdf,
    updatedAt,
    isSynced,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Facture &&
          other.id == this.id &&
          other.pharmacieId == this.pharmacieId &&
          other.venteId == this.venteId &&
          other.numeroFacture == this.numeroFacture &&
          other.dateEmission == this.dateEmission &&
          other.cheminPdf == this.cheminPdf &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced &&
          other.isDeleted == this.isDeleted);
}

class FacturesCompanion extends UpdateCompanion<Facture> {
  final Value<String> id;
  final Value<String> pharmacieId;
  final Value<String> venteId;
  final Value<String> numeroFacture;
  final Value<DateTime> dateEmission;
  final Value<String?> cheminPdf;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const FacturesCompanion({
    this.id = const Value.absent(),
    this.pharmacieId = const Value.absent(),
    this.venteId = const Value.absent(),
    this.numeroFacture = const Value.absent(),
    this.dateEmission = const Value.absent(),
    this.cheminPdf = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FacturesCompanion.insert({
    this.id = const Value.absent(),
    required String pharmacieId,
    required String venteId,
    required String numeroFacture,
    required DateTime dateEmission,
    this.cheminPdf = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : pharmacieId = Value(pharmacieId),
       venteId = Value(venteId),
       numeroFacture = Value(numeroFacture),
       dateEmission = Value(dateEmission);
  static Insertable<Facture> custom({
    Expression<String>? id,
    Expression<String>? pharmacieId,
    Expression<String>? venteId,
    Expression<String>? numeroFacture,
    Expression<DateTime>? dateEmission,
    Expression<String>? cheminPdf,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pharmacieId != null) 'pharmacie_id': pharmacieId,
      if (venteId != null) 'vente_id': venteId,
      if (numeroFacture != null) 'numero_facture': numeroFacture,
      if (dateEmission != null) 'date_emission': dateEmission,
      if (cheminPdf != null) 'chemin_pdf': cheminPdf,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FacturesCompanion copyWith({
    Value<String>? id,
    Value<String>? pharmacieId,
    Value<String>? venteId,
    Value<String>? numeroFacture,
    Value<DateTime>? dateEmission,
    Value<String?>? cheminPdf,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<bool>? isDeleted,
    Value<int>? rowid,
  }) {
    return FacturesCompanion(
      id: id ?? this.id,
      pharmacieId: pharmacieId ?? this.pharmacieId,
      venteId: venteId ?? this.venteId,
      numeroFacture: numeroFacture ?? this.numeroFacture,
      dateEmission: dateEmission ?? this.dateEmission,
      cheminPdf: cheminPdf ?? this.cheminPdf,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pharmacieId.present) {
      map['pharmacie_id'] = Variable<String>(pharmacieId.value);
    }
    if (venteId.present) {
      map['vente_id'] = Variable<String>(venteId.value);
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
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FacturesCompanion(')
          ..write('id: $id, ')
          ..write('pharmacieId: $pharmacieId, ')
          ..write('venteId: $venteId, ')
          ..write('numeroFacture: $numeroFacture, ')
          ..write('dateEmission: $dateEmission, ')
          ..write('cheminPdf: $cheminPdf, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PharmaciesTable extends Pharmacies
    with TableInfo<$PharmaciesTable, Pharmacy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PharmaciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _logoUrlMeta = const VerificationMeta(
    'logoUrl',
  );
  @override
  late final GeneratedColumn<String> logoUrl = GeneratedColumn<String>(
    'logo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, nom, logoUrl, updatedAt, isSynced];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pharmacies';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pharmacy> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('logo_url')) {
      context.handle(
        _logoUrlMeta,
        logoUrl.isAcceptableOrUnknown(data['logo_url']!, _logoUrlMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pharmacy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pharmacy(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      logoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_url'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $PharmaciesTable createAlias(String alias) {
    return $PharmaciesTable(attachedDatabase, alias);
  }
}

class Pharmacy extends DataClass implements Insertable<Pharmacy> {
  final String id;
  final String nom;
  final String? logoUrl;
  final DateTime? updatedAt;
  final bool isSynced;
  const Pharmacy({
    required this.id,
    required this.nom,
    this.logoUrl,
    this.updatedAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nom'] = Variable<String>(nom);
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  PharmaciesCompanion toCompanion(bool nullToAbsent) {
    return PharmaciesCompanion(
      id: Value(id),
      nom: Value(nom),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      isSynced: Value(isSynced),
    );
  }

  factory Pharmacy.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pharmacy(
      id: serializer.fromJson<String>(json['id']),
      nom: serializer.fromJson<String>(json['nom']),
      logoUrl: serializer.fromJson<String?>(json['logoUrl']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nom': serializer.toJson<String>(nom),
      'logoUrl': serializer.toJson<String?>(logoUrl),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  Pharmacy copyWith({
    String? id,
    String? nom,
    Value<String?> logoUrl = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
    bool? isSynced,
  }) => Pharmacy(
    id: id ?? this.id,
    nom: nom ?? this.nom,
    logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
  );
  Pharmacy copyWithCompanion(PharmaciesCompanion data) {
    return Pharmacy(
      id: data.id.present ? data.id.value : this.id,
      nom: data.nom.present ? data.nom.value : this.nom,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pharmacy(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nom, logoUrl, updatedAt, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pharmacy &&
          other.id == this.id &&
          other.nom == this.nom &&
          other.logoUrl == this.logoUrl &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced);
}

class PharmaciesCompanion extends UpdateCompanion<Pharmacy> {
  final Value<String> id;
  final Value<String> nom;
  final Value<String?> logoUrl;
  final Value<DateTime?> updatedAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const PharmaciesCompanion({
    this.id = const Value.absent(),
    this.nom = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PharmaciesCompanion.insert({
    required String id,
    required String nom,
    this.logoUrl = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nom = Value(nom);
  static Insertable<Pharmacy> custom({
    Expression<String>? id,
    Expression<String>? nom,
    Expression<String>? logoUrl,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nom != null) 'nom': nom,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PharmaciesCompanion copyWith({
    Value<String>? id,
    Value<String>? nom,
    Value<String?>? logoUrl,
    Value<DateTime?>? updatedAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return PharmaciesCompanion(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      logoUrl: logoUrl ?? this.logoUrl,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PharmaciesCompanion(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
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
  late final $PharmaciesTable pharmacies = $PharmaciesTable(this);
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
    pharmacies,
  ];
}

typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      Value<String> id,
      required String pharmacieId,
      required String nom,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<bool> isDeleted,
      Value<int> rowid,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<String> id,
      Value<String> pharmacieId,
      Value<String> nom,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<bool> isDeleted,
      Value<int> rowid,
    });

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
    ).filter((f) => f.categorieId.id.sqlEquals($_itemColumn<String>('id')!));

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
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

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
                Value<String> id = const Value.absent(),
                Value<String> pharmacieId = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                pharmacieId: pharmacieId,
                nom: nom,
                updatedAt: updatedAt,
                isSynced: isSynced,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String pharmacieId,
                required String nom,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                pharmacieId: pharmacieId,
                nom: nom,
                updatedAt: updatedAt,
                isSynced: isSynced,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
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
      Value<String> id,
      required String pharmacieId,
      required String nom,
      Value<String?> categorieId,
      required double prixAchat,
      required double prixVente,
      required int quantiteStock,
      required int seuilAlerte,
      Value<DateTime?> datePeremption,
      required DateTime dateCreation,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<bool> isDeleted,
      Value<int> rowid,
    });
typedef $$ProduitsTableUpdateCompanionBuilder =
    ProduitsCompanion Function({
      Value<String> id,
      Value<String> pharmacieId,
      Value<String> nom,
      Value<String?> categorieId,
      Value<double> prixAchat,
      Value<double> prixVente,
      Value<int> quantiteStock,
      Value<int> seuilAlerte,
      Value<DateTime?> datePeremption,
      Value<DateTime> dateCreation,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<bool> isDeleted,
      Value<int> rowid,
    });

final class $$ProduitsTableReferences
    extends BaseReferences<_$AppDatabase, $ProduitsTable, Produit> {
  $$ProduitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categorieIdTable(_$AppDatabase db) =>
      db.categories.createAlias(
        $_aliasNameGenerator(db.produits.categorieId, db.categories.id),
      );

  $$CategoriesTableProcessedTableManager? get categorieId {
    final $_column = $_itemColumn<String>('categorie_id');
    if ($_column == null) return null;
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
    ).filter((f) => f.produitId.id.sqlEquals($_itemColumn<String>('id')!));

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
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
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

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
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

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
    builder: (column) => column,
  );

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

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

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
                Value<String> id = const Value.absent(),
                Value<String> pharmacieId = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<String?> categorieId = const Value.absent(),
                Value<double> prixAchat = const Value.absent(),
                Value<double> prixVente = const Value.absent(),
                Value<int> quantiteStock = const Value.absent(),
                Value<int> seuilAlerte = const Value.absent(),
                Value<DateTime?> datePeremption = const Value.absent(),
                Value<DateTime> dateCreation = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProduitsCompanion(
                id: id,
                pharmacieId: pharmacieId,
                nom: nom,
                categorieId: categorieId,
                prixAchat: prixAchat,
                prixVente: prixVente,
                quantiteStock: quantiteStock,
                seuilAlerte: seuilAlerte,
                datePeremption: datePeremption,
                dateCreation: dateCreation,
                updatedAt: updatedAt,
                isSynced: isSynced,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String pharmacieId,
                required String nom,
                Value<String?> categorieId = const Value.absent(),
                required double prixAchat,
                required double prixVente,
                required int quantiteStock,
                required int seuilAlerte,
                Value<DateTime?> datePeremption = const Value.absent(),
                required DateTime dateCreation,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProduitsCompanion.insert(
                id: id,
                pharmacieId: pharmacieId,
                nom: nom,
                categorieId: categorieId,
                prixAchat: prixAchat,
                prixVente: prixVente,
                quantiteStock: quantiteStock,
                seuilAlerte: seuilAlerte,
                datePeremption: datePeremption,
                dateCreation: dateCreation,
                updatedAt: updatedAt,
                isSynced: isSynced,
                isDeleted: isDeleted,
                rowid: rowid,
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
      required String id,
      required String pharmacieId,
      required String email,
      required String prenom,
      required String nom,
      required String role,
      Value<DateTime?> derniereConnexion,
      Value<int> rowid,
    });
typedef $$UtilisateursTableUpdateCompanionBuilder =
    UtilisateursCompanion Function({
      Value<String> id,
      Value<String> pharmacieId,
      Value<String> email,
      Value<String> prenom,
      Value<String> nom,
      Value<String> role,
      Value<DateTime?> derniereConnexion,
      Value<int> rowid,
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
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prenom => $composableBuilder(
    column: $table.prenom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get derniereConnexion => $composableBuilder(
    column: $table.derniereConnexion,
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prenom => $composableBuilder(
    column: $table.prenom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get derniereConnexion => $composableBuilder(
    column: $table.derniereConnexion,
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get prenom =>
      $composableBuilder(column: $table.prenom, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get derniereConnexion => $composableBuilder(
    column: $table.derniereConnexion,
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
                Value<String> id = const Value.absent(),
                Value<String> pharmacieId = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> prenom = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<DateTime?> derniereConnexion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UtilisateursCompanion(
                id: id,
                pharmacieId: pharmacieId,
                email: email,
                prenom: prenom,
                nom: nom,
                role: role,
                derniereConnexion: derniereConnexion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String pharmacieId,
                required String email,
                required String prenom,
                required String nom,
                required String role,
                Value<DateTime?> derniereConnexion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UtilisateursCompanion.insert(
                id: id,
                pharmacieId: pharmacieId,
                email: email,
                prenom: prenom,
                nom: nom,
                role: role,
                derniereConnexion: derniereConnexion,
                rowid: rowid,
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
      Value<String> id,
      required String pharmacieId,
      required DateTime dateVente,
      required double montantTotal,
      required String modePaiement,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<bool> isDeleted,
      Value<int> rowid,
    });
typedef $$VentesTableUpdateCompanionBuilder =
    VentesCompanion Function({
      Value<String> id,
      Value<String> pharmacieId,
      Value<DateTime> dateVente,
      Value<double> montantTotal,
      Value<String> modePaiement,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<bool> isDeleted,
      Value<int> rowid,
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
    ).filter((f) => f.venteId.id.sqlEquals($_itemColumn<String>('id')!));

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
    ).filter((f) => f.venteId.id.sqlEquals($_itemColumn<String>('id')!));

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
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
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

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
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

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
    builder: (column) => column,
  );

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

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

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
                Value<String> id = const Value.absent(),
                Value<String> pharmacieId = const Value.absent(),
                Value<DateTime> dateVente = const Value.absent(),
                Value<double> montantTotal = const Value.absent(),
                Value<String> modePaiement = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VentesCompanion(
                id: id,
                pharmacieId: pharmacieId,
                dateVente: dateVente,
                montantTotal: montantTotal,
                modePaiement: modePaiement,
                updatedAt: updatedAt,
                isSynced: isSynced,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String pharmacieId,
                required DateTime dateVente,
                required double montantTotal,
                required String modePaiement,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VentesCompanion.insert(
                id: id,
                pharmacieId: pharmacieId,
                dateVente: dateVente,
                montantTotal: montantTotal,
                modePaiement: modePaiement,
                updatedAt: updatedAt,
                isSynced: isSynced,
                isDeleted: isDeleted,
                rowid: rowid,
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
      Value<String> id,
      required String pharmacieId,
      required String venteId,
      required String produitId,
      required int quantite,
      required double prixUnitaire,
      required double sousTotal,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<bool> isDeleted,
      Value<int> rowid,
    });
typedef $$VenteDetailsTableUpdateCompanionBuilder =
    VenteDetailsCompanion Function({
      Value<String> id,
      Value<String> pharmacieId,
      Value<String> venteId,
      Value<String> produitId,
      Value<int> quantite,
      Value<double> prixUnitaire,
      Value<double> sousTotal,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<bool> isDeleted,
      Value<int> rowid,
    });

final class $$VenteDetailsTableReferences
    extends BaseReferences<_$AppDatabase, $VenteDetailsTable, VenteDetail> {
  $$VenteDetailsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VentesTable _venteIdTable(_$AppDatabase db) => db.ventes.createAlias(
    $_aliasNameGenerator(db.venteDetails.venteId, db.ventes.id),
  );

  $$VentesTableProcessedTableManager get venteId {
    final $_column = $_itemColumn<String>('vente_id')!;

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
    final $_column = $_itemColumn<String>('produit_id')!;

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
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
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

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
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

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantite =>
      $composableBuilder(column: $table.quantite, builder: (column) => column);

  GeneratedColumn<double> get prixUnitaire => $composableBuilder(
    column: $table.prixUnitaire,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sousTotal =>
      $composableBuilder(column: $table.sousTotal, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

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
                Value<String> id = const Value.absent(),
                Value<String> pharmacieId = const Value.absent(),
                Value<String> venteId = const Value.absent(),
                Value<String> produitId = const Value.absent(),
                Value<int> quantite = const Value.absent(),
                Value<double> prixUnitaire = const Value.absent(),
                Value<double> sousTotal = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VenteDetailsCompanion(
                id: id,
                pharmacieId: pharmacieId,
                venteId: venteId,
                produitId: produitId,
                quantite: quantite,
                prixUnitaire: prixUnitaire,
                sousTotal: sousTotal,
                updatedAt: updatedAt,
                isSynced: isSynced,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String pharmacieId,
                required String venteId,
                required String produitId,
                required int quantite,
                required double prixUnitaire,
                required double sousTotal,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VenteDetailsCompanion.insert(
                id: id,
                pharmacieId: pharmacieId,
                venteId: venteId,
                produitId: produitId,
                quantite: quantite,
                prixUnitaire: prixUnitaire,
                sousTotal: sousTotal,
                updatedAt: updatedAt,
                isSynced: isSynced,
                isDeleted: isDeleted,
                rowid: rowid,
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
      Value<String> id,
      required String pharmacieId,
      required String venteId,
      required String numeroFacture,
      required DateTime dateEmission,
      Value<String?> cheminPdf,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<bool> isDeleted,
      Value<int> rowid,
    });
typedef $$FacturesTableUpdateCompanionBuilder =
    FacturesCompanion Function({
      Value<String> id,
      Value<String> pharmacieId,
      Value<String> venteId,
      Value<String> numeroFacture,
      Value<DateTime> dateEmission,
      Value<String?> cheminPdf,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<bool> isDeleted,
      Value<int> rowid,
    });

final class $$FacturesTableReferences
    extends BaseReferences<_$AppDatabase, $FacturesTable, Facture> {
  $$FacturesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VentesTable _venteIdTable(_$AppDatabase db) => db.ventes.createAlias(
    $_aliasNameGenerator(db.factures.venteId, db.ventes.id),
  );

  $$VentesTableProcessedTableManager get venteId {
    final $_column = $_itemColumn<String>('vente_id')!;

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
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
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

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
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

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pharmacieId => $composableBuilder(
    column: $table.pharmacieId,
    builder: (column) => column,
  );

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

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

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
                Value<String> id = const Value.absent(),
                Value<String> pharmacieId = const Value.absent(),
                Value<String> venteId = const Value.absent(),
                Value<String> numeroFacture = const Value.absent(),
                Value<DateTime> dateEmission = const Value.absent(),
                Value<String?> cheminPdf = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FacturesCompanion(
                id: id,
                pharmacieId: pharmacieId,
                venteId: venteId,
                numeroFacture: numeroFacture,
                dateEmission: dateEmission,
                cheminPdf: cheminPdf,
                updatedAt: updatedAt,
                isSynced: isSynced,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String pharmacieId,
                required String venteId,
                required String numeroFacture,
                required DateTime dateEmission,
                Value<String?> cheminPdf = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FacturesCompanion.insert(
                id: id,
                pharmacieId: pharmacieId,
                venteId: venteId,
                numeroFacture: numeroFacture,
                dateEmission: dateEmission,
                cheminPdf: cheminPdf,
                updatedAt: updatedAt,
                isSynced: isSynced,
                isDeleted: isDeleted,
                rowid: rowid,
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
typedef $$PharmaciesTableCreateCompanionBuilder =
    PharmaciesCompanion Function({
      required String id,
      required String nom,
      Value<String?> logoUrl,
      Value<DateTime?> updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$PharmaciesTableUpdateCompanionBuilder =
    PharmaciesCompanion Function({
      Value<String> id,
      Value<String> nom,
      Value<String?> logoUrl,
      Value<DateTime?> updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$PharmaciesTableFilterComposer
    extends Composer<_$AppDatabase, $PharmaciesTable> {
  $$PharmaciesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PharmaciesTableOrderingComposer
    extends Composer<_$AppDatabase, $PharmaciesTable> {
  $$PharmaciesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PharmaciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PharmaciesTable> {
  $$PharmaciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$PharmaciesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PharmaciesTable,
          Pharmacy,
          $$PharmaciesTableFilterComposer,
          $$PharmaciesTableOrderingComposer,
          $$PharmaciesTableAnnotationComposer,
          $$PharmaciesTableCreateCompanionBuilder,
          $$PharmaciesTableUpdateCompanionBuilder,
          (Pharmacy, BaseReferences<_$AppDatabase, $PharmaciesTable, Pharmacy>),
          Pharmacy,
          PrefetchHooks Function()
        > {
  $$PharmaciesTableTableManager(_$AppDatabase db, $PharmaciesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PharmaciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PharmaciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PharmaciesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PharmaciesCompanion(
                id: id,
                nom: nom,
                logoUrl: logoUrl,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nom,
                Value<String?> logoUrl = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PharmaciesCompanion.insert(
                id: id,
                nom: nom,
                logoUrl: logoUrl,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PharmaciesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PharmaciesTable,
      Pharmacy,
      $$PharmaciesTableFilterComposer,
      $$PharmaciesTableOrderingComposer,
      $$PharmaciesTableAnnotationComposer,
      $$PharmaciesTableCreateCompanionBuilder,
      $$PharmaciesTableUpdateCompanionBuilder,
      (Pharmacy, BaseReferences<_$AppDatabase, $PharmaciesTable, Pharmacy>),
      Pharmacy,
      PrefetchHooks Function()
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
  $$PharmaciesTableTableManager get pharmacies =>
      $$PharmaciesTableTableManager(_db, _db.pharmacies);
}
