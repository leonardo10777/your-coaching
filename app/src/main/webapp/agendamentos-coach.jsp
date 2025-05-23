<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Agendamentos | Your Coaching</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    .appointments-container {
      margin-top: 30px;
    }

    .appointment-tabs {
      display: flex;
      border-bottom: 1px solid #ddd;
      margin-bottom: 20px;
    }

    .tab {
      padding: 10px 20px;
      cursor: pointer;
      border-bottom: 3px solid transparent;
    }

    .tab.active {
      border-bottom-color: var(--primary-color);
      font-weight: 600;
    }

    .appointment-list {
      display: none;
    }

    .appointment-list.active {
      display: block;
    }

    .appointment-card {
      background: white;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      padding: 20px;
      margin-bottom: 15px;
      border-left: 4px solid var(--primary-color);
    }

    .appointment-header {
      display: flex;
      justify-content: space-between;
      margin-bottom: 10px;
    }

    .client-info {
      display: flex;
      align-items: center;
    }

    .client-avatar {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      overflow: hidden;
      margin-right: 15px;
    }

    .client-avatar img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .appointment-time {
      color: var(--primary-color);
      font-weight: 600;
    }

    .appointment-actions {
      display: flex;
      gap: 10px;
      margin-top: 15px;
    }

    .no-appointments {
      text-align: center;
      padding: 30px;
      color: #666;
      font-style: italic;
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
          <li><a href="dashboard-coach.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
          <li><a href="perfil-coach.jsp"><i class="fas fa-user"></i> Meu Perfil</a></li>
          <li><a href="agendamentos-coach.jsp" class="active"><i class="fas fa-calendar"></i> Agendamentos</a></li>
          <li><a href="clientes-coach.jsp"><i class="fas fa-users"></i> Meus Clientes</a></li>
        </ul>
      </nav>

      <a href="logout" class="btn btn-outline">Sair</a>
    </div>
  </div>
</header>

<main class="container">
  <section class="appointments-container">
    <h1>Meus Agendamentos</h1>

    <div class="appointment-tabs">
      <div class="tab active" data-tab="today">Hoje</div>
      <div class="tab" data-tab="upcoming">Próximos</div>
      <div class="tab" data-tab="past">Passados</div>
    </div>

    <div class="appointment-list active" id="today-appointments">
      <c:choose>
        <c:when test="${not empty agendamentosHoje}">
          <c:forEach var="agendamento" items="${agendamentosHoje}">
            <div class="appointment-card">
              <div class="appointment-header">
                <div class="client-info">
                  <div class="client-avatar">
                    <img src="${pageContext.request.contextPath}/img/${not empty agendamento.usuario.image ? agendamento.usuario.image : 'default-user.jpg'}"
                         alt="${agendamento.usuario.nome}"
                         onerror="this.src='${pageContext.request.contextPath}/img/default-user.jpg'">
                  </div>
                  <div>
                    <h3>${agendamento.usuario.nome}</h3>
                    <p>${agendamento.servico}</p>
                  </div>
                </div>
                <div class="appointment-time">
                  <fmt:formatDate value="${agendamento.dataHora}" pattern="HH:mm" />
                </div>
              </div>
              <p>${agendamento.observacoes}</p>
              <div class="appointment-actions">
                <button class="btn btn-primary start-session" data-id="${agendamento.id}">
                  <i class="fas fa-video"></i> Iniciar Sessão
                </button>
                <button class="btn btn-outline reschedule" data-id="${agendamento.id}">
                  <i class="fas fa-calendar-alt"></i> Reagendar
                </button>
              </div>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="no-appointments">
            <i class="fas fa-calendar-check fa-2x"></i>
            <p>Nenhum agendamento para hoje</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

    <div class="appointment-list" id="upcoming-appointments">
      <!-- Similar ao de hoje, mas com ${agendamentosFuturos} -->
    </div>

    <div class="appointment-list" id="past-appointments">
      <!-- Similar ao de hoje, mas com ${agendamentosPassados} -->
    </div>
  </section>
</main>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    // Tabs functionality
    const tabs = document.querySelectorAll('.tab');
    tabs.forEach(tab => {
      tab.addEventListener('click', function() {
        tabs.forEach(t => t.classList.remove('active'));
        this.classList.add('active');

        document.querySelectorAll('.appointment-list').forEach(list => {
          list.classList.remove('active');
        });

        document.getElementById(this.getAttribute('data-tab') + '-appointments').classList.add('active');
      });
    });

    // Start session button
    document.querySelectorAll('.start-session').forEach(btn => {
      btn.addEventListener('click', function() {
        const appointmentId = this.getAttribute('data-id');
        // Implementar lógica para iniciar sessão
        alert('Iniciando sessão para agendamento ID: ' + appointmentId);
      });
    });

    // Reschedule button
    document.querySelectorAll('.reschedule').forEach(btn => {
      btn.addEventListener('click', function() {
        const appointmentId = this.getAttribute('data-id');
        // Implementar lógica para reagendar
        alert('Reagendando agendamento ID: ' + appointmentId);
      });
    });
  });
</script>
</body>
</html>