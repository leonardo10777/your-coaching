package YourCoaching.servlet;

import YourCoaching.dao.FeedbackDao;
import YourCoaching.model.Feedback;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet("/list-all-feedbacks")
public class ListAllFeedbacksServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            FeedbackDao feedbackDao = new FeedbackDao();
            List<Feedback> feedbacks = feedbackDao.findAllFeedbacks();

            request.setAttribute("feedbacks", feedbacks);
            request.getRequestDispatcher("listFeedbacks.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erro ao carregar feedbacks");
            request.getRequestDispatcher("listFeedbacks.jsp").forward(request, response);
        }
    }
}