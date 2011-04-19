package org.appfuse.examples.webapp.security;

public interface LoginService {

  LoginStatus getStatus();

  LoginStatus login(String username, String password);
}
