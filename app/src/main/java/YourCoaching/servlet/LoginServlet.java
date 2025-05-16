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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("login-email");
        String senha = request.getParameter("login-password");
        String tipoUsuario = request.getParameter("tipo-usuario");

        try {
            if ("coach".equals(tipoUsuario)) {
                CoachDao coachDao = new CoachDao();
                Coach coach = coachDao.findCoachByEmailAndSenha(email, senha);

                if (coach != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", coach);
                    session.setAttribute("tipoUsuario", "coach");
                    response.sendRedirect("dashboard-coach.html");
                } else {
                    response.sendRedirect("index.html?erro=login");
                }
            } else {
                UsuarioDao usuarioDao = new UsuarioDao();
                Usuario usuario = usuarioDao.findUsuarioByEmailAndSenha(email, senha);

                if (usuario != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", usuario);
                    session.setAttribute("tipoUsuario", "usuario");
                    response.sendRedirect("list-coaches-for-users");  // Alterado para redirecionar para a lista de coaches
                } else {
                    response.sendRedirect("index.html?erro=login");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.html?erro=banco-dados");
        }
    }
}