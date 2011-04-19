package org.appfuse.examples.webapp.user;

import java.util.ArrayList;
import java.util.List;

import org.appfuse.examples.webapp.user.UserController;
import org.appfuse.model.User;
import org.appfuse.service.UserManager;
import static org.junit.Assert.*;
import static org.mockito.Mockito.when;

import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;
import org.springframework.ui.ModelMap;

public class UserControllerTest {
    UserController c = new UserController();
    UserManager userManager;

    @Before
    public void setUp() {
        userManager = Mockito.mock(UserManager.class);
        c.userManager = userManager;
    }

    @Test
    public void testGetUsers() {
        // set expected behavior on manager
        User user1 = new User();
        user1.setFirstName("ControllerTest");
        final List<User> users = new ArrayList<User>();
        users.add(user1);

        when(userManager.getUsers()).thenReturn(users);

        ModelMap map = new ModelMap();
        String result = c.execute(map);
        assertFalse(map.isEmpty());
        assertNotNull(map.get("userList"));
        assertEquals("userList", result);
    }
}
