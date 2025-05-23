package YourCoaching.servlet;

import YourCoaching.dao.FeedbackDao;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/delete-feedback")
public class DeleteFeedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String feedbackId = request.getParameter("id");

        if (feedbackId == null || feedbackId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do feedback não fornecido");
            return;
        }

        try {
            int id = Integer.parseInt(feedbackId);
            FeedbackDao feedbackDao = new FeedbackDao();
            feedbackDao.deleteFeedbackById(id);

            response.sendRedirect("list-all-feedbacks?success=deleted");

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID inválido");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("list-all-feedbacks?error=delete_error");
        }
    }
}