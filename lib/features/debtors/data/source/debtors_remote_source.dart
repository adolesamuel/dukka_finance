import 'package:dukka_finance/features/debtors/models/debtor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final debtorsRemoteSourceProvider =
    Provider<DebtorsRemoteSource>((ref) => DebtorsRemoteSourceImpl());

abstract class DebtorsRemoteSource {
  Stream<List<Debtor>> getListOfDebtors();
}

class DebtorsRemoteSourceImpl implements DebtorsRemoteSource {
  @override
  Stream<List<Debtor>> getListOfDebtors() {
    // TODO: implement getListOfDebtors
    throw UnimplementedError();
  }
}
