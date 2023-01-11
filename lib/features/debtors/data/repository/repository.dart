import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dukka_finance/core/failures/failure.dart';
import 'package:dukka_finance/features/debtors/models/debtor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final debtorsRepository =
    Provider<DebtorsRepository>((ref) => DebtorsRepositoryImpl());

abstract class DebtorsRepository with DataBaseMethods<Debtor> {}

class DebtorsRepositoryImpl implements DebtorsRepository {
  final ref = FirebaseFirestore.instance.collection('debtors');

  DebtorsRepositoryImpl();

  @override
  Future<Either<Failure, bool>> addItem(Debtor t) {
    return ref
        .add(t.toJson())
        .then((value) => const Right<Failure, bool>(true))
        .catchError((error, stackTrace) =>
            throw Left(CommonFailure('Add Error', error.toString())));
  }

  @override
  Future<Either<Failure, bool>> deleteItem(Debtor t) {
    return ref
        .doc(t.id)
        .delete()
        .then((value) => const Right<Failure, bool>(true))
        .catchError((error, stack) =>
            throw Left(CommonFailure('Delete Error', error.toString())));
  }

  @override
  Stream<Either<Failure, List<Debtor>>> getStream() async* {
    final data = ref.snapshots();
    yield* data.map((snapshot) {
      final result =
          snapshot.docs.map((e) => Debtor.fromJson(e.data())).toList();

      return Right<Failure, List<Debtor>>(result);
    }).handleError((error, stack) =>
        throw Left(CommonFailure('Error Stream', error.toString())));
  }

  @override
  Future<Either<Failure, bool>> updateItem(Debtor t) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }
}

mixin DataBaseMethods<T> {
  Stream<Either<Failure, List<T>>> getStream();
  Future<Either<Failure, bool>> addItem(T t);
  Future<Either<Failure, bool>> updateItem(T t);
  Future<Either<Failure, bool>> deleteItem(T t);
}
