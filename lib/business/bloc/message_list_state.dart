part of 'message_list_cubit.dart';

@immutable
abstract class MessageListState {}

class MessagesLoading extends MessageListState {}

class MessagesLoaded extends MessageListState {
  final List<Message> messages;

  MessagesLoaded(this.messages);
}
