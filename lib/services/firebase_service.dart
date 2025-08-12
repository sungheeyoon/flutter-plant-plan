import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/diary_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/my_page/model/announcement_model.dart';

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

  Future<void> fireBaseDeletePlant(PlantModel plant) async {
    if (_currentUser != null) {
      final uid = _currentUser!.uid;

      //유저가 설정한 식물이미지 삭제
      if (plant.userImageUrl != "") {
        await deleteImageFromStorage(plant.userImageUrl);
      }
      //해당 식물의 다이어리 이미지 전부 삭제
      for (DiaryModel diary in plant.diary) {
        for (final diaryImage in diary.imageUrl) {
          await deleteImageFromStorage(diaryImage);
        }
      }

      //firestore 해당 식물 문서삭제
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('plants')
          .doc(plant.docId)
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
      }
    } else {
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
      }
    } else {
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

  Future<void> fireBaseUpdateDiary(String docId, DiaryModel diary,
      List<String> netWorkImageUrls, List<XFile> images) async {
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

        for (int i = 0; i < updatedDiaries.length; i++) {
          final Map<String, dynamic> diaryData = updatedDiaries[i];
          if (diaryData['id'] == diary.id) {
            List<String> updatedImageUrls = [...netWorkImageUrls];

            if (images.isNotEmpty) {
              for (final image in images) {
                final imageUrl = await uploadImageAndGetURL(image);
                updatedImageUrls.add(imageUrl);
              }
            }

            diary = diary.copyWith(imageUrl: updatedImageUrls);
            updatedDiaries[i] = diary.toJson();
            break;
          }
        }

        await plantDocRef.update({
          'diary': updatedDiaries,
        });
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
          bool found = false;

          for (var i = 0; i < diaryList.length; i++) {
            if (diaryList[i]['id'] == diaryId) {
              // 이미지 URL 목록이 비어있지 않은 경우에만 업데이트
              if (imageUrls.isNotEmpty) {
                diaryList[i]['imageUrl'] = imageUrls;
              } else {
                diaryList[i]['imageUrl'] = [];
              }
              found = true;
              break;
            }
          }

          if (!found) {
            throw Exception('Diary with ID $diaryId not found.');
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

  Future<List<DiaryModel>> fetchDiaryList(String docId) async {
    if (_currentUser != null) {
      final uid = _currentUser!.uid;
      final plantDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('plants')
          .doc(docId);

      final plantDoc = await plantDocRef.get();

      if (plantDoc.exists) {
        final data = plantDoc.data() as Map<String, dynamic>;
        if (data.containsKey('diary')) {
          final diaryList = List<Map<String, dynamic>>.from(data['diary']);
          final List<DiaryModel> diaries = diaryList
              .map((diaryData) => DiaryModel.fromJson(diaryData))
              .toList();
          return diaries;
        }
      }
      return [];
    }
    return [];
  }

  Future<void> deleteAccount() async {
    try {
      if (_currentUser != null) {
        final uid = _currentUser!.uid;

        await FirebaseFirestore.instance.collection('user').doc(uid).delete();

        await FirebaseFirestore.instance.collection('users').doc(uid).delete();

        await _currentUser!.delete();

        // 사용자 삭제 성공 시 로그아웃
        await _auth.signOut();
      } else {
        await _auth.signOut();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        // 최근에 로그인한 사용자가 아니므로 다시 로그인하도록 유도
        // 여기에서 로그인 화면으로 이동하거나 로그인 다이얼로그를 표시하도록 처리**
      }
    }
  }

  Future<void> addAnnouncement(AnnouncementModel announcement) async {
    try {
      if (_currentUser != null) {
        await FirebaseFirestore.instance.collection('announcements').add({
          'title': announcement.title,
          'date': announcement.date,
          'isNew': announcement.isNew,
          'body': announcement.body,
        });
      } else {
      }
    } catch (e) {
    }
  }

  Future<List<AnnouncementModel>> getAnnouncements() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('announcements').get();

      List<AnnouncementModel> announcements = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return AnnouncementModel(
          title: data['title'] ?? '',
          date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
          isNew: data['isNew'] ?? false,
          body: data['body'] ?? '',
          isExpanded: false,
        );
      }).toList();

      return announcements;
    } catch (e) {
      return [];
    }
  }
}
