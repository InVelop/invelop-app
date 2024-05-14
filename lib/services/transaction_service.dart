// import 'package:cloud_firestore/cloud_firestore.dart';

// class TransactionService {
//   final FirebaseFirestore _firestore;

//   TransactionService(this._firestore);

//   Future<void> addTransaction(
//       String userUID, String accountUID, Transaction transaction) async {
//     try {
//       await _firestore.collection('users/$userUID/accounts/$accountUID').add({
//         'accountName': transaction.accountName,
//         'amount': transaction.amount,
//         'category': transaction.category,
//         'date': transaction.date,
//         'name': transaction.name,
//         'type': transaction.type,
//       });
//     } catch (e) {
//       print(e);
//       throw e;
//     }
//   }
// }
