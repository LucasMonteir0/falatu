import "package:equatable/equatable.dart";
import "package:falatu_mobile/commons/core/domain/services/share_service/share_service.dart";

abstract class ShareState extends Equatable {}

class ShareInitialState implements ShareState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class ShareLoadingState implements ShareState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class ShareDoneState implements ShareState {
  final ShareServiceResult result;

  ShareDoneState(this.result);

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}
