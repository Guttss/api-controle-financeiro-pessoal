package finance_api.service;

import finance_api.model.TransactionModel;
import finance_api.repository.TransactionRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
@AllArgsConstructor
public class TransactionService {

    public final TransactionRepository transactionRepository;

    public TransactionModel saveObject(TransactionModel transactionModel){

        BigDecimal newTotal = this.total();

        if(transactionModel.getAmount() != null && transactionModel.getType()!=null){
            if(transactionModel.getType().equalsIgnoreCase("income")){
                newTotal = newTotal.add(transactionModel.getAmount());
            }
            else if (transactionModel.getType().equalsIgnoreCase("expense")){
                newTotal = newTotal.subtract(transactionModel.getAmount());
            }
        }
        transactionModel.setTotal(newTotal);

        return transactionRepository.save(transactionModel);
    }

    public List<TransactionModel> findAll(){
        return transactionRepository.findAll();
    }

    public List<TransactionModel> findAllByType(String type){
        return transactionRepository.findByType(type);
    }

    public BigDecimal total(){

        BigDecimal newTotal = BigDecimal.ZERO;

        for(TransactionModel transactionModel : transactionRepository.findAll()){
            if(transactionModel.getAmount() != null && transactionModel.getType()!=null){
                if(transactionModel.getType().equalsIgnoreCase("income")){
                    newTotal = newTotal.add(transactionModel.getAmount());
                }
                else if (transactionModel.getType().equalsIgnoreCase("expense")){
                    newTotal = newTotal.subtract(transactionModel.getAmount());
                }
            }
        }
        return newTotal;
    }

    public void delete(Long id){

        transactionRepository.findById(id).orElseThrow(() -> new RuntimeException("Não foi possivel deletar. Transação não encontrada com o ID: " + id));

        transactionRepository.deleteById(id);
    }
}
