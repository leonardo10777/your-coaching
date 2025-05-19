package YourCoaching.dao;

import YourCoaching.config.ConnectionPoolConfig;
import YourCoaching.model.Feedback;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDao {

    public void createFeedback(Feedback feedback) {
        String SQL = "INSERT INTO FEEDBACK (COACH_ID, USUARIO_ID, USUARIO_NOME, COMENTARIO) VALUES (?, ?, ?, ?)";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setInt(1, feedback.getCoachId());
            preparedStatement.setInt(2, feedback.getUsuarioId());
            preparedStatement.setString(3, feedback.getUsuarioNome());
            preparedStatement.setString(4, feedback.getComentario());

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Falha ao criar feedback, nenhuma linha afetada.");
            }

            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    feedback.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Falha ao criar feedback, nenhum ID obtido.");
                }
            }
        } catch (SQLException e) {
            System.out.println("Erro ao criar feedback: " + e.getMessage());
            throw new RuntimeException("Error creating feedback", e);
        }
    }

    public List<Feedback> findFeedbacksByCoachId(int coachId) {
        String SQL = "SELECT f.*, u.NOME as USUARIO_NOME FROM FEEDBACK f " +
                "JOIN USUARIO u ON f.USUARIO_ID = u.ID " +
                "WHERE f.COACH_ID = ? ORDER BY f.ID DESC";
        List<Feedback> feedbacks = new ArrayList<>();

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, coachId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    feedbacks.add(mapResultSetToFeedback(resultSet));
                }
            }
        } catch (SQLException e) {
            System.out.println("Erro ao buscar feedbacks: " + e.getMessage());
            throw new RuntimeException("Error finding feedbacks", e);
        }
        return feedbacks;
    }

    public List<Feedback> findAllFeedbacks() {
        String SQL = "SELECT f.*, u.NOME as USUARIO_NOME, c.NOME as COACH_NOME " +
                "FROM FEEDBACK f " +
                "JOIN USUARIO u ON f.USUARIO_ID = u.ID " +
                "JOIN COACH c ON f.COACH_ID = c.ID " +
                "ORDER BY f.ID DESC";
        List<Feedback> feedbacks = new ArrayList<>();

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Feedback feedback = mapResultSetToFeedback(resultSet);
                feedback.setCoachNome(resultSet.getString("COACH_NOME"));
                feedbacks.add(feedback);
            }
        } catch (SQLException e) {
            System.out.println("Erro ao buscar todos os feedbacks: " + e.getMessage());
            throw new RuntimeException("Error finding all feedbacks", e);
        }
        return feedbacks;
    }

    public void deleteFeedbackById(int id) {
        String SQL = "DELETE FROM FEEDBACK WHERE ID = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Erro ao deletar feedback: " + e.getMessage());
            throw new RuntimeException("Error deleting feedback", e);
        }
    }

    private Feedback mapResultSetToFeedback(ResultSet rs) throws SQLException {
        Feedback feedback = new Feedback(
                rs.getInt("ID"),
                rs.getInt("COACH_ID"),
                rs.getInt("USUARIO_ID"),
                rs.getString("USUARIO_NOME"),
                rs.getString("COMENTARIO")
        );

        try {
            feedback.setCoachNome(rs.getString("COACH_NOME"));
        } catch (SQLException e) {
            // Ignora se a coluna não existir
        }

        return feedback;
    }
}