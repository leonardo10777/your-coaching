package YourCoaching.dao;

import YourCoaching.config.ConnectionPoolConfig;
import YourCoaching.model.Agendamento;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AgendamentoDao {

    public void createAgendamento(Agendamento agendamento) {
        String SQL = "INSERT INTO AGENDAMENTO (USUARIO_ID, COACH_ID, DATA, HORARIO) VALUES (?, ?, ?, ?)";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setInt(1, agendamento.getUsuarioId());
            preparedStatement.setInt(2, agendamento.getCoachId());
            preparedStatement.setDate(3, Date.valueOf(agendamento.getData()));
            preparedStatement.setTime(4, Time.valueOf(agendamento.getHorario()));

            preparedStatement.executeUpdate();

            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    agendamento.setId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            System.out.println("Erro ao criar agendamento: " + e.getMessage());
            throw new RuntimeException("Erro ao criar agendamento", e);
        }
    }

    public List<Agendamento> findAgendamentosByUsuarioId(int usuarioId) {
        String SQL = "SELECT * FROM AGENDAMENTO WHERE USUARIO_ID = ? ORDER BY DATA, HORARIO";
        List<Agendamento> agendamentos = new ArrayList<>();

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, usuarioId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    agendamentos.add(mapResultSetToAgendamento(resultSet));
                }
            }
        } catch (SQLException e) {
            System.out.println("Erro ao buscar agendamentos por usuário: " + e.getMessage());
            throw new RuntimeException("Erro ao buscar agendamentos", e);
        }
        return agendamentos;
    }

    public List<Agendamento> findAgendamentosByCoachId(int coachId) {
        String SQL = "SELECT * FROM AGENDAMENTO WHERE COACH_ID = ? ORDER BY DATA, HORARIO";
        List<Agendamento> agendamentos = new ArrayList<>();

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, coachId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    agendamentos.add(mapResultSetToAgendamento(resultSet));
                }
            }
        } catch (SQLException e) {
            System.out.println("Erro ao buscar agendamentos por coach: " + e.getMessage());
            throw new RuntimeException("Erro ao buscar agendamentos", e);
        }
        return agendamentos;
    }

    public boolean isHorarioDisponivel(int coachId, Date data, Time horario) {
        String SQL = "SELECT COUNT(*) FROM AGENDAMENTO WHERE COACH_ID = ? AND DATA = ? AND HORARIO = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, coachId);
            preparedStatement.setDate(2, data);
            preparedStatement.setTime(3, horario);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1) == 0;
                }
            }
        } catch (SQLException e) {
            System.out.println("Erro ao verificar disponibilidade: " + e.getMessage());
            throw new RuntimeException("Erro ao verificar disponibilidade", e);
        }
        return false;
    }

    public void deleteAgendamento(int id) {
        String SQL = "DELETE FROM AGENDAMENTO WHERE ID = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Erro ao deletar agendamento: " + e.getMessage());
            throw new RuntimeException("Erro ao deletar agendamento", e);
        }
    }

    private Agendamento mapResultSetToAgendamento(ResultSet rs) throws SQLException {
        return new Agendamento(
                rs.getInt("ID"),
                rs.getInt("USUARIO_ID"),
                rs.getInt("COACH_ID"),
                rs.getDate("DATA").toLocalDate(),
                rs.getTime("HORARIO").toLocalTime()
        );
    }

    public void createTableIfNotExists() {
        String SQL = "CREATE TABLE IF NOT EXISTS AGENDAMENTO (" +
                "ID INT AUTO_INCREMENT PRIMARY KEY, " +
                "USUARIO_ID INT NOT NULL, " +
                "COACH_ID INT NOT NULL, " +
                "DATA DATE NOT NULL, " +
                "HORARIO TIME NOT NULL, " +
                "FOREIGN KEY (USUARIO_ID) REFERENCES USUARIO(ID), " +
                "FOREIGN KEY (COACH_ID) REFERENCES COACH(ID))";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             Statement stmt = connection.createStatement()) {
            stmt.execute(SQL);
            System.out.println("Tabela AGENDAMENTO criada ou já existente");
        } catch (SQLException e) {
            System.out.println("Erro ao criar tabela AGENDAMENTO: " + e.getMessage());
            throw new RuntimeException("Erro ao criar tabela", e);
        }
    }
}