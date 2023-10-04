import 'dart:io';

import 'package:diary_app/bloc/diary/diary_data_cubit.dart';
import 'package:diary_app/widgets/add_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diary_app/bloc/add_diary_bloc.dart';
import 'package:diary_app/bloc/location/location_cubit.dart';
import 'package:diary_app/constants/colors.dart';
import 'package:diary_app/constants/fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:diary_app/models/diary_entry.dart';
import 'package:diary_app/widgets/custom_app_bar.dart';
import 'package:diary_app/widgets/elevated_container.dart';

class AddDiaryPage extends StatefulWidget {
  const AddDiaryPage({Key? key}) : super(key: key);

  @override
  _AddDiaryPageState createState() => _AddDiaryPageState();
}

class _AddDiaryPageState extends State<AddDiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DiaryBloc(),
          ),
        
          BlocProvider(
            create: (context) => DiaryDataCubit(),
          ),
        ],
        child: SingleChildScrollView(
          child: buildAddForm(context),
        ),
      ),
    );
  }
}
