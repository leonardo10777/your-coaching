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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String coachIdParam = req.getParameter("id");

        // Validação básica do parâmetro
        if (coachIdParam == null || coachIdParam.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do usuário não fornecido.");
            return;
        }

        try {
            Integer coachId = Integer.parseInt(coachIdParam);
            CoachDao coachDao = new CoachDao();
            coachDao.deleteCoachById(coachId);

            // Redireciona para a lista de usuários após a deleção
            resp.sendRedirect("/find-all-coaches");

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID inválido. Deve ser um número inteiro.");
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao deletar usuário.");
            e.printStackTrace();
        }
    }
}
