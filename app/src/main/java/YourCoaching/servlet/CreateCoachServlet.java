package YourCoaching.servlet;

import YourCoaching.dao.CoachDao;
import YourCoaching.model.Coach;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import static org.apache.commons.fileupload.servlet.ServletFileUpload.isMultipartContent;

@WebServlet("/create-coach")
public class CreateCoachServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("Recebendo requisição para cadastrar coach...");
        Map<String, String> parameters = uploadImage(request);

        try {
            // Obter parâmetros
            String nome = parameters.get("coach-nome");
            String email = parameters.get("coach-email");
            String telefone = parameters.get("coach-telefone");
            String senha = parameters.get("coach-password");
            LocalDate dataNascimento = LocalDate.parse(parameters.get("coach-nascimento"));
            String curso = parameters.get("coach-curso");
            String area = parameters.get("coach-area");
            String descricao = parameters.get("coach-desc");
            String preco = parameters.get("coach-preco");
            String image = parameters.get("image");

            // Validação
            if (image == null || image.isEmpty()) {
                image = "img/default-coach.jpg";
            }

            System.out.println("Parâmetros recebidos:");
            System.out.println("Nome: " + nome);
            System.out.println("Email: " + email);
            System.out.println("Telefone: " + telefone);
            System.out.println("Data Nascimento: " + dataNascimento);
            System.out.println("Curso: " + curso);
            System.out.println("Área: " + area);
            System.out.println("Descrição: " + descricao);
            System.out.println("Preço: " + preco);
            System.out.println("Imagem: " + image);

            // Validação básica
            if (nome == null || nome.isEmpty() || email == null || !email.contains("@")) {
                System.out.println("Validação falhou para nome ou email");
                response.sendRedirect("index.html?erro=validacao");
                return;
            }

            // Criar e persistir coach
            Coach coach = new Coach(nome, email, telefone, senha, dataNascimento,
                    curso, area, descricao, preco, image);

            System.out.println("Criando coach no banco de dados...");
            new CoachDao().createCoach(coach);
            System.out.println("Coach criado com sucesso!");

            response.sendRedirect("index.html?sucesso=cadastro");

        } catch (Exception e) {
            System.out.println("Erro ao cadastrar coach:");
            e.printStackTrace();
            response.sendRedirect("index.html?erro=banco-dados");
        }
    }

    private Map<String, String> uploadImage(HttpServletRequest httpServletRequest) {
        HashMap<String, String> parameters = new HashMap<>();

        if (isMultipartContent(httpServletRequest)) {
            try {
                DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
                List<FileItem> fileItems = new ServletFileUpload(diskFileItemFactory).parseRequest(httpServletRequest);

                for (FileItem item : fileItems) {
                    checkFieldType(item, parameters);
                }

            } catch (Exception e) {
                System.out.println("Erro ao processar upload de imagem: " + e.getMessage());
                parameters.put("image", "img/default-coach.jpg");
            }
        } else {
            System.out.println("Requisição não é multipart");
        }

        return parameters;
    }

    private void checkFieldType(FileItem fileItem, Map<String, String> requestParameters) throws Exception {
        if (fileItem.isFormField()) {
            requestParameters.put(fileItem.getFieldName(), fileItem.getString("UTF-8"));
        } else {
            if (fileItem.getSize() > 0) {
                String fileName = processUploadedFile(fileItem);
                requestParameters.put("image", fileName);
            }
        }
    }

    private String processUploadedFile(FileItem fileItem) throws Exception {
        Long currentTime = new Date().getTime();
        String fileName = currentTime.toString().concat("-").concat(fileItem.getName().replace(" ", ""));
        String filePath = this.getServletContext().getRealPath("img").concat(File.separator).concat(fileName);

        // Verifica se o diretório existe, se não, cria
        File uploadDir = new File(this.getServletContext().getRealPath("img"));
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        fileItem.write(new File(filePath));
        return fileName;
    }
}