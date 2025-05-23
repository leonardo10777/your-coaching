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
    .status-badge {
      padding: 5px 10px;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: 600;
    }

    .status-confirmed {
      background-color: #d4edda;
      color: #155724;
    }

    .status-pending {
      background-color: #fff3cd;
      color: #856404;
    }

    .status-canceled {
      background-color: #f8d7da;
      color: #721c24;
    }

    .status-completed {
      background-color: #e2e3e5;
      color: #383d41;
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
          <li><a href="dashboard-usuario.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
          <li><a href="perfil-usuario.jsp"><i class="fas fa-user"></i> Meu Perfil</a></li>
          <li><a href="agendamentos-usuario.jsp" class="active"><i class="fas fa-calendar"></i> Agendamentos</a></li>
          <li><a href="list-coaches-for-users"><i class="fas fa-users"></i> Encontrar Coachs</a></li>
        </ul>
      </nav>

      <a href="logout" class="btn btn-outline">Sair</a>
    </div>
  </div>
</header>

<main class="container">
  <section class="appointments-section">
    <h1>Meus Agendamentos</h1>

    <div class="appointment-filters">
      <button class="btn btn-outline active" data-filter="all">Todos</button>
      <button class="btn btn-outline" data-filter="confirmed">Confirmados</button>
      <button class="btn btn-outline" data-filter="pending">Pendentes</button>
      <button class="btn btn-outline" data-filter="completed">Realizados</button>
    </div>

    <div class="appointments-list">
      <c:choose>
        <c:when test="${not empty agendamentos}">
          <c:forEach var="agendamento" items="${agendamentos}">
            <div class="appointment-card" data-status="${agendamento.status.toLowerCase()}">
              <div class="appointment-header">
                <div class="coach-info">
                  <img src="${pageContext.request.contextPath}/img/${not empty agendamento.coach.image ? agendamento.coach.image : 'default-coach.jpg'}"
                       alt="${agendamento.coach.nome}"
                       class="coach-avatar"
                       onerror="this.src='${pageContext.request.contextPath}/img/default-coach.jpg'">
                  <div>
                    <h3>${agendamento.coach.nome}</h3>
                    <p>${agendamento.coach.area}</p>
                  </div>
                </div>
                <span class="status-badge status-${agendamento.status.toLowerCase()}">
                    ${agendamento.status}
                </span>
              </div>

              <div class="appointment-details">
                <p><i class="fas fa-calendar-day"></i>
                  <fmt:formatDate value="${agendamento.dataHora}" pattern="dd/MM/yyyy HH:mm" />
                </p>
                <p><i class="fas fa-clock"></i> Duração: ${agendamento.duracao} minutos</p>
                <p><i class="fas fa-comment"></i> ${agendamento.observacoes}</p>
              </div>

              <div class="appointment-actions">
                <c:if test="${agendamento.status == 'PENDENTE'}">
                  <button class="btn btn-primary confirm-appointment" data-id="${agendamento.id}">
                    Confirmar
                  </button>
                  <button class="btn btn-outline reschedule-appointment" data-id="${agendamento.id}">
                    Reagendar
                  </button>
                  <button class="btn btn-outline cancel-appointment" data-id="${agendamento.id}">
                    Cancelar
                  </button>
                </c:if>

                <c:if test="${agendamento.status == 'CONFIRMADO' and not agendamento.realizado}">
                  <button class="btn btn-primary join-session" data-id="${agendamento.id}">
                    Entrar na Sessão
                  </button>
                </c:if>
              </div>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="no-appointments">
            <i class="fas fa-calendar-times fa-2x"></i>
            <p>Você não possui agendamentos</p>
            <a href="list-coaches-for-users" class="btn btn-primary">
              Agendar com um Coach
            </a>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </section>
</main>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    // Filter appointments
    const filterButtons = document.querySelectorAll('.appointment-filters button');
    filterButtons.forEach(button => {
      button.addEventListener('click', function() {
        const filter = this.getAttribute('data-filter');

        filterButtons.forEach(btn => btn.classList.remove('active'));
        this.classList.add('active');

        document.querySelectorAll('.appointment-card').forEach(card => {
          if (filter === 'all' || card.getAttribute('data-status') === filter) {
            card.style.display = 'block';
          } else {
            card.style.display = 'none';
          }
        });
      });
    });

    // Appointment actions
    document.querySelectorAll('.confirm-appointment').forEach(btn => {
      btn.addEventListener('click', function() {
        // Implementar confirmação
      });
    });

    // Similar para outras ações (cancelar, reagendar, etc.)
  });
</script>
</body>
</html>