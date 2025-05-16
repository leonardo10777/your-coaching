package YourCoaching.dao;

import YourCoaching.model.Coach;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CoachDao {

    public void createCoach(Coach coach) {
        String SQL = "INSERT INTO COACH (NOME, EMAIL, TELEFONE, SENHA, DATA_NASCIMENTO, CURSO, AREA, DESCRICAOPROFISSIONAL, PRECO) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
            System.out.println("Sucesso na conexão com o banco");

            PreparedStatement preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, coach.getNome());
            preparedStatement.setString(2, coach.getEmail());
            preparedStatement.setString(3, coach.getTelefone());
            preparedStatement.setString(4, coach.getSenha());
            preparedStatement.setDate(5, Date.valueOf(coach.getDataNascimento()));
            preparedStatement.setString(6, coach.getCurso());
            preparedStatement.setString(7, coach.getArea());
            preparedStatement.setString(8, coach.getDescricaoprofissional());
            preparedStatement.setString(9, coach.getPreco());

            preparedStatement.execute();
            System.out.println("Sucesso na inserção do coach");

            preparedStatement.close();
            connection.close();

        } catch (Exception e) {
            System.out.println("Falha na conexão com o banco");
            e.printStackTrace();
        }
    }

    public Coach findCoachByEmailAndSenha(String email, String senha) {
        String SQL = "SELECT * FROM COACH WHERE EMAIL = ? AND SENHA = ?";

        try {
            Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
            PreparedStatement preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, senha);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return new Coach(
                        resultSet.getInt("ID"),
                        resultSet.getString("NOME"),
                        resultSet.getString("EMAIL"),
                        resultSet.getString("TELEFONE"),
                        resultSet.getString("SENHA"),
                        resultSet.getDate("DATA_NASCIMENTO").toLocalDate(),
                        resultSet.getString("CURSO"),
                        resultSet.getString("AREA"),
                        resultSet.getString("DESCRICAOPROFISSIONAL"),
                        resultSet.getString("PRECO")
                );
            }

            resultSet.close();
            preparedStatement.close();
            connection.close();

        } catch (Exception e) {
            System.out.println("Erro ao buscar coach: " + e.getMessage());
        }

        return null;
    }

    public List<Coach> findAllCoaches() {
        String SQL = "SELECT * FROM COACH";
        List<Coach> coaches = new ArrayList<>();

        try {
            Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
            System.out.println("Sucesso na conexão com o banco");

            PreparedStatement preparedStatement = connection.prepareStatement(SQL);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Coach coach = new Coach(
                        resultSet.getInt("ID"),
                        resultSet.getString("NOME"),
                        resultSet.getString("EMAIL"),
                        resultSet.getString("TELEFONE"),
                        resultSet.getString("SENHA"),
                        resultSet.getDate("DATA_NASCIMENTO").toLocalDate(),
                        resultSet.getString("CURSO"),
                        resultSet.getString("AREA"),
                        resultSet.getString("DESCRICAOPROFISSIONAL"),
                        resultSet.getString("PRECO")
                );
                coaches.add(coach);
            }

            System.out.println("Sucesso na busca de todos os coaches");

            resultSet.close();
            preparedStatement.close();
            connection.close();

        } catch (Exception e) {
            System.out.println("Falha na conexão com o banco");
            System.out.println("Erro ao buscar coaches: " + e.getMessage());
            e.printStackTrace();
        }

        return coaches;
    }

    public void deleteCoachById(Integer coachId) {
        String SQL = "DELETE FROM COACH WHERE ID = ?";

        try {
            Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
            System.out.println("Sucesso na conexão com o banco");

            PreparedStatement preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setInt(1, coachId);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Coach deletado com sucesso! ID: " + coachId);
            } else {
                System.out.println("Nenhum Coach encontrado com o ID: " + coachId);
            }

            preparedStatement.close();
            connection.close();

        } catch (SQLException e) {
            System.out.println("Falha ao deletar usuário");
            System.out.println("Erro: " + e.getMessage());
            e.printStackTrace();
        }
    }
}