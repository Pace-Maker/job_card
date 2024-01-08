// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'attachment_selection_bloc.dart';

class AttachmentSelectionState {
   List allAttachments;
   List<CheckedAttachmentModel> checkedAttachments;

  AttachmentSelectionState({
    required this.allAttachments,
    required this.checkedAttachments,
  });
}

final class AttachmentSelectionInitial extends AttachmentSelectionState {
  AttachmentSelectionInitial({required super.allAttachments,required super.checkedAttachments});
}
