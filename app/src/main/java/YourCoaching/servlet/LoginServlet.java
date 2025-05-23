package YourCoaching.servlet;

import YourCoaching.dao.CoachDao;
import YourCoaching.dao.UsuarioDao;
import YourCoaching.model.Coach;
import YourCoaching.model.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirecionar para a página de login se acessada via GET
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String tipoUsuario = request.getParameter("tipoUsuario"); // "usuario" ou "coach"

        try {
            if ("usuario".equals(tipoUsuario)) {
                UsuarioDao usuarioDao = new UsuarioDao();
                Usuario usuario = usuarioDao.findUsuarioByEmailAndSenha(email, senha);
                if (usuario != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("usuario", usuario);
                    session.setAttribute("tipoUsuario", "usuario");

                    // Adicionar explicitamente ID e nome do usuário na sessão para uso no AddFeedbackServlet
                    session.setAttribute("usuarioId", usuario.getId());
                    session.setAttribute("usuarioNome", usuario.getNome());

                    response.sendRedirect("dashboard-usuario.jsp");
                } else {
                    request.setAttribute("mensagem", "Email ou senha incorretos.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else if ("coach".equals(tipoUsuario)) {
                CoachDao coachDao = new CoachDao();
                Coach coach = coachDao.findCoachByEmailAndSenha(email, senha);
                if (coach != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("coach", coach);
                    session.setAttribute("tipoUsuario", "coach");
                    session.setAttribute("coachId", coach.getId());
                    session.setAttribute("coachNome", coach.getNome());

                    // Corrigir o redirecionamento para dashboard-coach.jsp, sem o .jsp
                    response.sendRedirect("dashboard-coach.jsp");
                } else {
                    request.setAttribute("mensagem", "Email ou senha incorretos.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("mensagem", "Tipo de usuário inválido.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensagem", "Erro no servidor: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}