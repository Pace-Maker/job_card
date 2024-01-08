import 'package:bloc/bloc.dart';
import 'package:job_card/core/models/checked_attachments_model.dart';
import 'package:meta/meta.dart';

part 'attachment_selection_event.dart';
part 'attachment_selection_state.dart';

class AttachmentSelectionBloc
    extends Bloc<AttachmentSelectionEvent, AttachmentSelectionState> {
  AttachmentSelectionBloc()
      : super(AttachmentSelectionInitial(
            allAttachments: [], checkedAttachments: [])) {
    on<UnSelectAttachment>((event, emit) {
      Map<String, dynamic> map = event.map;

      if (event.isChecked) {
        state.checkedAttachments.removeWhere(
          (element) =>
              element.path == map['path'] &&
              element.fileName == map['fileName'],
        );
      } else {
        state.checkedAttachments.add(CheckedAttachmentModel.fromJson(map));
      }

      emit(AttachmentSelectionState(
        allAttachments: state.allAttachments,
        checkedAttachments: state.checkedAttachments,
      ));
    });
  }
}
