part of 'add_diary_bloc.dart';

abstract class DiaryEvent {}

class AddDiaryDataEvent extends DiaryEvent {
  final DiaryEntry? diaryData;

  AddDiaryDataEvent({this.diaryData});
}

class AddPhotoEvent extends DiaryEvent {}
