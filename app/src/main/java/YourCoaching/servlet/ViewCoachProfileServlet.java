package YourCoaching.servlet;

import YourCoaching.dao.CoachDao;
import YourCoaching.model.Coach;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/perfil-coach")
public class ViewCoachProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int coachId = Integer.parseInt(request.getParameter("coachId"));
            CoachDao coachDao = new CoachDao();
            Coach coach = coachDao.findCoachById(coachId);

            if (coach != null) {
                request.setAttribute("coach", coach);
                request.getRequestDispatcher("perfil-coach.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Coach não encontrado");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do coach inválido");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Erro ao carregar perfil do coach: " + e.getMessage());
        }
    }
}