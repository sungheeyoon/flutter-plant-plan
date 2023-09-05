import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/diary_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';

class FirebaseService {
  //사용자의 인증 상태
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //현재 로그인된 사용자의 정보
  late final User? _currentUser;

  FirebaseService() {
    _currentUser = _auth.currentUser;
  }
  Future<List<PlantModel>> fireBaseFetchPlant() async {
    final List<PlantModel> data = [];
    if (_currentUser != null) {
      final uid = _currentUser!.uid;
      final userDataSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('plants')
          .get();

      data.addAll(userDataSnapshot.docs
          .map((doc) => PlantModel.fromJson(doc.data()))
          .toList());
    }
    return data;
  }

  Future<void> fireBaseUpdatePlant(
      String docId, Map<String, dynamic> updatedData) async {
    if (_currentUser != null) {
      final uid = _currentUser!.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('plants')
          .doc(docId)
          .update(updatedData);
    }
  }

  Future<void> fireBaseDeletePlant(String docId) async {
    if (_currentUser != null) {
      final uid = _currentUser!.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('plants')
          .doc(docId)
          .delete();
    }
  }

  Future<void> fireBaseUpdateAlarm(
      String docId, List<AlarmModel> updatedAlarms) async {
    if (_currentUser != null) {
      final uid = _currentUser!.uid;

      final plantData = {
        'alarms': updatedAlarms.map((alarm) => alarm.toJson()).toList(),
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('plants')
          .doc(docId)
          .update(plantData);
    }
  }

  Future<void> fireBaseDeleteAlarm(String docId, String alarmId) async {
    if (_currentUser != null) {
      final uid = _currentUser!.uid;

      final plantDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('plants')
          .doc(docId);

      final plantDocSnapshot = await plantDocRef.get();
      if (plantDocSnapshot.exists) {
        final alarms =
            List<Map<String, dynamic>>.from(plantDocSnapshot.data()!['alarms']);
        alarms.removeWhere((alarm) => alarm['id'] == alarmId);

        await plantDocRef.update({'alarms': alarms});
      } else {
        print('the plant document does not exist');
      }
    } else {
      print('Handle when the user is not logged in');
    }
  }

  Future<void> fireBaseDeleteDiary(String docId, String diaryId) async {
    if (_currentUser != null) {
      final uid = _currentUser!.uid;

      final plantDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('plants')
          .doc(docId);

      final plantDocSnapshot = await plantDocRef.get();
      if (plantDocSnapshot.exists) {
        final diaryEntries =
            List<Map<String, dynamic>>.from(plantDocSnapshot.data()!['diary']);
        for (final diary in diaryEntries) {
          if (diary['id'] == diaryId) {
            for (final imageUrl in diary['imageUrl']) {
              await FirebaseService().deleteImageFromStorage(imageUrl);
            }
          }
        }
        diaryEntries.removeWhere((diary) => diary['id'] == diaryId);

        await plantDocRef.update({'diary': diaryEntries});
      } else {
        print('the plant document does not exist');
      }
    } else {
      print('Handle when the user is not logged in');
    }
  }

  Future<void> fireBaseAddDiary(
      String docId, DiaryModel newDiary, List<XFile> images) async {
    if (_currentUser != null) {
      final uid = _currentUser!.uid;

      final plantDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('plants')
          .doc(docId);

      final plantDocSnapshot = await plantDocRef.get();

      if (plantDocSnapshot.exists) {
        final plantData = plantDocSnapshot.data() as Map<String, dynamic>;
        final List<dynamic> currentDiaries = plantData['diary'];

        final updatedDiaries = List<Map<String, dynamic>>.from(currentDiaries);

        if (images.isNotEmpty) {
          for (final image in images) {
            final imageUrl = await uploadImageAndGetURL(image);

            newDiary =
                newDiary.copyWith(imageUrl: [...newDiary.imageUrl, imageUrl]);
          }
        }

        updatedDiaries.add(newDiary.toJson());

        await plantDocRef.update({'diary': updatedDiaries});
      }
    }
    return;
  }

  Future<String> uploadImageAndGetURL(XFile image) async {
    if (_currentUser != null) {
      final uid = _currentUser!.uid;
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('users')
          .child(uid)
          .child('diary')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      final UploadTask uploadTask = storageReference.putFile(File(image.path));
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});

      final downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } else {
      return '';
    }
  }

  Future<void> deleteImageFromStorage(String imageUrl) async {
    try {
      Reference imageRef = FirebaseStorage.instance.refFromURL(imageUrl);
      await imageRef.delete();
    } catch (error) {
      print("Error deleting image from storage: $error");
    }
  }

  Future<void> syncImagesWithFirebaseStorage(
      List<String> imageUrls, String docId, String diaryId) async {
    if (_currentUser != null) {
      final uid = _currentUser!.uid;

      final plantDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('plants')
          .doc(docId);

      final plantDocSnapshot = await plantDocRef.get();

      if (plantDocSnapshot.exists) {
        final plantData = plantDocSnapshot.data();
        if (plantData != null) {
          List<dynamic> diaryList = plantData['diary'];
          for (var i = 0; i < diaryList.length; i++) {
            if (diaryList[i]['id'] == diaryId) {
              diaryList[i]['imageUrl'] = imageUrls;
              break;
            }
          }
          await plantDocRef.update({'diary': diaryList});
        }
      }
    }
  }

  Future<void> toggleDiaryBookmark(String docId, String diaryId) async {
    if (_currentUser != null) {
      final uid = _currentUser!.uid;

      final plantDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('plants')
          .doc(docId);

      final plantDocSnapshot = await plantDocRef.get();

      if (plantDocSnapshot.exists) {
        final List<dynamic> currentDiaries = plantDocSnapshot.data()?['diary'];

        final updatedDiaries = List<Map<String, dynamic>>.from(currentDiaries);

        for (var i = 0; i < updatedDiaries.length; i++) {
          if (updatedDiaries[i]['id'] == diaryId) {
            updatedDiaries[i]['bookMark'] = !updatedDiaries[i]['bookMark'];
            break;
          }
        }

        await plantDocRef.update({'diary': updatedDiaries});
      }
    }
  }
}
