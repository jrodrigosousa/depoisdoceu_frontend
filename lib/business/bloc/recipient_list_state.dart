part of 'recipient_list_cubit.dart';

@immutable
abstract class RecipientListState {}

class RecipientsLoading extends RecipientListState {}

class RecipientsLoaded extends RecipientListState {
  final List<Recipient> recipients;

  RecipientsLoaded(this.recipients);
}
