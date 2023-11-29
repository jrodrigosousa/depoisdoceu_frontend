import 'package:bloc/bloc.dart';
import 'package:depois_do_ceu/data/repository/recipient_repository.dart';
import 'package:meta/meta.dart';

import '../../constants/enum.dart';
import '../../data/model/recipient.dart';
import '../../data/provider/recipient_provider.dart';

part 'recipient_detail_state.dart';

class RecipientDetailCubit extends Cubit<RecipientDetailState> {
  RecipientDetailCubit() : super(RecipientDetailState(recipient: Recipient.empty(), operation: RecipientOperation.NEW));
  RecipientRepository repository = RecipientRepository(provider: RecipientProvider());

  void setRecipient(Recipient recipient){
    emit(RecipientDetailState(recipient: recipient, operation: RecipientOperation.EDIT));
  }

  void saveRecipient() async {
    Recipient recipient = await repository.save(state.recipient);
    emit(RecipientDetailState(recipient: recipient, operation: RecipientOperation.UPDATE));
  }
}
