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
            CoachDao dao = new CoachDao();
            dao.createTableIfNotExists(); // Garante que a tabela existe

            List<Coach> coaches = dao.findAllCoaches();

            if (coaches == null || coaches.isEmpty()) {
                request.setAttribute("emptyMessage", "Nenhum coach cadastrado");
            }

            request.setAttribute("coaches", coaches);
            request.getRequestDispatcher("ListCoaches.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erro ao carregar lista de coaches");
            request.getRequestDispatcher("ListCoaches.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
