<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${sessionScope.tipoUsuario != 'coach'}">
  <c:redirect url="/login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard do Coach | Your Coaching</title>

  <link rel="stylesheet" href="css/style.css">
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    .dashboard-container {
      padding: 40px 0;
    }
    .welcome-message {
      text-align: center;
      margin-bottom: 40px;
    }
    .stats-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 20px;
      margin-bottom: 40px;
    }
    .stat-card {
      background: #fff;
      border-radius: 10px;
      padding: 20px;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      text-align: center;
    }
    .stat-value {
      font-size: 2.5rem;
      font-weight: 700;
      color: var(--primary-color);
      margin: 10px 0;
    }
    .stat-label {
      color: var(--text-light);
    }
    .upcoming-sessions {
      background: #fff;
      border-radius: 10px;
      padding: 20px;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      margin-bottom: 30px;
    }
    .session-item {
      padding: 15px 0;
      border-bottom: 1px solid var(--border-color);
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .session-item:last-child {
      border-bottom: none;
    }
    .session-time {
      font-weight: 600;
      color: #333;
    }
    .session-client {
      color: var(--text-light);
      margin-top: 5px;
    }
    .session-info {
      flex: 1;
    }
    .btn-start-session {
      padding: 8px 15px;
      background-color: var(--primary-color);
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    .btn-start-session:hover {
      background-color: #218838;
    }
    .recent-feedbacks {
      background: #fff;
      border-radius: 10px;
      padding: 20px;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }
    .feedback-item {
      padding: 15px 0;
      border-bottom: 1px solid var(--border-color);
    }
    .feedback-item:last-child {
      border-bottom: none;
    }
    .feedback-rating {
      color: #ffd700;
      font-size: 1.2rem;
      margin-bottom: 5px;
    }
    .feedback-text {
      font-style: italic;
      margin-bottom: 5px;
    }
    .feedback-client {
      color: var(--text-light);
      font-size: 0.9rem;
    }
    .empty-sessions {
      text-align: center;
      padding: 40px 20px;
      color: var(--text-light);
    }
    .empty-sessions i {
      font-size: 3rem;
      color: #ddd;
      margin-bottom: 15px;
    }
    .empty-sessions h3 {
      margin-bottom: 10px;
      color: #666;
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
    @media (max-width: 768px) {
      .stats-grid {
        grid-template-columns: 1fr;
      }
      .session-item {
        flex-direction: column;
        align-items: flex-start;
        gap: 10px;
      }
    }
  </style>
</head>
<body>
<header>
  <div class="container">
    <div class="header-content">
      <a href="index.html" class="logo">
        <img src="img/logo.png" alt="Your Coaching" class="logo-img">
        <h1>Your Coaching</h1>
      </a>

      <nav class="main-nav">
        <ul>
          <li><a href="dashboard-coach" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
          <li><a href="perfil-coach?coachId=${sessionScope.coachId}"><i class="fas fa-user"></i> Meu Perfil</a></li>
        </ul>
      </nav>

      <a href="logout" class="btn btn-outline">Sair</a>
    </div>
  </div>
</header>

<main class="container">
  <section class="dashboard-container">
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

    <div class="welcome-message">
      <h1>Bem-vindo, ${sessionScope.coachNome}!</h1>
      <p>Veja suas estatísticas e próximas sessões</p>
    </div>

    <div class="stats-grid">
      <div class="stat-card">
        <i class="fas fa-calendar-alt fa-2x"></i>
        <div class="stat-value">${agendamentos.size()}</div>
        <div class="stat-label">Sessões Agendadas</div>
      </div>
      <div class="stat-card">
        <i class="fas fa-users fa-2x"></i>
        <div class="stat-value">
          <c:set var="clientesUnicos" value="${0}" />
          <c:set var="usuariosVistos" value="" />
          <c:forEach var="agendamento" items="${agendamentos}">
            <c:if test="${not fn:contains(usuariosVistos, agendamento.usuarioId)}">
              <c:set var="clientesUnicos" value="${clientesUnicos + 1}" />
              <c:set var="usuariosVistos" value="${usuariosVistos}${agendamento.usuarioId}," />
            </c:if>
          </c:forEach>
          ${clientesUnicos}
        </div>
        <div class="stat-label">Clientes Únicos</div>
      </div>
      <div class="stat-card">
        <i class="fas fa-star fa-2x"></i>
        <div class="stat-value">4.9</div>
        <div class="stat-label">Avaliação Média</div>
      </div>
    </div>

    <div class="upcoming-sessions">
      <h2><i class="fas fa-calendar-check"></i> Próximas Sessões</h2>

      <c:choose>
        <c:when test="${not empty agendamentos}">
          <c:forEach var="agendamento" items="${agendamentos}" varStatus="status">
            <c:if test="${status.index < 5}"> <!-- Mostrar apenas as próximas 5 sessões -->
              <div class="session-item">
                <div class="session-info">
                  <div class="session-time">
                    <i class="fas fa-calendar"></i>
                    <fmt:parseDate value="${agendamento.data}" pattern="yyyy-MM-dd" var="parsedDate" type="date" />
                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                    às ${agendamento.horario}
                  </div>
                  <div class="session-client">
                    <i class="fas fa-user"></i> Com: ${agendamento.nomeUsuario}
                  </div>
                </div>
              </div>
            </c:if>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="empty-sessions">
            <i class="fas fa-calendar-times"></i>
            <h3>Nenhuma sessão agendada</h3>
            <p>Você ainda não possui sessões agendadas com clientes.</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

  </section>
</main>

<footer>
  <div class="container">
    <div class="footer-bottom">
      <p>&copy; 2023 Your Coaching. Todos os direitos reservados.</p>
    </div>
  </div>
</footer>

<script src="js/script.js"></script>
<script>
  function iniciarSessao(agendamentoId) {
    alert('Funcionalidade de iniciar sessão em desenvolvimento. ID do agendamento: ' + agendamentoId);
    // Aqui você pode implementar a lógica para iniciar uma sessão
  }

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