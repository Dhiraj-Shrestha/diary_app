import 'dart:io';

import 'package:diary_app/bloc/add_diary_bloc.dart';
import 'package:diary_app/bloc/diary/diary_data_cubit.dart';
import 'package:diary_app/bloc/location/location_cubit.dart';
import 'package:diary_app/constants/colors.dart';
import 'package:diary_app/constants/fonts.dart';
import 'package:diary_app/models/diary_entry.dart';
import 'package:diary_app/widgets/elevated_container.dart';
import 'package:diary_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildAddForm(context) {
  return Column(
    // crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      _buildLocationInfo(context),
      Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.grey.shade200,
        child: Column(children: [
          _buildAddPhotosSection(),
          _buildCommentsSection(),
          _buildDetailsSection(),
          _buildLinkToEventSection(),
          const SizedBox(
            height: 20,
          ),
          _buildSubmitButton(context),
        ]),
      )
    ],
  );
}

Widget _buildLocationInfo(BuildContext context) {
  return Container(
    height: 50,
    margin: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        IconButton(
            onPressed: () {
              context.read<LocationCubit>().requestLocationPermission();
            },
            icon: const Icon(Icons.location_pin)),
        BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            if (state is LocationLoadingState) {
              return const Text("Fetching location...");
            } else if (state is LocationAddressState) {
              return Text(
                state.address,
                style: const TextStyle(fontSize: normalText),
              );
            } else if (state is LocationErrorState) {
              return const Text(
                "20041075|TAP-NS North Strathfield",
                style: TextStyle(
                  fontSize: normalText,
                ),
              );
            } else {
              return Text(state.toString());
            }
          },
        ),
      ],
    ),
  );
}

Widget _buildAddPhotosSection() {
  return BlocBuilder<DiaryDataCubit, DiaryDataState>(
    builder: (context, state) {
      final diaryDataCubit = context.read<DiaryDataCubit>();

      Future<void> addPhoto(BuildContext context) async {
        await diaryDataCubit.addPhoto(context);
      }

      return Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Add to site diary",
                style: TextStyle(fontSize: headingText),
              ),
              Icon(
                Icons.help,
                color: textBlackShade,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          ElevatedContainer(
            title: 'Add Photos to site diary',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildSelectedImages(),
                ElevatedButton(
                  onPressed: () => addPhoto(context),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: buttonColor),
                  child: const Text('Add Photo'),
                ),
                const SizedBox(
                  height: 10,
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: buttonColor,
                  value: state.includeValue,
                  onChanged: (value) {
                    diaryDataCubit.updateIncludeValue(value!);
                  },
                  title: const Text(
                    "Include in photo gallery",
                    style: TextStyle(color: textBlackShade),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      );
    },
  );
}

Widget _buildSelectedImages() {
  return BlocBuilder<DiaryDataCubit, DiaryDataState>(builder: (context, state) {
    final diaryDataCubit = context.read<DiaryDataCubit>();

    return state.selectedImages!.isNotEmpty
        ? SizedBox(
            height: 150.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.selectedImages!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.file(
                              File(state.selectedImages![index].path),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: -10,
                        child: SizedBox(
                          child: ElevatedButton(
                            onPressed: () {
                              diaryDataCubit.updateImages(
                                  List.from(state.selectedImages!)
                                    ..removeAt(index));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: const CircleBorder(),
                                minimumSize: const Size(24, 24)),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        : const SizedBox();
  });
}

Widget _buildCommentsSection() {
  return BlocBuilder<DiaryDataCubit, DiaryDataState>(builder: (context, state) {
    final diaryDataCubit = context.read<DiaryDataCubit>();
    return ElevatedContainer(
      title: 'Comments',
      content: TextFormField(
        controller: state.commentsController,
        decoration: const InputDecoration(
          labelText: 'Comments',
        ),
      ),
    );
  });
}

Widget _buildDetailsSection() {
  return BlocBuilder<DiaryDataCubit, DiaryDataState>(builder: (context, state) {
    final diaryDataCubit = context.read<DiaryDataCubit>();
    return ElevatedContainer(
      title: 'Details',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdown(
            state.selectedDate,
            state.dateOptions,
            (value) {
              diaryDataCubit.updateDate(value!);
            },
          ),
          const SizedBox(height: 16.0),
          _buildDropdown(
            state.selectedArea,
            state.areaOptions,
            (value) {
              diaryDataCubit.updateArea(value!);
            },
          ),
          const SizedBox(height: 16.0),
          _buildDropdown(
            state.selectedTaskCategory,
            state.taskCategoryOptions,
            (value) {
              diaryDataCubit.updateTaskCategory(value!);
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: state.tagsController,
            decoration: const InputDecoration(
              labelText: ' Tags',
              labelStyle: TextStyle(color: textBlackShade),
              contentPadding: EdgeInsets.all(12.0),
            ),
          ),
        ],
      ),
    );
  });
}

Widget _buildDropdown(
  String value,
  List<String> options,
  void Function(String?) onChanged,
) {
  return DropdownButton<String>(
    isExpanded: true,
    value: value,
    icon: const Icon(Icons.keyboard_arrow_down),
    onChanged: onChanged,
    items: options.map((option) {
      return DropdownMenuItem<String>(
        value: option,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            option,
            style: const TextStyle(color: textBlackShade),
          ),
        ),
      );
    }).toList(),
  );
}

Widget _buildLinkToEventSection() {
  return BlocBuilder<DiaryDataCubit, DiaryDataState>(builder: (context, state) {
    final diaryDataCubit = context.read<DiaryDataCubit>();
    return ElevatedContainer(
      titleWidget: CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        activeColor: buttonColor,
        value: state.linkValue,
        onChanged: (value) {
          diaryDataCubit.updateLinkValue(value!);
        },
        title: const Text(
          "Link to existing event?",
          style: TextStyle(color: textBlackShade),
        ),
      ),
      content: _buildDropdown(
        state.selectedEventOptions,
        state.eventOptions,
        (value) {
          diaryDataCubit.updateEvent(value!);
        },
      ),
    );
  });
}

Widget _buildSubmitButton(BuildContext context) {
  return BlocConsumer<DiaryBloc, DiaryState>(
    listener: (context, state) {
      if (state is SuccessDiaryState) {
        CustomSnackBar.show(context, 'Data posted successfully');
      }
      if (state is ErrorDiaryState) {
        CustomSnackBar.show(context, 'Something went wrong!');
      }
    },
    builder: (context, state) {
      return BlocBuilder<DiaryDataCubit, DiaryDataState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () async {
              final diaryData = DiaryEntry(
                title: state.selectedDate,
                price: state.selectedArea,
                category: state.tagsController.text,
                image: state.selectedImages!.isNotEmpty
                    ? state.selectedImages![0].path
                    : '',
                description: state.commentsController.text,
              );

              final addDiaryEvent = AddDiaryDataEvent(
                diaryData: diaryData,
              );

              context.read<DiaryBloc>().add(addDiaryEvent);

              CustomSnackBar.show(context, 'Posting data...');
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: buttonColor),
            child: const Text('Next'),
          );
        },
      );
    },
  );
}