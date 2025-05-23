<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meus Agendamentos | Your Coaching</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px 20px;
        }

        .page-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .page-header h1 {
            color: #333;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }

        .page-header p {
            color: #666;
            font-size: 1.1rem;
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: 500;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .agendamentos-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .agendamentos-header {
            background: linear-gradient(135deg, var(--primary-color), #218838);
            color: white;
            padding: 20px;
            text-align: center;
        }

        .agendamentos-header h2 {
            margin: 0;
            font-size: 1.5rem;
        }

        .agendamentos-list {
            padding: 0;
        }

        .agendamento-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px;
            border-bottom: 1px solid #e9ecef;
            transition: background-color 0.3s ease;
        }

        .agendamento-item:hover {
            background-color: #f8f9fa;
        }

        .agendamento-item:last-child {
            border-bottom: none;
        }

        .agendamento-info {
            display: flex;
            align-items: center;
            gap: 20px;
            flex: 1;
        }

        .agendamento-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--primary-color), #218838);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
        }

        .agendamento-details {
            flex: 1;
        }

        .agendamento-coach {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }

        .agendamento-datetime {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .datetime-item {
            display: flex;
            align-items: center;
            gap: 5px;
            color: #666;
            font-size: 0.95rem;
        }

        .datetime-item i {
            color: var(--primary-color);
        }

        .agendamento-actions {
            display: flex;
            gap: 10px;
        }

        .btn-cancel {
            background: #dc3545;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background-color 0.3s ease;
        }

        .btn-cancel:hover {
            background: #c82333;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .empty-state i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 20px;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #333;
        }

        .empty-state p {
            font-size: 1.1rem;
            margin-bottom: 30px;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 600;
            transition: background-color 0.3s ease;
            display: inline-block;
        }

        .btn-primary:hover {
            background: #218838;
            text-decoration: none;
            color: white;
        }

        .agendamentos-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 5px;
        }

        .stat-label {
            color: #666;
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            .agendamento-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .agendamento-info {
                width: 100%;
            }

            .agendamento-datetime {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }

            .agendamentos-stats {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<header>
    <div class="container">
        <div class="header-content">
            <a href="index.html" class="logo">
                <img src="${pageContext.request.contextPath}/img/logo.png" alt="Your Coaching" class="logo-img">
                <h1>Your Coaching</h1>
            </a>

            <nav class="main-nav">
                <ul>
                    <li><a href="dashboard-usuario.html"><i class="fas fa-home"></i> Dashboard</a></li>
                    <li><a href="buscar-coaches.html"><i class="fas fa-search"></i> Buscar Coaches</a></li>
                    <li><a href="meus-agendamentos" class="active"><i class="fas fa-calendar"></i> Meus Agendamentos</a></li>
                </ul>
            </nav>

            <a href="logout" class="btn btn-outline">Sair</a>
        </div>
    </div>
</header>

<main class="main-content">
    <div class="page-header">
        <h1><i class="fas fa-calendar-alt"></i> Meus Agendamentos</h1>
        <p>Gerencie suas consultas de coaching agendadas</p>
    </div>

    <!-- Mensagens de sucesso ou erro -->
    <c:if test="${not empty sessionScope.mensagemSucesso}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> ${sessionScope.mensagemSucesso}
        </div>
        <c:remove var="mensagemSucesso" scope="session" />
    </c:if>

    <c:if test="${not empty sessionScope.mensagemErro}">
        <div class="alert alert-error">
            <i class="fas fa-exclamation-triangle"></i> ${sessionScope.mensagemErro}
        </div>
        <c:remove var="mensagemErro" scope="session" />
    </c:if>

    <!-- Estatísticas -->
    <div class="agendamentos-stats">
        <div class="stat-card">
            <div class="stat-number">${agendamentos.size()}</div>
            <div class="stat-label">Total de Agendamentos</div>
        </div>
    </div>

    <!-- Lista de Agendamentos -->
    <div class="agendamentos-container">
        <div class="agendamentos-header">
            <h2><i class="fas fa-list"></i> Suas Consultas Agendadas</h2>
        </div>

        <div class="agendamentos-list">
            <c:choose>
                <c:when test="${not empty agendamentos}">
                    <c:forEach var="agendamento" items="${agendamentos}">
                        <div class="agendamento-item">
                            <div class="agendamento-info">
                                <div class="agendamento-icon">
                                    <i class="fas fa-user-tie"></i>
                                </div>
                                <div class="agendamento-details">
                                    <div class="agendamento-coach">${agendamento.nomeCoach}</div>
                                    <div class="agendamento-datetime">
                                        <div class="datetime-item">
                                            <i class="fas fa-calendar"></i>
                                            <span>
                                                <fmt:parseDate value="${agendamento.data}" pattern="yyyy-MM-dd" var="parsedDate" type="date" />
                                                <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                                            </span>
                                        </div>
                                        <div class="datetime-item">
                                            <i class="fas fa-clock"></i>
                                            <span>${agendamento.horario}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="agendamento-actions">
                                <form method="post" style="display: inline;" 
                                      onsubmit="return confirm('Tem certeza que deseja cancelar este agendamento?')">
                                    <input type="hidden" name="action" value="cancelar">
                                    <input type="hidden" name="agendamentoId" value="${agendamento.id}">
                                    <button type="submit" class="btn-cancel">
                                        <i class="fas fa-times"></i> Cancelar
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-calendar-times"></i>
                        <h3>Nenhum agendamento encontrado</h3>
                        <p>Você ainda não possui consultas agendadas.</p>
                        <a href="buscar-coaches.html" class="btn-primary">
                            <i class="fas fa-search"></i> Buscar Coaches
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</main>

<footer>
    <div class="container">
        <div class="footer-bottom">
            <p>&copy; 2023 Your Coaching. Todos os direitos reservados.</p>
        </div>
    </div>
</footer>

<script>
    // Auto-hide alerts após 5 segundos
    document.addEventListener('DOMContentLoaded', function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            setTimeout(() => {
                alert.style.transition = 'opacity 0.5s ease';
                alert.style.opacity = '0';
                setTimeout(() => {
                    alert.remove();
                }, 500);
            }, 5000);
        });
    });
</script>
</body>
</html>