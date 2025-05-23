<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

    <title>Lista de Usuários</title>
    <style>
        .data-container { margin: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #4CAF50; color: white; }
        tr:hover { background-color: #f5f5f5; }
        .action-buttons { display: flex; gap: 5px; }
        .btn { padding: 5px 10px; border-radius: 3px; text-decoration: none; }
        .btn-edit { background-color: #2196F3; color: white; }
        .btn-delete { background-color: #f44336; color: white; border: none; cursor: pointer; }
        .btn-primary { background-color: #4CAF50; color: white; padding: 10px 15px; margin-top: 20px; }
    </style>
</head>
<body>
    <div class="data-container">
        <h1>Usuários Cadastrados</h1>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Email</th>
                    <th>Telefone</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="usuario" items="${usuarios}">
                    <tr>
                        <td>${usuario.id}</td>
                        <td>${usuario.nome}</td>
                        <td>${usuario.email}</td>
                        <td>${usuario.telefone}</td>
                        <td>
                            <div class="action-buttons">
                                <a href="/edit-user?id=${usuario.id}" class="btn btn-edit">Editar</a>
                                <form action="/delete-user" method="post">
                                    <input type="hidden" name="id" value="${usuario.id}">
                                    <button type="submit" class="btn btn-delete">Deletar</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="admin.html" class="btn btn-primary">Voltar</a>
    </div>
</body>
</html>