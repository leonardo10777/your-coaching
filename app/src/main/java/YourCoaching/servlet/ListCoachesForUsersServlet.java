package YourCoaching.servlet;

import YourCoaching.dao.CoachDao;
import YourCoaching.dao.FeedbackDao;
import YourCoaching.model.Coach;
import YourCoaching.model.Feedback;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@WebServlet("/list-coaches-for-users")
public class ListCoachesForUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Verificar se o usuário está logado
        if (request.getSession().getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            CoachDao coachDao = new CoachDao();
            FeedbackDao feedbackDao = new FeedbackDao();

            List<Coach> coaches = coachDao.findAllCoaches();
            Map<Integer, List<Feedback>> feedbacksPorCoach = new HashMap<>();

            for (Coach coach : coaches) {
                List<Feedback> feedbacks = feedbackDao.findFeedbacksByCoachId(coach.getId());
                feedbacksPorCoach.put(coach.getId(), feedbacks);
            }

            request.setAttribute("coaches", coaches);
            request.setAttribute("feedbacks", feedbacksPorCoach);
            request.getRequestDispatcher("coachs.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Erro ao listar coaches: " + e.getMessage());
        }
    }
}