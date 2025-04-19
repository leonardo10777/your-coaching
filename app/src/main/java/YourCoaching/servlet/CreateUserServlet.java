package YourCoaching.servlet;

import YourCoaching.dao.UsuarioDao;
import YourCoaching.model.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet("/create-user")
public class CreateUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Obter parâmetros
            String nome = request.getParameter("reg-name");
            String email = request.getParameter("reg-email");
            String telefone = request.getParameter("reg-telefone");
            String senha = request.getParameter("reg-password");
            LocalDate dataNascimento = LocalDate.parse(request.getParameter("reg-nascimento"));

            // 2. Validar campos
            if (nome == null || nome.isEmpty() ||
                    email == null || !email.contains("@") ||
                    senha == null || senha.length() < 8) {
                response.sendRedirect("index.html?erro=validacao");
                return;
            }

            // 3. Criar objeto Usuario
            Usuario usuario = new Usuario(nome, email, telefone, senha, dataNascimento);

            // 4. Persistir no banco
            UsuarioDao usuarioDao = new UsuarioDao();
            usuarioDao.createUsuario(usuario);

            // 5. Redirecionar
            response.sendRedirect("index.html?sucesso=cadastro");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.html?erro=banco-dados");
        }
    }
}