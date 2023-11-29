import '../model/recipient.dart';
import '../provider/recipient_provider.dart';

class RecipientRepository {

  RecipientProvider provider;

  RecipientRepository({required this.provider});

  Future<List<Recipient>> getAll() async {    
    List<dynamic> jsonList = await provider.fetchRecipients();
    List<Recipient> retorno = [];
    for(Map<String, dynamic> json in jsonList){
      Recipient recipient = Recipient.fromJson(json);
      retorno.add(recipient);
    }
    
    return retorno;
  }

  Future<Recipient> save(Recipient recipient) async {
    Map<String, dynamic> result;
    if(recipient.id == null){
      result = await provider.saveNewRecipient(recipient);
    } else {
      result = await provider.updateRecipient(recipient);
    }

    return Recipient.fromJson(result);
  }
}