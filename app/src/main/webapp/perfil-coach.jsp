<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil do Coach | Your Coaching</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/perfil-coach.css">
    <style>
        /* Estilos adicionais específicos para esta página */
        .profile-image {
            position: relative;
            width: 200px;
            height: 200px;
            margin: 0 auto;
        }

        .profile-image img {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--primary-color);
        }

        .btn-edit-photo {
            position: absolute;
            bottom: 10px;
            right: 10px;
            background: var(--primary-color);
            color: white;
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .booking-section {
            background: #f8f9fa;
            padding: 30px;
            border-radius: 12px;
            margin-top: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .booking-form {
            max-width: 500px;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
        }

        .booking-btn {
            width: 100%;
            padding: 15px;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .booking-btn:hover {
            background: #218838;
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

        .profile-content {
            display: grid;
            grid-template-columns: 1fr;
            gap: 30px;
            margin-top: 30px;
        }

        .about-section {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 6px;
        }

        .detail-item i {
            color: var(--primary-color);
            width: 20px;
        }

        @media (max-width: 768px) {
            .profile-info {
                text-align: center;
            }

            .profile-actions {
                flex-direction: column;
                gap: 10px;
            }

            .details-grid {
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
                    <c:choose>
                        <c:when test="${sessionScope.tipoUsuario == 'coach'}">
                            <li><a href="dashboard-coach" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
                            <li><a href="perfil-coach?coachId=${coach.id}" class="active"><i class="fas fa-user"></i> Meu Perfil</a></li>
                            <li><a href="dashboard-coach"><i class="fas fa-calendar"></i> Agendamentos</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="dashboard-usuario.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                            <li><a href="buscar-coaches.html"><i class="fas fa-search"></i> Buscar Coaches</a></li>
                            <li><a href="meus-agendamentos"><i class="fas fa-calendar"></i> Meus Agendamentos</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </nav>

            <a href="logout" class="btn btn-outline">Sair</a>
        </div>
    </div>
</header>

<main class="container">
    <section class="profile-section">
        <div class="profile-header">
            <div class="profile-image">
                <c:choose>
                    <c:when test="${not empty coach.image}">
                        <img src="${pageContext.request.contextPath}/img/${coach.image}"
                             alt="Foto do Coach ${coach.nome}"
                             onerror="this.src='${pageContext.request.contextPath}/img/default-coach.jpg'">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/img/default-coach.jpg"
                             alt="Foto padrão do coach">
                    </c:otherwise>
                </c:choose>
                <c:if test="${sessionScope.tipoUsuario == 'coach' && sessionScope.coach.id == coach.id}">
                    <button class="btn-edit-photo">
                        <i class="fas fa-camera"></i>
                    </button>
                </c:if>
            </div>
            <div class="profile-info">
                <h1>${coach.nome}</h1>
                <p class="specialty">${coach.area}</p>
                <div class="rating">
                    <span class="stars">★★★★★</span>
                    <span class="rating-value">4.9</span>
                    <span class="reviews">(128 avaliações)</span>
                </div>
                <div class="price">
                    <c:choose>
                        <c:when test="${sessionScope.tipoUsuario == 'coach' && sessionScope.coach.id == coach.id}">
                            <fmt:setLocale value="pt_BR"/>
                            <fmt:formatNumber value="${coach.preco}" type="currency"/>
                        </c:when>
                        <c:otherwise>
                            R$ ${coach.preco}
                        </c:otherwise>
                    </c:choose>
                </div>
                <c:if test="${sessionScope.tipoUsuario == 'coach' && sessionScope.coach.id == coach.id}">
                    <div class="profile-actions">
                        <button class="btn btn-primary">Editar Perfil</button>
                        <button class="btn btn-outline">Ver Como Cliente</button>
                    </div>
                </c:if>
            </div>
        </div>

        <div class="profile-content">
            <div class="profile-main">
                <section class="about-section">
                    <h2>Sobre Mim</h2>
                    <p>${coach.descricaoprofissional}</p>

                    <div class="details-grid">
                        <div class="detail-item">
                            <i class="fas fa-graduation-cap"></i>
                            <span>Formação: ${coach.curso}</span>
                        </div>
                        <div class="detail-item">
                            <i class="fas fa-birthday-cake"></i>
                            <span>Data de Nascimento:
                                <fmt:parseDate value="${coach.dataNascimento}" pattern="yyyy-MM-dd" var="parsedDate" type="date" />
                                <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                            </span>
                        </div>
                        <div class="detail-item">
                            <i class="fas fa-envelope"></i>
                            <span>Email: ${coach.email}</span>
                        </div>
                        <div class="detail-item">
                            <i class="fas fa-phone"></i>
                            <span>Telefone: ${coach.telefone}</span>
                        </div>
                    </div>
                </section>

                <!-- Seção de Agendamento (para usuários ou outros coaches) -->
                <c:if test="${sessionScope.tipoUsuario == 'usuario' || (sessionScope.tipoUsuario == 'coach' && sessionScope.coach.id != coach.id)}">
                    <section class="booking-section">
                        <h2><i class="fas fa-calendar-plus"></i> Agendar Consulta</h2>

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

                        <form action="agendar" method="post" class="booking-form">
                            <input type="hidden" name="coachId" value="${coach.id}">

                            <div class="form-group">
                                <label for="data">
                                    <i class="fas fa-calendar"></i> Data da Consulta:
                                </label>
                                <input type="date" id="data" name="data" class="form-control" required
                                       min="<%= java.time.LocalDate.now() %>">
                            </div>

                            <div class="form-group">
                                <label for="horario">
                                    <i class="fas fa-clock"></i> Horário:
                                </label>
                                <input type="time" id="horario" name="horario" class="form-control" required
                                       min="08:00" max="19:00" step="1800">
                            </div>

                            <button type="submit" class="booking-btn">
                                <i class="fas fa-calendar-check"></i> Confirmar Agendamento
                            </button>
                        </form>

                        <div style="margin-top: 15px; text-align: center; color: #666; font-size: 14px;">
                            <i class="fas fa-info-circle"></i>
                            Horário de funcionamento: 08:00 às 19:00 | Agendamentos até 90 dias de antecedência
                        </div>
                    </section>
                </c:if>
            </div>
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

<script src="${pageContext.request.contextPath}/js/script.js"></script>
<script>
    // Fallback para imagens que não carregarem
    document.addEventListener('DOMContentLoaded', function() {
        const images = document.querySelectorAll('img');
        images.forEach(img => {
            img.addEventListener('error', function() {
                if (this.closest('.profile-image')) {
                    this.src = '${pageContext.request.contextPath}/img/default-coach.jpg';
                } else if (this.classList.contains('client-image')) {
                    this.src = '${pageContext.request.contextPath}/img/default-user.jpg';
                }
            });
        });

        // Formatar telefone
        const phoneElements = document.querySelectorAll('.detail-item span');
        phoneElements.forEach(el => {
            if (el.textContent.includes('Telefone')) {
                const phone = '${coach.telefone}';
                if (phone.length === 11) {
                    el.textContent = 'Telefone: (' + phone.substring(0, 2) + ') ' +
                        phone.substring(2, 7) + '-' + phone.substring(7);
                } else if (phone.length === 10) {
                    el.textContent = 'Telefone: (' + phone.substring(0, 2) + ') ' +
                        phone.substring(2, 6) + '-' + phone.substring(6);
                }
            }
        });

        // Configurações específicas para agendamento (apenas para não-coaches)
        <c:if test="${sessionScope.tipoUsuario != 'coach' || sessionScope.coach.id != coach.id}">
        // Configurar data mínima como hoje
        const dataInput = document.getElementById('data');
        if (dataInput) {
            const today = new Date().toISOString().split('T')[0];
            dataInput.min = today;

            // Configurar data máxima (90 dias a partir de hoje)
            const maxDate = new Date();
            maxDate.setDate(maxDate.getDate() + 90);
            dataInput.max = maxDate.toISOString().split('T')[0];
        }

        // Validação do horário
        const horarioInput = document.getElementById('horario');
        if (horarioInput) {
            horarioInput.addEventListener('change', function() {
                const time = this.value;
                const [hours, minutes] = time.split(':').map(Number);

                if (hours < 8 || hours > 19 || (hours === 19 && minutes > 0)) {
                    alert('Por favor, escolha um horário entre 08:00 e 19:00.');
                    this.value = '';
                }
            });
        }

        // Auto-hide alerts após 5 segundos
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
        </c:if>
    });
</script>
</body>
</html>