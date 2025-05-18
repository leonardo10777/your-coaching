<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Coaches</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4CAF50;
            --secondary-color: #f44336;
            --info-color: #2196F3;
            --hover-primary: #45a049;
            --hover-secondary: #d32f2f;
            --hover-info: #0b7dda;
            --text-color: #333;
            --light-gray: #f5f5f5;
            --white: #fff;
            --border-color: #ddd;
            --shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-gray);
            margin: 0;
            padding: 20px;
            color: var(--text-color);
        }

        .data-container {
            max-width: 1200px;
            margin: 30px auto;
            background: var(--white);
            border-radius: 8px;
            box-shadow: var(--shadow);
            padding: 30px;
        }

        h1 {
            color: var(--primary-color);
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.2rem;
        }

        .table-container {
            overflow-x: auto;
            margin: 20px 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.95rem;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        th {
            background-color: var(--primary-color);
            color: var(--white);
            position: sticky;
            top: 0;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 8px 15px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            font-size: 0.9rem;
        }

        .btn-edit {
            background-color: var(--info-color);
            color: var(--white);
        }

        .btn-edit:hover {
            background-color: var(--hover-info);
        }

        .btn-delete {
            background-color: var(--secondary-color);
            color: var(--white);
            border: none;
            cursor: pointer;
        }

        .btn-delete:hover {
            background-color: var(--hover-secondary);
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            margin-top: 25px;
            padding: 10px 20px;
            background-color: var(--primary-color);
            color: var(--white);
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .btn-back:hover {
            background-color: var(--hover-primary);
        }

        .status-message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .success {
            background-color: #dff0d8;
            color: #3c763d;
            border-left: 4px solid #3c763d;
        }

        .error {
            background-color: #f2dede;
            color: #a94442;
            border-left: 4px solid #a94442;
        }

        .icon {
            margin-right: 8px;
        }

        .empty-message {
            text-align: center;
            padding: 20px;
            color: #666;
            font-style: italic;
            background-color: #f8f9fa;
            border-radius: 4px;
            margin: 20px 0;
        }

        @media (max-width: 768px) {
            .data-container {
                padding: 15px;
            }

            th, td {
                padding: 10px 5px;
                font-size: 0.85rem;
            }

            .action-buttons {
                flex-direction: column;
                gap: 5px;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="data-container">
        <h1><i class="fas fa-users icon"></i>Lista de Coaches</h1>

        <%-- Mensagens de status --%>
        <c:if test="${not empty param.success}">
            <div class="status-message success">
                <i class="fas fa-check-circle icon"></i>
                <c:choose>
                    <c:when test="${param.success == 'updated'}">Coach atualizado com sucesso!</c:when>
                    <c:when test="${param.success == 'deleted'}">Coach removido com sucesso!</c:when>
                    <c:when test="${param.success == 'created'}">Coach cadastrado com sucesso!</c:when>
                </c:choose>
            </div>
        </c:if>

        <c:if test="${not empty param.error}">
            <div class="status-message error">
                <i class="fas fa-exclamation-circle icon"></i>
                <c:choose>
                    <c:when test="${param.error == 'not_found'}">Coach não encontrado</c:when>
                    <c:when test="${param.error == 'load_error'}">Erro ao carregar dados</c:when>
                    <c:when test="${param.error == 'delete_error'}">Erro ao excluir coach</c:when>
                </c:choose>
            </div>
        </c:if>

        <c:if test="${not empty emptyMessage}">
            <div class="empty-message">
                <i class="fas fa-info-circle icon"></i> ${emptyMessage}
            </div>
        </c:if>

        <c:if test="${not empty coaches}">
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nome</th>
                            <th>Email</th>
                            <th>Telefone</th>
                            <th>Curso</th>
                            <th>Área</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="coach" items="${coaches}">
                            <tr>
                                <td>${coach.id}</td>
                                <td>${coach.nome}</td>
                                <td>${coach.email}</td>
                                <td class="phone-number">${coach.telefone}</td>
                                <td>${coach.curso}</td>
                                <td>${coach.area}</td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="${pageContext.request.contextPath}/edit-coach?id=${coach.id}" class="btn btn-edit">
                                            <i class="fas fa-edit icon"></i> Editar
                                        </a>
                                        <form action="${pageContext.request.contextPath}/delete-coach" method="post"
                                              onsubmit="return confirm('Tem certeza que deseja excluir este coach?');"
                                              style="display:inline;">
                                            <input type="hidden" name="id" value="${coach.id}">
                                            <button type="submit" class="btn btn-delete">
                                                <i class="fas fa-trash-alt icon"></i> Excluir
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <a href="index.html" class="btn btn-back">
            <i class="fas fa-arrow-left icon"></i> Voltar para Home
        </a>
    </div>

    <script>
        // Aplicar máscara de telefone
        document.querySelectorAll('.phone-number').forEach(td => {
            const phone = td.textContent.trim();
            if (phone) {
                const cleaned = phone.replace(/\D/g, '');
                if (cleaned.length === 11) {
                    td.textContent = cleaned.replace(/^(\d{2})(\d{5})(\d{4})$/, "($1) $2-$3");
                } else if (cleaned.length === 10) {
                    td.textContent = cleaned.replace(/^(\d{2})(\d{4})(\d{4})$/, "($1) $2-$3");
                }
            }
        });

        // Confirmar exclusão
        document.querySelectorAll('.btn-delete').forEach(btn => {
            btn.addEventListener('click', function(e) {
                if (!confirm('Tem certeza que deseja excluir este coach permanentemente?')) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
</html>