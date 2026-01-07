import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_project/core/errors/exceptions.dart';
import 'package:ecommerce_app_project/core/services/data_services.dart';

class FireStoreService implements DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      if (documentId != null) {
        await firestore.collection(path).doc(documentId).set(data);
      } else {
        await firestore.collection(path).add(data);
      }
    } on FirebaseException catch (e) {
      // رسائل مفهومة بدل ما يروح "Unexpected"
      if (e.code == 'permission-denied') {
        throw CustomException(message: 'ليس لديك صلاحية لحفظ البيانات.');
      } else if (e.code == 'unavailable') {
        throw CustomException(message: 'فشل الاتصال بالسيرفر. تحققي من الإنترنت.');
      } else {
        throw CustomException(message: e.message ?? 'حدث خطأ أثناء حفظ البيانات.');
      }
    } catch (_) {
      throw CustomException(message: 'حدث خطأ غير متوقع أثناء حفظ البيانات.');
    }
  }

  @override
  Future<dynamic> getData({
    required String path,
    String? docuementId,
    Map<String, dynamic>? query,
  }) async {
    try {
      if (docuementId != null) {
        final doc = await firestore.collection(path).doc(docuementId).get();
        return doc.data();
      } else {
        Query<Map<String, dynamic>> ref = firestore.collection(path);

        if (query != null) {
          if (query['orderBy'] != null) {
            ref = ref.orderBy(
              query['orderBy'],
              descending: query['descending'] ?? false,
            );
          }
          if (query['limit'] != null) {
            ref = ref.limit(query['limit']);
          }
        }

        final result = await ref.get();
        return result.docs.map((e) => e.data()).toList();
      }
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message ?? 'حدث خطأ أثناء جلب البيانات.');
    } catch (_) {
      throw CustomException(message: 'حدث خطأ غير متوقع أثناء جلب البيانات.');
    }
  }

  @override
  Future<bool> checkIfDataExists({
    required String path,
    required String docuementId,
  }) async {
    try {
      final doc = await firestore.collection(path).doc(docuementId).get();
      return doc.exists;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message ?? 'حدث خطأ أثناء التحقق من البيانات.');
    } catch (_) {
      throw CustomException(message: 'حدث خطأ غير متوقع أثناء التحقق من البيانات.');
    }
  }
}
