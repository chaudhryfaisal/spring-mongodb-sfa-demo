package example.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class HeaderModifierAdvice implements ResponseBodyAdvice<Object> {

    @Value("${headers.prefix:app_}")
    String headersPrefix;

    private HashMap<String, String> headers = new HashMap<>();

    @PostConstruct
    public void init() {
        for (Map.Entry<String, String> entry : System.getenv().entrySet()) {
            if (entry.getKey().toLowerCase().startsWith(headersPrefix)) {
                headers.put(entry.getKey(), entry.getValue());
            }
        }
        headers.put("HOSTNAME", System.getenv("HOSTNAME"));
    }

    @Override
    public boolean supports(final MethodParameter returnType, final Class<? extends HttpMessageConverter<?>> converterType) {
        return true;
    }

    @Override
    public Object beforeBodyWrite(final Object body,
                                  final MethodParameter returnType,
                                  final MediaType selectedContentType,
                                  final Class<? extends HttpMessageConverter<?>> selectedConverterType,
                                  final ServerHttpRequest request,
                                  final ServerHttpResponse response) {
        headers.forEach((key, value) -> response.getHeaders().add(key, value));
        return body;
    }
}