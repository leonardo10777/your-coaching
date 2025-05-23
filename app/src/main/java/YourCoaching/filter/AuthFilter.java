package YourCoaching.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();

        // URLs públicas (incluindo H2 Console e recursos estáticos)
        if (requestURI.startsWith(contextPath + "/console") ||  // Libera /console e subpaths
                requestURI.contains("/h2-console") ||              // Caso o path mude (redundante)
                requestURI.endsWith("index.html") ||
                requestURI.endsWith("login.jsp") ||
                requestURI.endsWith("login") ||
                requestURI.endsWith("create-user") ||
                requestURI.endsWith("create-coach") ||
                requestURI.endsWith("sobre.html") ||
                requestURI.endsWith("contato.html") ||
                requestURI.contains(".css") ||                     // Libera todos os CSS
                requestURI.contains(".js") ||                      // Libera todos os JS
                requestURI.contains(".png") ||                     // Libera imagens
                requestURI.equals(contextPath + "/")) {
            chain.doFilter(request, response);
            return;
        }

        // Verificar autenticação para URLs protegidas
        if (session == null || session.getAttribute("tipoUsuario") == null) {
            httpResponse.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        // Restrições por tipo de usuário (usuário/coach)
        String tipoUsuario = (String) session.getAttribute("tipoUsuario");
        if (tipoUsuario.equals("usuario")) {
            if (requestURI.contains("dashboard-coach") || requestURI.contains("agendamentos-coach.html")) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
        } else if (tipoUsuario.equals("coach")) {
            if (requestURI.contains("dashboard-usuario.jsp") || requestURI.contains("perfil-usuario.html")) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}