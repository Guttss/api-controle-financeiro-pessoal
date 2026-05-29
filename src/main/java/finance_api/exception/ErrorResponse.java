package finance_api.exception;


import java.time.LocalDateTime;

public record ErrorResponse (LocalDateTime timestamp, int status, String error, String message){
}
