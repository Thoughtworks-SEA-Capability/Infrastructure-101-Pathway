package hello;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @Autowired
    private Environment env;

    @RequestMapping("/")
    public String index() {
        String greeting = env.getProperty("app.greeting");
        String title = env.getProperty("app.title");

        greeting = greeting == null ? "Hello" : greeting;
        title = title == null ? "Infrastructure 101" : title;

        return String.format("%s %s!", greeting, title);
    }
}
