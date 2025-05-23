<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Agendar Consulta | Your Coaching</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    :root {
      --primary-color: #4CAF50;
      --secondary-color: #f44336;
      --dark-color: #333;
      --light-color: #f5f5f5;
      --white: #fff;
      --border-color: #ddd;
    }

    body {
      font-family: 'Montserrat', sans-serif;
      margin: 0;
      padding: 0;
      color: var(--dark-color);
      background-color: var(--light-color);
    }

    .container {
      width: 90%;
      max-width: 1200px;
      margin: 0 auto;
      padding: 0 15px;
    }

    header {
      background-color: var(--white);
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      padding: 15px 0;
      position: sticky;
      top: 0;
      z-index: 100;
    }

    .header-content {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .logo {
      display: flex;
      align-items: center;
      text-decoration: none;
      color: var(--dark-color);
    }

    .logo-img {
      height: 40px;
      margin-right: 10px;
    }

    .main-nav ul {
      display: flex;
      list-style: none;
      margin: 0;
      padding: 0;
    }

    .main-nav li a {
      padding: 10px 15px;
      text-decoration: none;
      color: var(--dark-color);
      font-weight: 600;
      display: flex;
      align-items: center;
    }

    .main-nav li a i {
      margin-right: 5px;
    }

    .main-nav li a.active {
      color: var(--primary-color);
    }

    .main-nav li a:hover {
      color: var(--primary-color);
    }

    .btn-outline {
      padding: 8px 20px;
      border: 2px solid var(--primary-color);
      color: var(--primary-color);
      border-radius: 4px;
      text-decoration: none;
      font-weight: 600;
      transition: all 0.3s;
    }

    .btn-outline:hover {
      background-color: var(--primary-color);
      color: var(--white);
    }

    /* Estilos específicos da página de agendamento */
    .booking-container {
      max-width: 800px;
      margin: 30px auto;
      padding: 30px;
      background: var(--white);
      border-radius: 10px;
      box-shadow: 0 2px 15px rgba(0,0,0,0.1);
    }

    .coach-info {
      display: flex;
      align-items: center;
      margin-bottom: 30px;
      padding-bottom: 20px;
      border-bottom: 1px solid #eee;
    }

    .coach-avatar {
      width: 100px;
      height: 100px;
      border-radius: 50%;
      overflow: hidden;
      margin-right: 20px;
      border: 3px solid var(--primary-color);
    }

    .coach-avatar img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .specialty {
      color: var(--primary-color);
      font-weight: 600;
      margin: 5px 0;
    }

    .price {
      font-weight: 600;
      font-size: 1.1rem;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-control {
      width: 100%;
      padding: 10px;
      border: 1px solid var(--border-color);
      border-radius: 4px;
      font-family: inherit;
    }

    .day-selector {
      display: flex;
      gap: 10px;
      margin-bottom: 15px;
      overflow-x: auto;
      padding-bottom: 10px;
    }

    .day-option {
      padding: 10px 15px;
      border: 1px solid var(--border-color);
      border-radius: 5px;
      cursor: pointer;
      min-width: 100px;
      text-align: center;
      transition: all 0.3s;
    }

    .day-option:hover {
      border-color: var(--primary-color);
    }

    .day-option.selected {
      background-color: var(--primary-color);
      color: var(--white);
      border-color: var(--primary-color);
    }

    .day-option.today {
      border: 2px solid var(--primary-color);
    }

    .day-name {
      font-weight: 600;
    }

    .day-date {
      font-size: 0.9rem;
    }

    .time-slots {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
      gap: 10px;
      margin: 20px 0;
    }

    .time-slot {
      padding: 10px;
      border: 1px solid var(--border-color);
      border-radius: 5px;
      text-align: center;
      cursor: pointer;
      transition: all 0.3s;
    }

    .time-slot:hover {
      background-color: #f0f0f0;
    }

    .time-slot.selected {
      background-color: var(--primary-color);
      color: var(--white);
      border-color: var(--primary-color);
    }

    .no-slots {
      text-align: center;
      padding: 15px;
      color: #666;
      font-style: italic;
    }

    .btn-primary {
      background-color: var(--primary-color);
      color: var(--white);
      border: none;
      padding: 12px 25px;
      border-radius: 4px;
      font-weight: 600;
      cursor: pointer;
      transition: background-color 0.3s;
      font-size: 1rem;
      width: 100%;
      margin-top: 10px;
    }

    .btn-primary:hover {
      background-color: #3e8e41;
    }

    .alert {
      padding: 15px;
      margin-bottom: 20px;
      border-radius: 4px;
    }

    .alert-danger {
      background-color: #f8d7da;
      color: #721c24;
      border: 1px solid #f5c6cb;
    }

    textarea {
      min-height: 100px;
    }

    footer {
      background-color: var(--dark-color);
      color: var(--white);
      padding: 20px 0;
      margin-top: 50px;
    }

    .footer-bottom {
      text-align: center;
    }

    @media (max-width: 768px) {
      .header-content {
        flex-direction: column;
      }

      .main-nav ul {
        margin-top: 15px;
        flex-wrap: wrap;
        justify-content: center;
      }

      .coach-info {
        flex-direction: column;
        text-align: center;
      }

      .coach-avatar {
        margin-right: 0;
        margin-bottom: 15px;
      }

      .day-selector {
        flex-wrap: wrap;
      }

      .day-option {
        min-width: 80px;
        padding: 8px 10px;
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
  <div class="booking-container">
    <div class="coach-info">
      <div class="coach-avatar">
        <img src="${pageContext.request.contextPath}/img/${coach.image}"
             alt="${coach.nome}"
             onerror="this.src='${pageContext.request.contextPath}/img/default-coach.jpg'">
      </div>
      <div>
        <h1>Agendar com ${coach.nome}</h1>
        <p class="specialty">${coach.area}</p>
        <div class="price">
          <fmt:setLocale value="pt_BR"/>
          <fmt:formatNumber value="${coach.preco}" type="currency"/> /hora
        </div>
      </div>
    </div>

    <c:if test="${not empty param.error}">
      <div class="alert alert-danger">
        <c:choose>
          <c:when test="${param.error == 'horario_indisponivel'}">
            O horário selecionado não está mais disponível. Por favor, escolha outro.
          </c:when>
          <c:otherwise>
            Ocorreu um erro ao processar seu agendamento. Tente novamente.
          </c:otherwise>
        </c:choose>
      </div>
    </c:if>

    <form id="bookingForm" action="agendar-consulta" method="post">
      <input type="hidden" name="coachId" value="${coach.id}">

      <div class="form-group">
        <label for="servico">Tipo de Sessão</label>
        <select id="servico" name="servico" class="form-control" required>
          <option value="">Selecione...</option>
          <option value="Consultoria Individual">Consultoria Individual</option>
          <option value="Planejamento Financeiro">Planejamento Financeiro</option>
          <option value="Mentoria de Carreira">Mentoria de Carreira</option>
          <option value="Sessão de Coaching">Sessão de Coaching</option>
        </select>
      </div>

      <div class="form-group">
        <label>Selecione o Dia</label>
        <div class="day-selector" id="daySelector">
          <!-- Dias serão preenchidos via JavaScript -->
        </div>
        <input type="hidden" id="selectedDate" name="selectedDate" required>
      </div>

      <div class="form-group">
        <label>Horários Disponíveis</label>
        <div class="time-slots" id="timeSlots">
          <div class="no-slots">
            Selecione um dia para ver os horários disponíveis
          </div>
        </div>
        <input type="hidden" id="dataHora" name="dataHora" required>
      </div>

      <div class="form-group">
        <label for="duracao">Duração (minutos)</label>
        <select id="duracao" name="duracao" class="form-control" required>
          <option value="30">30 minutos</option>
          <option value="60" selected>60 minutos</option>
          <option value="90">90 minutos</option>
          <option value="120">120 minutos</option>
        </select>
      </div>

      <div class="form-group">
        <label for="observacoes">Observações</label>
        <textarea id="observacoes" name="observacoes" rows="3" class="form-control" placeholder="Descreva brevemente o que você gostaria de trabalhar nesta sessão"></textarea>
      </div>

      <button type="submit" class="btn btn-primary">
        <i class="fas fa-calendar-check"></i> Confirmar Agendamento
      </button>
    </form>
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
  document.addEventListener('DOMContentLoaded', function() {
    const daySelector = document.getElementById('daySelector');
    const timeSlotsContainer = document.getElementById('timeSlots');
    const selectedDateInput = document.getElementById('selectedDate');
    const dataHoraInput = document.getElementById('dataHora');
    const bookingForm = document.getElementById('bookingForm');
    const coachId = ${coach.id};

    // Dias da semana
    const daysOfWeek = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
    const today = new Date();

    // Gerar opções para os próximos 14 dias
    for (let i = 0; i < 14; i++) {
      const date = new Date();
      date.setDate(today.getDate() + i);

      const dayOption = document.createElement('div');
      dayOption.className = 'day-option';
      if (i === 0) dayOption.classList.add('today');

      dayOption.innerHTML = `
            <div class="day-name">${daysOfWeek[date.getDay()]}</div>
            <div class="day-date">${date.getDate()}/${date.getMonth() + 1}</div>
        `;

      dayOption.addEventListener('click', function() {
        document.querySelectorAll('.day-option').forEach(opt => {
          opt.classList.remove('selected');
        });
        this.classList.add('selected');

        // Formatar data como YYYY-MM-DD
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        const formattedDate = `${year}-${month}-${day}`;
        selectedDateInput.value = formattedDate;

        // Carregar horários disponíveis
        loadAvailableTimes(coachId, formattedDate);
      });

      daySelector.appendChild(dayOption);

      // Selecionar o dia atual por padrão
      if (i === 0) {
        dayOption.click();
      }
    }

    function loadAvailableTimes(coachId, date) {
      timeSlotsContainer.innerHTML = '<div class="no-slots">Carregando horários...</div>';

      fetch(`get-available-times?coachId=${coachId}&date=${date}`)
              .then(response => {
                if (!response.ok) {
                  throw new Error('Erro na rede');
                }
                return response.json();
              })
              .then(times => {
                timeSlotsContainer.innerHTML = '';

                if (times.length === 0) {
                  timeSlotsContainer.innerHTML = `
                        <div class="no-slots">
                            Nenhum horário disponível neste dia
                        </div>
                    `;
                  return;
                }

                times.forEach(time => {
                  const slot = document.createElement('div');
                  slot.className = 'time-slot';
                  slot.dataset.time = time.start;
                  slot.innerHTML = `
                        ${time.start} - ${time.end}
                        <input type="hidden" value="${date}T${time.start}:00">
                    `;

                  slot.addEventListener('click', function() {
                    document.querySelectorAll('.time-slot').forEach(s => {
                      s.classList.remove('selected');
                    });
                    this.classList.add('selected');

                    // Atualizar o campo hidden com a data/hora selecionada
                    dataHoraInput.value = `${date}T${time.start}:00`;
                  });

                  timeSlotsContainer.appendChild(slot);
                });
              })
              .catch(error => {
                console.error('Erro ao carregar horários:', error);
                timeSlotsContainer.innerHTML = `
                    <div class="no-slots">
                        Erro ao carregar horários. Tente novamente.
                    </div>
                `;
              });
    }

    // Validação do formulário
    bookingForm.addEventListener('submit', function(e) {
      if (!dataHoraInput.value) {
        e.preventDefault();
        alert('Por favor, selecione um horário disponível');
        return;
      }

      if (!document.querySelector('#servico').value) {
        e.preventDefault();
        alert('Por favor, selecione o tipo de sessão');
        return;
      }
    });
  });
</script>
</body>
</html>