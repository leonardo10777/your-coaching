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
                    <li><a href="dashboard-coach.html"><i class="fas fa-home"></i> Dashboard</a></li>
                    <li><a href="perfil-coach?coachId=${coach.id}" class="active"><i class="fas fa-user"></i> Meu Perfil</a></li>
                    <li><a href="agendamentos-coach.html"><i class="fas fa-calendar"></i> Agendamentos</a></li>
                    <li><a href="clientes-coach.html"><i class="fas fa-users"></i> Meus Clientes</a></li>
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
                <button class="btn-edit-photo">
                    <i class="fas fa-camera"></i>
                </button>
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
                    <fmt:setLocale value="pt_BR"/>
                    <fmt:formatNumber value="${coach.preco}" type="currency"/>
                </div>
                <div class="profile-actions">
                    <button class="btn btn-primary">Editar Perfil</button>
                    <button class="btn btn-outline">Visualizar Como Cliente</button>
                </div>
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
                            <span>Idade:
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

                <section class="testimonials-section">
                    <div class="section-header">
                        <h2>Avaliações dos Clientes</h2>
                        <button id="add-review-btn" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Adicionar Avaliação
                        </button>
                    </div>

                    <div class="testimonials-list">
                        <!-- Avaliação 1 -->
                        <div class="testimonial-card">
                            <div class="testimonial-header">
                                <div class="client-info">
                                    <div class="client-image">
                                        <img src="${pageContext.request.contextPath}/img/client1.jpg" alt="Cliente">
                                    </div>
                                    <div>
                                        <div class="client-name">Ana Paula Silva</div>
                                        <div class="testimonial-date">15/03/2023</div>
                                    </div>
                                </div>
                                <div class="testimonial-rating" data-rating="5">
                                    <span class="star" data-value="1">★</span>
                                    <span class="star" data-value="2">★</span>
                                    <span class="star" data-value="3">★</span>
                                    <span class="star" data-value="4">★</span>
                                    <span class="star" data-value="5">★</span>
                                </div>
                            </div>
                            <div class="testimonial-content">
                                <p>"O ${coach.nome} me ajudou a sair de uma situação financeira complicada. Em 6 meses já estava com as contas no azul e hoje consigo até investir. Recomendo muito!"</p>
                            </div>
                            <div class="testimonial-actions">
                                <button class="btn-like"><i class="far fa-thumbs-up"></i> <span>12</span></button>
                                <button class="btn-reply">Responder</button>
                            </div>
                        </div>
                    </div>
                </section>
            </div>

            <div class="profile-sidebar">
                <section class="availability-section">
                    <h2>Disponibilidade</h2>
                    <div class="availability-controls">
                        <select id="availability-month" class="form-control">
                            <option value="0">Janeiro</option>
                            <option value="1">Fevereiro</option>
                            <option value="2">Março</option>
                            <option value="3">Abril</option>
                            <option value="4">Maio</option>
                            <option value="5" selected>Junho</option>
                            <option value="6">Julho</option>
                            <option value="7">Agosto</option>
                            <option value="8">Setembro</option>
                            <option value="9">Outubro</option>
                            <option value="10">Novembro</option>
                            <option value="11">Dezembro</option>
                        </select>
                        <select id="availability-year" class="form-control">
                            <option>2022</option>
                            <option selected>2023</option>
                            <option>2024</option>
                        </select>
                    </div>
                    <div class="availability-calendar">
                        <div class="calendar-grid">
                            <div class="calendar-day-header">Dom</div>
                            <div class="calendar-day-header">Seg</div>
                            <div class="calendar-day-header">Ter</div>
                            <div class="calendar-day-header">Qua</div>
                            <div class="calendar-day-header">Qui</div>
                            <div class="calendar-day-header">Sex</div>
                            <div class="calendar-day-header">Sáb</div>
                            <!-- Dias serão preenchidos via JavaScript -->
                        </div>
                    </div>
                    <div class="time-slots-container">
                        <h3>Horários disponíveis em <span id="selected-date">--/--/----</span></h3>
                        <div class="time-slots-grid">
                            <!-- Horários serão preenchidos via JavaScript -->
                        </div>
                        <button id="add-slot-btn" class="btn btn-outline">
                            <i class="fas fa-plus"></i> Adicionar Horário
                        </button>
                    </div>
                </section>
            </div>
        </div>
    </section>

    <!-- Modal para nova avaliação -->
    <div id="review-modal" class="modal">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <h2>Adicionar Avaliação</h2>
            <form id="review-form">
                <div class="form-group">
                    <label>Classificação:</label>
                    <div class="rating-input">
                        <span class="star-input" data-value="1">★</span>
                        <span class="star-input" data-value="2">★</span>
                        <span class="star-input" data-value="3">★</span>
                        <span class="star-input" data-value="4">★</span>
                        <span class="star-input" data-value="5">★</span>
                        <input type="hidden" id="rating-value" name="rating" value="0">
                    </div>
                </div>
                <div class="form-group">
                    <label for="review-text">Comentário:</label>
                    <textarea id="review-text" name="review" rows="5" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Enviar Avaliação</button>
            </form>
        </div>
    </div>

    <!-- Modal para adicionar horário -->
    <div id="slot-modal" class="modal">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <h2>Adicionar Horário Disponível</h2>
            <form id="slot-form">
                <div class="form-group">
                    <label for="slot-date">Data:</label>
                    <input type="date" id="slot-date" name="date" required>
                </div>
                <div class="form-group">
                    <label for="slot-time">Horário:</label>
                    <input type="time" id="slot-time" name="time" required>
                </div>
                <div class="form-group">
                    <label for="slot-duration">Duração (minutos):</label>
                    <select id="slot-duration" name="duration">
                        <option value="30">30 minutos</option>
                        <option value="60" selected>60 minutos</option>
                        <option value="90">90 minutos</option>
                        <option value="120">120 minutos</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Adicionar Horário</button>
            </form>
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

<script src="${pageContext.request.contextPath}/js/script.js"></script>
<script src="${pageContext.request.contextPath}/js/perfil-coach.js"></script>
<script>
    // Fallback para imagens que não carregarem
    document.addEventListener('DOMContentLoaded', function() {
        const images = document.querySelectorAll('img');
        images.forEach(img => {
            img.addEventListener('error', function() {
                if (this.classList.contains('profile-image')) {
                    this.src = '${pageContext.request.contextPath}/img/default-coach.jpg';
                } else if (this.classList.contains('client-image')) {
                    this.src = '${pageContext.request.contextPath}/img/default-user.jpg';
                }
            });
        });

        // Formatar telefone (se necessário)
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
    });
</script>
</body>
</html>