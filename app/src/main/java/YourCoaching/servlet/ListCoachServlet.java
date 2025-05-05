package YourCoaching.servlet;

import YourCoaching.dao.CoachDao;
import YourCoaching.model.Coach;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/find-all-coaches")
public class ListCoachServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Obter lista de coaches usando o DAO
            CoachDao coachDao = new CoachDao();
            List<Coach> coaches = coachDao.findAllCoaches();

            // 2. Adicionar lista no escopo da requisição
            request.setAttribute("coaches", coaches);

            // 3. Encaminhar para a página JSP
            request.getRequestDispatcher("ListCoaches.jsp").forward(request, response);

        } catch (Exception e) {
            // 4. Tratamento de erro
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Erro ao listar coaches: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}