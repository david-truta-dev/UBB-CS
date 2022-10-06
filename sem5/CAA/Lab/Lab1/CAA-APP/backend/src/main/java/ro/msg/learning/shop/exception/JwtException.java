package ro.msg.learning.shop.exception;

public class JwtException extends RuntimeException {
    public JwtException(String errorMessage) {
        super(errorMessage);
    }
}
