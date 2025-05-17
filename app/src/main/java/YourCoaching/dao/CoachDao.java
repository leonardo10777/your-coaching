package YourCoaching.dao;

import YourCoaching.model.Coach;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CoachDao {
    private static final String JDBC_URL = "jdbc:h2:~/test";
    private static final String JDBC_USER = "sa";
    private static final String JDBC_PASSWORD = "sa";

    public void createCoach(Coach coach) {
        String SQL = "INSERT INTO COACH (NOME, EMAIL, TELEFONE, SENHA, DATA_NASCIMENTO, CURSO, AREA, DESCRICAOPROFISSIONAL, PRECO) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {

            setCoachParameters(preparedStatement, coach);
            preparedStatement.executeUpdate();

            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    coach.setId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error creating coach", e);
        }
    }

    public List<Coach> findAllCoaches() {
        String SQL = "SELECT * FROM COACH";
        List<Coach> coaches = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(SQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                coaches.add(mapResultSetToCoach(resultSet));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error finding all coaches", e);
        }
        return coaches;
    }

    public Coach findCoachById(int id) {
        String SQL = "SELECT * FROM COACH WHERE ID = ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, id);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToCoach(resultSet);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error finding coach by ID", e);
        }
        return null;
    }

    public void updateCoach(Coach coach) {
        String SQL = "UPDATE COACH SET NOME = ?, EMAIL = ?, TELEFONE = ?, SENHA = ?, DATA_NASCIMENTO = ?, " +
                "CURSO = ?, AREA = ?, DESCRICAOPROFISSIONAL = ?, PRECO = ? WHERE ID = ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            setCoachParameters(preparedStatement, coach);
            preparedStatement.setInt(10, coach.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error updating coach", e);
        }
    }

    public void deleteCoachById(int id) {
        String SQL = "DELETE FROM COACH WHERE ID = ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting coach", e);
        }
    }

    // Helper methods
    private void setCoachParameters(PreparedStatement ps, Coach coach) throws SQLException {
        ps.setString(1, coach.getNome());
        ps.setString(2, coach.getEmail());
        ps.setString(3, coach.getTelefone());
        ps.setString(4, coach.getSenha());
        ps.setDate(5, Date.valueOf(coach.getDataNascimento()));
        ps.setString(6, coach.getCurso());
        ps.setString(7, coach.getArea());
        ps.setString(8, coach.getDescricaoprofissional());
        ps.setString(9, coach.getPreco());
    }

    private Coach mapResultSetToCoach(ResultSet rs) throws SQLException {
        return new Coach(
                rs.getInt("ID"),
                rs.getString("NOME"),
                rs.getString("EMAIL"),
                rs.getString("TELEFONE"),
                rs.getString("SENHA"),
                rs.getDate("DATA_NASCIMENTO").toLocalDate(),
                rs.getString("CURSO"),
                rs.getString("AREA"),
                rs.getString("DESCRICAOPROFISSIONAL"),
                rs.getString("PRECO")
        );
    }
}