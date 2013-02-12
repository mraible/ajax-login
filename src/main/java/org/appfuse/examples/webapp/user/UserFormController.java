package org.appfuse.examples.webapp.user;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.appfuse.model.User;
import org.appfuse.service.UserExistsException;
import org.appfuse.service.UserManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.context.MessageSource;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.Validator;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/userform*")
public class UserFormController {
    private final Log log = LogFactory.getLog(UserFormController.class);

    @Autowired
    UserManager userManager;

    @Autowired(required = false)
    Validator validator;

    private MessageSourceAccessor messages;

    @Autowired
    public void setMessages(MessageSource messageSource) {
        messages = new MessageSourceAccessor(messageSource);
    }

    /**
     * Set up a custom property editor for converting Longs
     * @param binder the default databinder
     */
    @InitBinder
    public void initBinder(ServletRequestDataBinder binder) {
        // convert java.util.Date
        SimpleDateFormat dateFormat = new SimpleDateFormat(getText("date.format"));
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, null,
                new CustomDateEditor(dateFormat, true));

        // convert java.lang.Long
        binder.registerCustomEditor(Long.class, null,
                new CustomNumberEditor(Long.class, null, true));
    }

    @RequestMapping(method = RequestMethod.POST)
    public String onSubmit(User user, BindingResult result, HttpServletRequest request) throws Exception {

        if (request.getParameter("cancel") != null)
            return "redirect:users";


        if (validator != null) { // validator is null during testing
            validator.validate(user, result);

            if (result.hasErrors()) {
                return "userform";
            }
        }

        log.debug("entering 'onSubmit' method...");

        if (request.getParameter("delete") != null) {
            userManager.removeUser(user.getId().toString());
            request.getSession().setAttribute("message",
                    getText("user.deleted", user.getFullName()));
        } else {
            try {
                userManager.saveUser(user);
            } catch (UserExistsException uex) {
                result.addError(new ObjectError("user", uex.getMessage()));
                return "userform";
            }
            request.getSession().setAttribute("message",
                    getText("user.saved", user.getFullName()));
        }

        return "redirect:users";
    }

    @ModelAttribute
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST})
    protected User getUser(HttpServletRequest request) {
        String userId = request.getParameter("id");
        if ((userId != null) && !userId.equals("")) {
            return userManager.getUser(userId);
        } else {
            return new User();
        }
    }

    /**
     * Convenience method for getting a i18n key's value.
     *
     * @param msgKey the i18n key to lookup
     * @return the message for the key
     */
    public String getText(String msgKey) {
        return messages.getMessage(msgKey);
    }

    /**
     * Convenient method for getting a i18n key's value with a single
     * string argument.
     *
     * @param msgKey the i18n key to lookup
     * @param arg    arguments to substitute into key's value
     * @return the message for the key
     */
    public String getText(String msgKey, String arg) {
        return getText(msgKey, new Object[]{arg});
    }

    /**
     * Convenience method for getting a i18n key's value with arguments.
     *
     * @param msgKey the i18n key to lookup
     * @param args   arguments to substitute into key's value
     * @return the message for the key
     */
    public String getText(String msgKey, Object[] args) {
        return messages.getMessage(msgKey, args);
    }
}
