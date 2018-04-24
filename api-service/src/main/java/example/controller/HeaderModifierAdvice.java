package example.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.core.MethodParameter;
import org.springframework.core.io.ClassPathResource;
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

    @Value("${git.build.version:}")
    String buildVersion;

    @Value("${git.build.time:}")
    String buildTime;

    @Value("${git.branch:}")
    String buildBranch;

    @Value("${git.commit.id.abbrev:}")
    String buildTag;

    private HashMap<String, String> headers = new HashMap<>();

    @PostConstruct
    public void init() {
        headersPrefix = headersPrefix.toUpperCase();
        headers.put(headersPrefix + "BUILD_VER", buildVersion);
        headers.put(headersPrefix + "BUILD_TIME", buildTime);
        headers.put(headersPrefix + "BUILD_TAG", buildTag);
        headers.put(headersPrefix + "BUILD_BRANCH", buildBranch);
        headers.put("HOSTNAME", System.getenv("HOSTNAME"));

        for (Map.Entry<String, String> entry : System.getenv().entrySet()) {
            if (entry.getKey().toUpperCase().startsWith(headersPrefix)) {
                headers.put(entry.getKey().toUpperCase(), entry.getValue());
            }
        }
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

    @Bean
    public static PropertySourcesPlaceholderConfigurer placeholderConfigurer() {
        PropertySourcesPlaceholderConfigurer propsConfig = new PropertySourcesPlaceholderConfigurer();
        propsConfig.setLocation(new ClassPathResource("git.properties"));
        propsConfig.setIgnoreResourceNotFound(true);
        propsConfig.setIgnoreUnresolvablePlaceholders(true);
        return propsConfig;
    }
}