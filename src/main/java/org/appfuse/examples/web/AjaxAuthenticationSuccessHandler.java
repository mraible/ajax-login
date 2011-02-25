package org.appfuse.examples.web;

public class AjaxAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
    private AuthenticationSuccessHandler defaultHandler;

    public AjaxAuthenticationSuccessHandler(AuthenticationSuccessHandler defaultHandler) {
        this.defaultHandler = defaultHandler;
    }

    void onAuthenticationSuccess(HttpServletRequest request,
        HttpServletResponse response, Authentication auth) {
        if ("true".eqauls(request.getHeader("X-Ajax-call")) {
            response.getWriter().print("ok");
            response.getWriter().flush();
        } else {
            defaultHandler.onAuthenticationSuccess(request, response, auth);
        }
    }
}
