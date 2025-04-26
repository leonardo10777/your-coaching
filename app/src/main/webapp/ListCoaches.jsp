<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lista Completa de Coaches</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .data-container {
            margin: 20px;
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 0.9em;
            min-width: 800px;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
            position: sticky;
            top: 0;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .btn {
            display: inline-block;
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="data-container">
        <h1>Lista Completa de Coaches</h1>
        <table>
            <thead>
                <tr>
                    <th>Nome</th>
                    <th>Email</th>
                    <th>Telefone</th>
                    <th>Data Nascimento</th>
                    <th>Curso</th>
                    <th>Área</th>
                    <th>Descrição Profissional</th>
                    <th>Preço</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="coach" items="${coaches}">
                    <tr>
                        <td>${coach.nome}</td>
                        <td>${coach.email}</td>
                        <td>${coach.telefone}</td>
                        <td>${coach.dataNascimento}</td>
                        <td>${coach.curso}</td>
                        <td>${coach.area}</td>
                        <td>${coach.descricaoprofissional}</td>
                        <td>${coach.preco}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="index.html" class="btn">Voltar para Home</a>
    </div>
</body>
</html>