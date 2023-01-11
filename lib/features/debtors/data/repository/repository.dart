import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukka_finance/features/database/database.dart';
import 'package:dukka_finance/features/debtors/models/debtor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final debtorsRepository =
    Provider<DebtorsRepository>((ref) => DebtorsRepositoryImpl(ref));

abstract class DebtorsRepository {
  Stream<List<Debtor>> getListOfDebtors();
}

class DebtorsRepositoryImpl implements DebtorsRepository {
  final CollectionReference colRef;

  DebtorsRepositoryImpl(Ref ref)
      : colRef = ref.read(firebaseProvider).collection('debtors');

  @override
  Stream<List<Debtor>> getListOfDebtors() {
    // TODO: implement getListOfDebtors
    throw UnimplementedError();
  }
}

// class DataRepository {
//   // 1
//   final CollectionReference collection =
//       FirebaseFirestore.instance.collection('pets');
//   // 2
//   Stream<QuerySnapshot> getStream() {
//     return collection.snapshots();
//   }

//   // 3
//   Future<DocumentReference> addPet(Pet pet) {
//     return collection.add(pet.toJson());
//   }

//   // 4
//   void updatePet(Pet pet) async {
//     await collection.doc(pet.referenceId).update(pet.toJson());
//   }

//   // 5
//   void deletePet(Pet pet) async {
//     await collection.doc(pet.referenceId).delete();
//   }
// }
