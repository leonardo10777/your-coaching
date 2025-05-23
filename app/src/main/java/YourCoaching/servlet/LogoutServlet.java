package YourCoaching.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Invalida a sessão atual
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Verifica se deve mostrar mensagem via forward ou fazer redirect simples
        String showMessage = request.getParameter("showMessage");

        if ("true".equals(showMessage)) {
            // Comportamento original - com mensagem de sucesso
            request.setAttribute("message", "Logout realizado com sucesso");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // Comportamento novo - redirect simples
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Permite logout via POST também
        doGet(request, response);
    }
}