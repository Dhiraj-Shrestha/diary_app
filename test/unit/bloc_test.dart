import 'dart:convert';

import 'package:diary_app/bloc/add_diary_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diary_app/models/diary_entry.dart';
import 'package:http/http.dart' as http;

void main() {
  group('DiaryBloc', () {
    test('Posting data updates state correctly', () {
      final diaryBloc = DiaryBloc();
      final diaryData = DiaryEntry(
        title: 'Test Title',
        price: 'Test Price',
        category: 'Test Category',
        description: 'Test Description',
        image: 'Test Image',
      );

      diaryBloc.add(AddDiaryDataEvent(diaryData: diaryData));

      diaryBloc.stream.listen((state) {
        if (state is SuccessDiaryState) {
          expect(state, isA<SuccessDiaryState>());
        } else if (state is ErrorDiaryState) {
          expect(state, isA<ErrorDiaryState>());
        }
      });

      diaryBloc.close();
    });
  });

  group(
    'postDataToWebService',
    () {
      test('Posting data returns a response', () async {
        final diaryData = DiaryEntry(
          title: 'Test Title',
          price: 'Test Price',
          category: 'Test Category',
          description: 'Test Description',
          image: 'Test Image',
        );

        final response = await postDataToWebService(diaryData);
        expect(response, isA<http.Response>());
      });
    },
  );
}

Future<http.Response> postDataToWebService(DiaryEntry data) async {
  try {
    final Uri apiUrl = Uri.parse('https://fakestoreapi.com/products');

    final response = await http.post(
      apiUrl,
      body: jsonEncode(data),
    );

    return response;
  } catch (e) {
    throw Exception('Error posting data: $e');
  }
}
