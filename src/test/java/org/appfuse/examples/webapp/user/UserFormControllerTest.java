package org.appfuse.examples.webapp.user;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.appfuse.model.User;
import org.appfuse.service.UserManager;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.MutablePropertyValues;
import org.springframework.context.MessageSource;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.context.support.StaticApplicationContext;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.validation.DataBinder;

import java.util.HashMap;
import java.util.Map;

import static org.junit.Assert.*;
import static org.mockito.Matchers.eq;
import static org.mockito.Mockito.*;

public class UserFormControllerTest {
    final Log log = LogFactory.getLog(UserFormControllerTest.class);
    UserFormController c = new UserFormController();
    MockHttpServletRequest request;
    User user = new User();
    UserManager userManager;

    @Before
    public void setUp() {
        userManager = mock(UserManager.class);
        // manually set properties (dependencies) on userFormController
        c.userManager = userManager;

        // set context with messages avoid NPE when controller calls
        // getMessageSourceAccessor().getMessage()
        StaticApplicationContext ctx = new StaticApplicationContext();
        Map<String, String> properties = new HashMap<String, String>();
        properties.put("basename", "messages");
        ctx.registerSingleton("messageSource", ResourceBundleMessageSource.class,
                new MutablePropertyValues(properties));
        ctx.refresh();
        c.setMessages((MessageSource) ctx.getBean("messageSource"));

        // setup user values
        user.setId(1L);
        user.setFirstName("Matt");
        user.setLastName("Raible");
    }

    @Test
    public void testEdit() throws Exception {
        log.debug("testing edit...");

        // set expected behavior on manager
        when(userManager.getUser(eq("1"))).thenReturn(user);

        request = new MockHttpServletRequest("GET", "/userform");
        request.addParameter("id", "1");
        User user = c.getUser(request);
        assertEquals("Matt", user.getFirstName());
    }

    @Test
    public void testSave() throws Exception {

        final User savedUser = user;
        savedUser.setLastName("Updated Last Name");
        // called by onSubmit()
        when(userManager.saveUser(savedUser)).thenReturn(savedUser);

        request = new MockHttpServletRequest("POST", "/userform");
        String view = c.onSubmit(savedUser, new DataBinder(user).getBindingResult(), request);
        assertEquals("redirect:users", view);
        assertNotNull(request.getSession().getAttribute("message"));
    }

    @Test
    public void testRemove() throws Exception {

        request = new MockHttpServletRequest("POST", "/userform");
        request.addParameter("delete", "");
        String view = c.onSubmit(user, new DataBinder(user).getBindingResult(), request);
        assertEquals("redirect:users", view);
        assertNotNull(request.getSession().getAttribute("message"));

        // called by onSubmit()
        verify(userManager, atLeastOnce()).removeUser("1");
    }
}
