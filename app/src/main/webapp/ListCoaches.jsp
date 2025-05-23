<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Coaches | Your Coaching</title>
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

        .rating {
            color: #FFD700;
            font-weight: bold;
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

        .btn-primary {
            background-color: var(--primary-color);
            color: var(--white);
        }

        .btn-primary:hover {
            background-color: var(--hover-primary);
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
        }
    </style>
</head>
<body>
<div class="data-container">
    <h1><i class="fas fa-users icon"></i>Coaches Disponíveis</h1>

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

    <c:if test="${empty coaches}">
        <div class="empty-message">
            <i class="fas fa-info-circle icon"></i> Nenhum coach disponível no momento
        </div>
    </c:if>

    <c:if test="${not empty coaches}">
        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Área</th>
                    <th>Avaliação</th>
                    <th>Preço</th>
                    <th>Ações</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="coach" items="${coaches}">
                    <tr>
                        <td>${coach.id}</td>
                        <td>
                            <div style="display: flex; align-items: center; gap: 10px;">
                                <img src="${pageContext.request.contextPath}/img/${not empty coach.image ? coach.image : 'default-coach.jpg'}"
                                     alt="Foto do Coach"
                                     style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover;">
                                    ${coach.nome}
                            </div>
                        </td>
                        <td>${coach.area}</td>
                        <td class="rating">
                            <c:choose>
                                <c:when test="${not empty medias[coach.id] and medias[coach.id] > 0}">
                                    <fmt:formatNumber value="${medias[coach.id]}" maxFractionDigits="1"/> ★
                                    (${fn:length(feedbacks[coach.id])} avaliações)
                                </c:when>
                                <c:otherwise>
                                    Sem avaliações
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <fmt:setLocale value="pt_BR"/>
                            <fmt:formatNumber value="${coach.preco}" type="currency"/>
                        </td>
                        <td>
                            <a href="perfil-coach.jsp?coachId=${coach.id}" class="btn btn-primary">
                                <i class="fas fa-eye icon"></i> Ver Perfil
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${not empty sessionScope.usuario}">
            <a href="dashboard-usuario.jsp" class="btn btn-back">
                <i class="fas fa-arrow-left icon"></i> Voltar para Dashboard
            </a>
        </c:when>
        <c:otherwise>
            <a href="index.html" class="btn btn-back">
                <i class="fas fa-arrow-left icon"></i> Voltar para Home
            </a>
        </c:otherwise>
    </c:choose>
</div>

<script>
    // Formatar números de telefone
    document.querySelectorAll('td:nth-child(4)').forEach(td => {
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

    // Fallback para imagens
    document.addEventListener('DOMContentLoaded', function() {
        const images = document.querySelectorAll('img');
        images.forEach(img => {
            img.addEventListener('error', function() {
                this.src = '${pageContext.request.contextPath}/img/default-coach.jpg';
            });
        });
    });
</script>
</body>
</html>