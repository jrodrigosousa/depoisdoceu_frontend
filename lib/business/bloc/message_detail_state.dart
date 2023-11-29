part of 'message_detail_cubit.dart';

@immutable
class MessageDetailState {
  final Message message;
  final MessageOperation operation;

  MessageDetailState({required this.message, required this.operation});
}

