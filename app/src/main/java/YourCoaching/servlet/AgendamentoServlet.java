package YourCoaching.servlet;

import YourCoaching.dao.AgendamentoDao;
import YourCoaching.dao.CoachDao;
import YourCoaching.model.Agendamento;
import YourCoaching.model.Coach;
import YourCoaching.model.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;

@WebServlet("/agendar")
public class AgendamentoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        // Verificar se o usuário está logado
        if (usuario == null) {
            session.setAttribute("mensagemErro", "Você precisa estar logado para fazer agendamentos.");
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Receber e validar dados do formulário
            String coachIdParam = request.getParameter("coachId");
            String dataParam = request.getParameter("data");
            String horarioParam = request.getParameter("horario");

            // Validações básicas
            if (coachIdParam == null || coachIdParam.trim().isEmpty()) {
                session.setAttribute("mensagemErro", "ID do coach é obrigatório.");
                response.sendRedirect("buscar-coaches.html");
                return;
            }

            if (dataParam == null || dataParam.trim().isEmpty()) {
                session.setAttribute("mensagemErro", "Data é obrigatória.");
                response.sendRedirect("perfil-coach?coachId=" + coachIdParam);
                return;
            }

            if (horarioParam == null || horarioParam.trim().isEmpty()) {
                session.setAttribute("mensagemErro", "Horário é obrigatório.");
                response.sendRedirect("perfil-coach?coachId=" + coachIdParam);
                return;
            }

            int coachId = Integer.parseInt(coachIdParam);
            LocalDate data = LocalDate.parse(dataParam);
            LocalTime horario = LocalTime.parse(horarioParam);

            // Verificar se o coach existe
            CoachDao coachDao = new CoachDao();
            Coach coach = coachDao.findCoachById(coachId);
            if (coach == null) {
                session.setAttribute("mensagemErro", "Coach não encontrado.");
                response.sendRedirect("buscar-coaches.html");
                return;
            }

            // Verificar se a data não é no passado
            if (data.isBefore(LocalDate.now())) {
                session.setAttribute("mensagemErro", "Não é possível agendar para datas passadas.");
                response.sendRedirect("perfil-coach?coachId=" + coachId);
                return;
            }

            // Verificar se a data não é muito distante (opcional - máximo 90 dias)
            if (data.isAfter(LocalDate.now().plusDays(90))) {
                session.setAttribute("mensagemErro", "Agendamentos podem ser feitos com até 90 dias de antecedência.");
                response.sendRedirect("perfil-coach?coachId=" + coachId);
                return;
            }

            // Verificar horário comercial (opcional - 8h às 19h)
            if (horario.isBefore(LocalTime.of(8, 0)) || horario.isAfter(LocalTime.of(19, 0))) {
                session.setAttribute("mensagemErro", "Horário deve estar entre 08:00 e 19:00.");
                response.sendRedirect("perfil-coach?coachId=" + coachId);
                return;
            }

            AgendamentoDao agendamentoDao = new AgendamentoDao();

            // Criar o agendamento diretamente (sem verificar disponibilidade)
            Agendamento agendamento = new Agendamento(usuario.getId(), coachId, data, horario);
            agendamentoDao.createAgendamento(agendamento);

            // Mensagem de sucesso
            session.setAttribute("mensagemSucesso",
                    String.format("Agendamento realizado com sucesso! Sessão com %s marcada para %s às %s.",
                            coach.getNome(),
                            data.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy")),
                            horario.format(java.time.format.DateTimeFormatter.ofPattern("HH:mm"))
                    ));

            response.sendRedirect("perfil-coach?coachId=" + coachId);

        } catch (NumberFormatException e) {
            session.setAttribute("mensagemErro", "Dados inválidos fornecidos.");
            response.sendRedirect("perfil-coach?coachId=" + request.getParameter("coachId"));
        } catch (DateTimeParseException e) {
            session.setAttribute("mensagemErro", "Data ou horário em formato inválido.");
            response.sendRedirect("perfil-coach?coachId=" + request.getParameter("coachId"));
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("mensagemErro", "Erro interno do servidor. Tente novamente mais tarde.");
            response.sendRedirect("perfil-coach?coachId=" + request.getParameter("coachId"));
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirecionar GET para a página de busca de coaches
        response.sendRedirect("buscar-coaches.html");
    }
}