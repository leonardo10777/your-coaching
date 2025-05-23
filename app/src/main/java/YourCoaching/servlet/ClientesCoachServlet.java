package YourCoaching.servlet;

import YourCoaching.dao.ClienteDao;
import YourCoaching.model.Coach;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import YourCoaching.model.Cliente;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/clientes-coach")
public class ClientesCoachServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(ClientesCoachServlet.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("coach") == null) {
                response.sendRedirect("login-coach.jsp");
                return;
            }

            Coach coach = (Coach) session.getAttribute("coach");
            ClienteDao clienteDao = new ClienteDao();

            List<Cliente> clientes = clienteDao.findByCoach(coach.getId());
            request.setAttribute("clientes", clientes);

            request.getRequestDispatcher("/WEB-INF/views/coach/clientes-coach.jsp").forward(request, response);
        } catch (Exception e) {
            logger.severe("Erro ao carregar clientes: " + e.getMessage());
            request.setAttribute("errorMessage", "Erro ao carregar lista de clientes.");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
}