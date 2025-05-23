package YourCoaching.servlet;

import YourCoaching.dao.AgendamentoDao;
import YourCoaching.dao.CoachDao;
import YourCoaching.dao.DisponibilidadeDao;
import YourCoaching.model.Agendamento;
import YourCoaching.model.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.logging.Logger;

@WebServlet("/agendar-consulta")
public class AgendarConsultaServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(AgendarConsultaServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String coachId = request.getParameter("coachId");
            if (coachId == null || coachId.isEmpty()) {
                response.sendRedirect("list-coaches-for-users?error=coach_nao_selecionado");
                return;
            }

            CoachDao coachDao = new CoachDao();
            request.setAttribute("coach", coachDao.findCoachById(Integer.parseInt(coachId)));  // Corrigido aqui

            DisponibilidadeDao disponibilidadeDao = new DisponibilidadeDao();
            request.setAttribute("horariosDisponiveis",
                    disponibilidadeDao.findAvailableTimesByDate(Integer.parseInt(coachId), LocalDate.now()));

            request.getRequestDispatcher("/WEB-INF/views/user/agendarConsulta.jsp").forward(request, response);

        } catch (Exception e) {
            logger.severe("Erro no doGet: " + e.getMessage());
            response.sendRedirect("list-coaches-for-users?error=erro_agendamento");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
            if (usuario == null) {
                response.sendRedirect("login.jsp?redirect=agendar-consulta");
                return;
            }

            int coachId = Integer.parseInt(request.getParameter("coachId"));
            LocalDateTime dataHora = LocalDateTime.parse(
                    request.getParameter("dataHora"),
                    DateTimeFormatter.ISO_LOCAL_DATE_TIME
            );
            int duracao = Integer.parseInt(request.getParameter("duracao"));
            String servico = request.getParameter("servico");
            String observacoes = request.getParameter("observacoes");

            DisponibilidadeDao disponibilidadeDao = new DisponibilidadeDao();
            if (!disponibilidadeDao.verificarDisponibilidade(coachId, dataHora, duracao)) {
                response.sendRedirect("agendar-consulta?coachId=" + coachId + "&error=horario_indisponivel");
                return;
            }

            Agendamento agendamento = new Agendamento();
            agendamento.setUsuarioId(usuario.getId());
            agendamento.setCoachId(coachId);
            agendamento.setDataHora(dataHora);
            agendamento.setDuracao(duracao);
            agendamento.setServico(servico);
            agendamento.setObservacoes(observacoes);
            agendamento.setStatus("PENDENTE");

            AgendamentoDao agendamentoDao = new AgendamentoDao();
            if (agendamentoDao.save(agendamento)) {
                response.sendRedirect("agendamentos-usuario?success=agendamento_criado");
            } else {
                response.sendRedirect("agendar-consulta?coachId=" + coachId + "&error=erro_agendamento");
            }

        } catch (NumberFormatException e) {
            logger.severe("Erro de formato numérico: " + e.getMessage());
            response.sendRedirect("agendar-consulta?error=formato_invalido");
        } catch (DateTimeParseException e) {
            logger.severe("Erro de formato de data: " + e.getMessage());
            response.sendRedirect("agendar-consulta?error=data_invalida");
        } catch (Exception e) {
            logger.severe("Erro no doPost: " + e.getMessage());
            response.sendRedirect("list-coaches-for-users?error=erro_agendamento");
        }
    }
}