import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:diary_app/constants/api_url.dart';
import 'package:diary_app/models/diary_entry.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

part 'add_diary_event.dart';

part 'add_diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  DiaryBloc() : super(InitialDiaryState()) {
    on<AddDiaryDataEvent>((event, emit) async {
      emit(LoadingDiaryState());
      try {
        final response = await _postDataToWebService(event.diaryData!);
        if (response == 200) {
          emit(SuccessDiaryState());
        } else {
          emit(ErrorDiaryState('Failed to post data to the web service'));
        }
      } catch (e) {
        emit(ErrorDiaryState('An error occurred: $e'));
      }
    });
  }

  Future<int> _postDataToWebService(
    DiaryEntry? diaryData,
  ) async {
    final Uri apiUrl = Uri.parse(apiUrlLink);
    if (diaryData == null) {
      throw Exception('Invalid data or image');
    }

    try {
      if (diaryData.image != '') {
        final file = File(diaryData.image!);
        final List<int> imageBytes = await file.readAsBytes();
        final String base64Image = base64Encode(imageBytes);

        diaryData.image = base64Image;
      }
      final response = await http.post(
        apiUrl,
        body: jsonEncode(diaryData),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
       
        return response.statusCode;
      } else {
        throw ('Failed to post data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      throw ('Error posting data: $e');
    }
  }
}
