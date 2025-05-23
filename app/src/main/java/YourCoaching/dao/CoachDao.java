package YourCoaching.dao;

import YourCoaching.config.ConnectionPoolConfig;
import YourCoaching.model.Coach;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CoachDao {

    public void createCoach(Coach coach) {
        String SQL = "INSERT INTO COACH (NOME, EMAIL, TELEFONE, SENHA, DATA_NASCIMENTO, CURSO, AREA, DESCRICAOPROFISSIONAL, PRECO, IMAGE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {

            setCoachParameters(preparedStatement, coach);
            preparedStatement.executeUpdate();

            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    coach.setId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            System.out.println("Erro ao criar coach: " + e.getMessage());
            throw new RuntimeException("Error creating coach", e);
        }
    }

    public List<Coach> findAllCoaches() {
        String SQL = "SELECT * FROM COACH";
        List<Coach> coaches = new ArrayList<>();

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                coaches.add(mapResultSetToCoach(resultSet));
            }
        } catch (SQLException e) {
            System.out.println("Erro ao buscar coaches: " + e.getMessage());
            throw new RuntimeException("Error finding all coaches", e);
        }
        return coaches;
    }

    public Coach findCoachById(int id) {
        String SQL = "SELECT * FROM COACH WHERE ID = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, id);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToCoach(resultSet);
                }
            }
        } catch (SQLException e) {
            System.out.println("Erro ao buscar coach por ID: " + e.getMessage());
            throw new RuntimeException("Error finding coach by ID", e);
        }
        return null;
    }

    public void updateCoach(Coach coach) {
        String SQL = "UPDATE COACH SET NOME = ?, EMAIL = ?, TELEFONE = ?, SENHA = ?, DATA_NASCIMENTO = ?, " +
                "CURSO = ?, AREA = ?, DESCRICAOPROFISSIONAL = ?, PRECO = ?, IMAGE = ? WHERE ID = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            setCoachParameters(preparedStatement, coach);
            preparedStatement.setInt(11, coach.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Erro ao atualizar coach: " + e.getMessage());
            throw new RuntimeException("Error updating coach", e);
        }
    }

    public void deleteCoachById(int id) {
        String SQL = "DELETE FROM COACH WHERE ID = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Erro ao deletar coach: " + e.getMessage());
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
        ps.setString(10, coach.getImage());
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
                rs.getString("PRECO"),
                rs.getString("IMAGE")
        );
    }

    public Coach findCoachByEmailAndSenha(String email, String senha) {
        String SQL = "SELECT * FROM COACH WHERE EMAIL = ? AND SENHA = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, email);
            preparedStatement.setString(2, senha);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToCoach(resultSet);
                }
            }
        } catch (SQLException e) {
            System.out.println("Erro ao buscar coach por email/senha: " + e.getMessage());
            throw new RuntimeException("Error finding coach by email and password", e);
        }
        return null;
    }

    public Coach findById(int id) {
        return findCoachById(id); // Reutiliza o método existente
    }

    public void createTableIfNotExists() {
        String SQL = "CREATE TABLE IF NOT EXISTS COACH (" +
                "ID INT AUTO_INCREMENT PRIMARY KEY, " +
                "NOME VARCHAR(100) NOT NULL, " +
                "EMAIL VARCHAR(100) NOT NULL UNIQUE, " +
                "TELEFONE VARCHAR(20) NOT NULL, " +
                "SENHA VARCHAR(100) NOT NULL, " +
                "DATA_NASCIMENTO DATE NOT NULL, " +
                "CURSO VARCHAR(100) NOT NULL, " +
                "AREA VARCHAR(100) NOT NULL, " +
                "DESCRICAOPROFISSIONAL VARCHAR(500) NOT NULL, " +
                "PRECO VARCHAR(20) NOT NULL, " +
                "IMAGE VARCHAR(250) NOT NULL)";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             Statement stmt = connection.createStatement()) {
            stmt.execute(SQL);
            System.out.println("Tabela COACH criada ou já existente");
        } catch (SQLException e) {
            System.out.println("Erro ao criar tabela COACH: " + e.getMessage());
            throw new RuntimeException("Erro ao criar tabela", e);
        }
    }
}