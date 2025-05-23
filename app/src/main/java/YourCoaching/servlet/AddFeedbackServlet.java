package YourCoaching.servlet;

import YourCoaching.dao.FeedbackDao;
import YourCoaching.model.Feedback;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(name = "AddFeedbackServlet", urlPatterns = {"/addFeedback"})
public class AddFeedbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Verifique se o usuário está logado
            if (request.getSession().getAttribute("usuario") == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Obtenha os parâmetros do formulário
            int coachId = Integer.parseInt(request.getParameter("coachId"));
            String comentario = request.getParameter("comentario").trim();

            // Validação básica
            if (comentario.isEmpty()) {
                throw new IllegalArgumentException("O comentário não pode estar vazio");
            }

            // Obtenha dados do usuário da sessão
            int usuarioId = (int) request.getSession().getAttribute("usuarioId");
            String usuarioNome = (String) request.getSession().getAttribute("usuarioNome");

            // Log para debug
            System.out.println("Adicionando feedback - Coach ID: " + coachId +
                    ", Usuario ID: " + usuarioId +
                    ", Usuario Nome: " + usuarioNome);

            // Crie o objeto Feedback
            Feedback feedback = new Feedback();
            feedback.setCoachId(coachId);
            feedback.setUsuarioId(usuarioId);
            feedback.setUsuarioNome(usuarioNome);
            feedback.setComentario(comentario);

            // Persista no banco
            new FeedbackDao().createFeedback(feedback);

            // Redirecione de volta
            response.sendRedirect(request.getContextPath() + "/list-coaches-for-users");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erro ao adicionar comentário: " + e.getMessage());
            request.getRequestDispatcher("/list-coaches-for-users").forward(request, response);
        }
    }

    // Implementação do método doGet para evitar erros 405
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirecionar para a página de coaches caso alguém acesse via GET
        response.sendRedirect(request.getContextPath() + "/list-coaches-for-users");
    }
}