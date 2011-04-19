package org.appfuse.examples.webapp.security;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Matchers;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.TestingAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.context.SecurityContextImpl;

import static org.junit.Assert.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class SpringSecurityLoginTest {

    SpringSecurityLoginService loginService;
    AuthenticationManager authenticationManager;

    @Before
    public void before() {
        loginService = new SpringSecurityLoginService();
        authenticationManager = mock(AuthenticationManager.class);
        loginService.authenticationManager = authenticationManager;
    }

    @After
    public void after() {
        SecurityContextHolder.clearContext();
    }

    @Test
    public void testLoginStatusSuccess() {
        Authentication auth = new TestingAuthenticationToken("foo", "bar");
        auth.setAuthenticated(true);
        SecurityContext context = new SecurityContextImpl();
        context.setAuthentication(auth);
        SecurityContextHolder.setContext(context);

        LoginStatus status = loginService.getStatus();
        assertTrue(status.isLoggedIn());
    }

    @Test
    public void testLoginStatusFailure() {
        LoginStatus status = loginService.getStatus();
        assertFalse(status.isLoggedIn());
    }

    @Test
    public void testGoodLogin() {
        Authentication auth = new TestingAuthenticationToken("foo", "bar");
        auth.setAuthenticated(true);
        when(authenticationManager.authenticate(Matchers.<Authentication>anyObject())).thenReturn(auth);
        MockHttpServletRequest request = new MockHttpServletRequest();
        MockHttpServletResponse response = new MockHttpServletResponse();
        LoginStatus status = loginService.login("foo", "bar");
        assertTrue(status.isLoggedIn());
        assertEquals("foo", status.getUsername());
    }

    @Test
    public void testBadLogin() {
        Authentication auth = new TestingAuthenticationToken("foo", "bar");
        auth.setAuthenticated(false);
        when(authenticationManager.authenticate(Matchers.<Authentication>anyObject()))
                .thenThrow(new BadCredentialsException("Bad Credentials"));
        MockHttpServletRequest request = new MockHttpServletRequest();
        MockHttpServletResponse response = new MockHttpServletResponse();
        LoginStatus status = loginService.login("foo", "bar");
        assertFalse(status.isLoggedIn());
        assertEquals(null, status.getUsername());
    }
}
