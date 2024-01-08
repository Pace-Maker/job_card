// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'attachment_selection_bloc.dart';

@immutable
sealed class AttachmentSelectionEvent {}

class SelectAttachmentEvent extends AttachmentSelectionEvent {}

class UnSelectAttachment extends AttachmentSelectionEvent {
  final Map<String, dynamic> map;
  final bool isChecked;

  UnSelectAttachment({
    required this.map,
    required this.isChecked,
  });
}
