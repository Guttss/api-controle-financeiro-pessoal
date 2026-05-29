package finance_api.controller;

import finance_api.model.TransactionModel;
import finance_api.service.TransactionService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("transactions")
@RequiredArgsConstructor
public class TransactionController {

    public final TransactionService transactionService;

    @PostMapping()
    @ResponseStatus(HttpStatus.CREATED)
    public TransactionModel save (@Valid @RequestBody TransactionModel transactionModel) {
        return transactionService.saveObject(transactionModel);
    }

    @GetMapping()
    public List<TransactionModel> listTransactions () {
        return transactionService.findAll();
    }

    @GetMapping("{type}")
    public List<TransactionModel> listTransactionsByType (@PathVariable String type) {
        return transactionService.findAllByType(type);
    }

    @DeleteMapping("{id}")
    public void delete(@PathVariable Long id) {
        transactionService.delete(id);
    }

}
