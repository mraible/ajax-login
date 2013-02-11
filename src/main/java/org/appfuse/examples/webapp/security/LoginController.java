package org.appfuse.examples.webapp.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/api/login.json")
public class LoginController {

    @Autowired
    @Qualifier("springLoginService")
    LoginService loginService;

    @RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public LoginStatus getStatus() {
        return loginService.getStatus();
    }

    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    public LoginStatus login(@RequestParam("j_username") String username,
                             @RequestParam("j_password") String password) {

        return loginService.login(username, password);
    }
}
