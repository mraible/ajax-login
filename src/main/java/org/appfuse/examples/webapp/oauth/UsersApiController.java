package org.appfuse.examples.webapp.oauth;

import org.appfuse.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.common.exceptions.InvalidTokenException;
import org.springframework.security.oauth2.consumer.*;
import org.springframework.security.oauth2.consumer.token.OAuth2ClientTokenServices;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@RequestMapping("/appfuse/users")
@Controller
public class UsersApiController {

    private OAuth2RestTemplate apiRestTemplate;
    @Autowired
    private OAuth2ClientTokenServices tokenServices;

    private static final String REMOTE_DATA_URL = "http://localhost:9000/appfuse-oauth/api/users";

    @Autowired
    public UsersApiController(OAuth2ProtectedResourceDetails resourceDetails) {
        this.apiRestTemplate = new OAuth2RestTemplate(resourceDetails);
    }

    @RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public List<User> getUsers() {
        try {
            List users = apiRestTemplate.getForObject(REMOTE_DATA_URL, List.class);
            return new ArrayList<User>(users);
        } catch (InvalidTokenException badToken) {
            //we've got a bad token, probably because it's expired.
            OAuth2ProtectedResourceDetails resource = apiRestTemplate.getResource();
            OAuth2SecurityContext context = OAuth2SecurityContextHolder.getContext();
            if (context != null) {
                // this one is kind of a hack for this application
                // the problem is that the sparklr photos page doesn't remove the 'code=' request parameter.
                ((OAuth2SecurityContextImpl) context).setVerificationCode(null);
            }
            //clear any stored access tokens...
            tokenServices.removeToken(SecurityContextHolder.getContext().getAuthentication(), resource);
            //go get a new access token...
            throw new OAuth2AccessTokenRequiredException(resource);
        }
    }
}
