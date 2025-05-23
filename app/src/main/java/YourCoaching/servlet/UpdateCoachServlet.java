package YourCoaching.servlet;

import YourCoaching.dao.CoachDao;
import YourCoaching.model.Coach;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;


@WebServlet(name = "UpdateCoachServlet", value = {"/edit-coach", "/update-coach"})
public class UpdateCoachServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Coach coach = new CoachDao().findCoachById(id);

            if (coach != null) {
                request.setAttribute("coach", coach);
                request.getRequestDispatcher("/editarCoach.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/find-all-coaches?error=not_found");
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/find-all-coaches?error=load_error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Coach coach = new Coach(
                    Integer.parseInt(request.getParameter("id")),
                    request.getParameter("nome"),
                    request.getParameter("email"),
                    request.getParameter("telefone"),
                    request.getParameter("senha"),
                    LocalDate.parse(request.getParameter("dataNascimento")),
                    request.getParameter("curso"),
                    request.getParameter("area"),
                    request.getParameter("descricaoProfissional"),
                    request.getParameter("preco")
            );

            new CoachDao().updateCoach(coach);
            response.sendRedirect(request.getContextPath() + "/find-all-coaches?success=updated");

        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/edit-coach?id=" + request.getParameter("id") + "&error=update_failed");
        }
    }
}