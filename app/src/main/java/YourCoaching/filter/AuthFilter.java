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

        // Páginas públicas que não requerem autenticação
        if (requestURI.endsWith("index.html") ||
                requestURI.endsWith("login.jsp") ||
                requestURI.endsWith("login") ||
                requestURI.endsWith("create-user") ||
                requestURI.endsWith("create-coach") ||
                requestURI.endsWith("sobre.html") ||
                requestURI.endsWith("contato.html") ||
                requestURI.contains("/css/") ||
                requestURI.contains("/js/") ||
                requestURI.contains("/img/") ||
                requestURI.equals(contextPath + "/")) {
            chain.doFilter(request, response);
            return;
        }

        // Verificar se o usuário está logado
        if (session == null || session.getAttribute("tipoUsuario") == null) {
            httpResponse.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        String tipoUsuario = (String) session.getAttribute("tipoUsuario");

        // Restrições para usuários comuns
        if (tipoUsuario.equals("usuario")) {
            // Usuários podem ver perfis de coaches (perfil-coach), mas não podem acessar:
            // - Dashboard de coach
            // - Agendamentos de coach
            if (requestURI.contains("dashboard-coach") ||
                    requestURI.contains("agendamentos-coach.html")) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
        }

        // Restrições para coaches
        if (tipoUsuario.equals("coach")) {
            if (requestURI.contains("dashboard-usuario.jsp") ||
                    requestURI.contains("perfil-usuario.html") ||
                    requestURI.contains("agendamentos.html") ||
                    requestURI.contains("meus-agendamentos") ||
                    requestURI.contains("list-coaches-for-users")) {
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