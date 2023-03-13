// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:match/match.dart';

import 'package:onlymessage/app/models/user.dart';

part 'perfil_edit_state.g.dart';

@match
enum PerfilEditStatus {
  initial,
  loading,
  success,
  error,
}

class PerfilEditState extends Equatable {
  final PerfilEditStatus status;
  final UserAuth? user;
  final String? successMessage;
  final String? errorMessage;
  final File? temporaryImage;

  const PerfilEditState({
    required this.status,
    this.user,
    this.successMessage,
    this.errorMessage,
    this.temporaryImage,
  });

  PerfilEditState.initial()
      : status = PerfilEditStatus.initial,
        successMessage = null,
        errorMessage = null,
        user = UserAuth(username: '', imageUrl: ''),
        temporaryImage = null;

  @override
  List<Object?> get props => [status, successMessage, errorMessage];

  PerfilEditState copyWith({
    PerfilEditStatus? status,
    UserAuth? user,
    String? successMessage,
    String? errorMessage,
    File? temporaryImage,
  }) {
    return PerfilEditState(
      status: status ?? this.status,
      user: user ?? this.user,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      temporaryImage: temporaryImage ?? this.temporaryImage,
    );
  }
}
