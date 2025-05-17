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

@WebServlet("/create-coach")
public class CreateCoachServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Obter parâmetros
            String nome = request.getParameter("coach-nome");
            String email = request.getParameter("coach-email");
            String telefone = request.getParameter("coach-telefone");
            String senha = request.getParameter("coach-password");
            LocalDate dataNascimento = LocalDate.parse(request.getParameter("coach-nascimento"));
            String curso = request.getParameter("coach-curso");
            String area = request.getParameter("coach-area");
            String descricao = request.getParameter("coach-desc");
            String preco = request.getParameter("coach-preco");

            // Validação básica
            if (nome == null || nome.isEmpty() || email == null || !email.contains("@")) {
                response.sendRedirect("index.html?erro=validacao");
                return;
            }

            // Criar e persistir coach
            Coach coach = new Coach(nome, email, telefone, senha, dataNascimento,
                    curso, area, descricao, preco);

            new CoachDao().createCoach(coach);

            response.sendRedirect("index.html?sucesso=cadastro");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.html?erro=banco-dados");
        }
    }
}