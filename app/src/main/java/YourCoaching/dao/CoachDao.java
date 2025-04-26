package YourCoaching.dao;

import YourCoaching.model.Coach;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
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
}