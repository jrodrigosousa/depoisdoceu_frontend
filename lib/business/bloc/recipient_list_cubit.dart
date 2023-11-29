import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:depois_do_ceu/business/bloc/recipient_detail_cubit.dart';
import 'package:depois_do_ceu/data/provider/recipient_provider.dart';
import 'package:meta/meta.dart';

import '../../constants/enum.dart';
import '../../data/model/recipient.dart';
import '../../data/repository/recipient_repository.dart';

part 'recipient_list_state.dart';

class RecipientListCubit extends Cubit<RecipientListState> {
  late RecipientDetailCubit detailCubit;
  StreamSubscription? _recipientDetailSubscription;

  RecipientListCubit(RecipientDetailCubit detailCubit) : super(RecipientsLoading()){
    this.detailCubit = detailCubit;
    monitorRecipientDetail(detailCubit);
  }

  void monitorRecipientDetail(RecipientDetailCubit recipientDetailCubit) {
    _recipientDetailSubscription = recipientDetailCubit.stream.listen((state) {
      refresh();
    });
  }

  Future<void> refresh() async{
    emit(RecipientsLoading());

    RecipientProvider recipientProvider = RecipientProvider();
    RecipientRepository recipientRepository = RecipientRepository(provider: recipientProvider);
    List<Recipient> recipients = await recipientRepository.getAll();

    emit(RecipientsLoaded(recipients));
  }
}
