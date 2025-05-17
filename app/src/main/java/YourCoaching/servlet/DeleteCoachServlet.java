package YourCoaching.servlet;

import YourCoaching.dao.CoachDao;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/delete-coach")
public class DeleteCoachServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String coachId = request.getParameter("id");

        if (coachId == null || coachId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do coach não fornecido");
            return;
        }

        try {
            CoachDao coachDao = new CoachDao();
            coachDao.deleteCoachById(Integer.parseInt(coachId));

            response.sendRedirect("/find-all-coaches?sucesso=deletado");

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID inválido");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao deletar coach");
            e.printStackTrace();
        }
    }
}