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

@WebServlet("/list-coaches-for-users")
public class ListCoachesForUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            CoachDao coachDao = new CoachDao();
            List<Coach> coaches = coachDao.findAllCoaches();

            request.setAttribute("coaches", coaches);
            request.getRequestDispatcher("coachs.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Erro ao listar coaches: " + e.getMessage());
        }
    }
}