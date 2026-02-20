import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profile_bloc.dart';
import '../widget/profile.dart';

Widget profileScreen() {
  return BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {
      return switch (state.status) {
        ProfileStatus.loading => const Center(
          child: CircularProgressIndicator(),
        ),
        ProfileStatus.error => Center(
          child: Text(
            state.errorMessage ?? 'Something went wrong',
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        ProfileStatus.loaded => ProfileBody(user: state.user!),
        _ => const SizedBox.shrink(),
      };
    },
  );
}
