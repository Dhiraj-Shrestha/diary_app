part of 'diary_data_cubit.dart';

class DiaryDataState {
  final List<String> dateOptions;
  final List<String> areaOptions;
  final List<String> taskCategoryOptions;
  final List<String> eventOptions;

  final String selectedDate;
  final String selectedArea;
  final String selectedTaskCategory;
  final String selectedEventOptions;

  final bool includeValue;
  final bool linkValue;

  final List<XFile>? selectedImages;

  final TextEditingController commentsController;
  final TextEditingController tagsController;

  DiaryDataState({
    required this.dateOptions,
    required this.areaOptions,
    required this.taskCategoryOptions,
    required this.eventOptions,
    required this.selectedDate,
    required this.selectedArea,
    required this.selectedTaskCategory,
    required this.selectedEventOptions,
    required this.includeValue,
    required this.linkValue,
    this.selectedImages,
    required this.commentsController,
    required this.tagsController,
  });

  DiaryDataState copyWith({
    List<String>? dateOptions,
    List<String>? areaOptions,
    List<String>? taskCategoryOptions,
    List<String>? eventOptions,
    String? selectedDate,
    String? selectedArea,
    String? selectedTaskCategory,
    String? selectedEventOptions,
    bool? includeValue,
    bool? linkValue,
    List<XFile>? selectedImages,
    TextEditingController? commentsController,
    TextEditingController? tagsController,
  }) {
    return DiaryDataState(
      dateOptions: dateOptions ?? this.dateOptions,
      areaOptions: areaOptions ?? this.areaOptions,
      taskCategoryOptions: taskCategoryOptions ?? this.taskCategoryOptions,
      eventOptions: eventOptions ?? this.eventOptions,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedArea: selectedArea ?? this.selectedArea,
      selectedTaskCategory: selectedTaskCategory ?? this.selectedTaskCategory,
      selectedEventOptions: selectedEventOptions ?? this.selectedEventOptions,
      includeValue: includeValue ?? this.includeValue,
      linkValue: linkValue ?? this.linkValue,
      selectedImages: selectedImages ?? this.selectedImages,
      commentsController: commentsController ?? this.commentsController,
      tagsController: tagsController ?? this.tagsController,
    );
  }
}
