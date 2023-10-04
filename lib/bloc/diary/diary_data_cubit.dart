import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'diary_data_state.dart';

class DiaryDataCubit extends Cubit<DiaryDataState> {
  DiaryDataCubit()
      : super(DiaryDataState(
          dateOptions: ['2023-12-22', '2023-10-04', '2023-11-20'],
          areaOptions: ['Select Area', 'Auburn', 'Merrylands','Central'],
          taskCategoryOptions: ['Task Category', 'Category 2', 'Category 3'],
          eventOptions: ['Select an event', 'Event 1', 'Event 2'],
          selectedDate: '2023-12-22',
          selectedArea: 'Select Area',
          selectedTaskCategory: 'Task Category',
          selectedEventOptions: 'Select an event',
          includeValue: true,
          linkValue: true,
          selectedImages: [],
          commentsController: TextEditingController(),
          tagsController: TextEditingController(),
        ));

  void updateDate(String date) {
    emit(state.copyWith(selectedDate: date));
  }

  void updateArea(String area) {
    emit(state.copyWith(selectedArea: area));
  }

  void updateTaskCategory(String category) {
    emit(state.copyWith(selectedTaskCategory: category));
  }

  void updateEvent(String event) {
    emit(state.copyWith(selectedEventOptions: event));
  }

  void updateIncludeValue(bool value) {
    emit(state.copyWith(includeValue: value));
  }

  void updateLinkValue(bool value) {
    emit(state.copyWith(linkValue: value));
  }

  void updateImages(List<XFile> images) {
    emit(state.copyWith(selectedImages: images));
  }

  void updateComments(String comments) {
    state.commentsController.text = comments;
    emit(state);
  }

  void updateTags(String tags) {
    state.tagsController.text = tags;
    emit(state);
  }

  Future<void> addPhoto(BuildContext context) async {
    final diaryDataCubit = context.read<DiaryDataCubit>();
    final imagePicker = ImagePicker();
    final images = await imagePicker.pickMultiImage();

    if (images != null) {
      diaryDataCubit
          .updateImages(images.map((image) => XFile(image.path)).toList());
    }
  }
}
