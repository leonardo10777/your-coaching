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

        // Verificação mais robusta da sessão
        if (request.getSession().getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            CoachDao coachDao = new CoachDao();
            FeedbackDao feedbackDao = new FeedbackDao();

            List<Coach> coaches = coachDao.findAllCoaches();
            Map<Integer, List<Feedback>> feedbacksPorCoach = new HashMap<>();
            Map<Integer, Double> mediaAvaliacoes = new HashMap<>();

            // Processar cada coach
            for (Coach coach : coaches) {
                List<Feedback> feedbacks = feedbackDao.findFeedbacksByCoachId(coach.getId());

                // Calcular média das avaliações
                if (feedbacks != null && !feedbacks.isEmpty()) {
                    double soma = 0;
                    for (Feedback f : feedbacks) {
                        soma += f.getRating();
                    }
                    double media = soma / feedbacks.size();
                    mediaAvaliacoes.put(coach.getId(), media);
                } else {
                    mediaAvaliacoes.put(coach.getId(), 0.0);
                }

                feedbacksPorCoach.put(coach.getId(), feedbacks);
            }

            request.setAttribute("coaches", coaches);
            request.setAttribute("feedbacks", feedbacksPorCoach);
            request.setAttribute("medias", mediaAvaliacoes);

            // Corrigido para usar o nome correto do arquivo JSP
            request.getRequestDispatcher("ListCoaches.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erro ao carregar lista de coaches: " + e.getMessage());
            request.getRequestDispatcher("ListCoaches.jsp").forward(request, response);
        }
    }
}