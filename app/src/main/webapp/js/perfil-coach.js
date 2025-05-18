document.addEventListener('DOMContentLoaded', function() {
    // ... (código anterior mantido) ...

    // Sistema de avaliações interativo
    const addReviewBtn = document.getElementById('add-review-btn');
    const reviewModal = document.getElementById('review-modal');
    const closeModalBtns = document.querySelectorAll('.close-modal');
    const starInputs = document.querySelectorAll('.star-input');
    const reviewForm = document.getElementById('review-form');
    const ratingValue = document.getElementById('rating-value');

    // Abrir modal de avaliação
    if (addReviewBtn) {
        addReviewBtn.addEventListener('click', function() {
            reviewModal.style.display = 'block';
        });
    }

    // Fechar modais
    closeModalBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            this.closest('.modal').style.display = 'none';
        });
    });

    // Fechar modal ao clicar fora
    window.addEventListener('click', function(e) {
        if (e.target.classList.contains('modal')) {
            e.target.style.display = 'none';
        }
    });

    // Classificação por estrelas (modal)
    starInputs.forEach(star => {
        star.addEventListener('click', function() {
            const value = parseInt(this.getAttribute('data-value'));
            ratingValue.value = value;

            starInputs.forEach((s, index) => {
                if (index < value) {
                    s.classList.add('active');
                } else {
                    s.classList.remove('active');
                }
            });
        });
    });

    // Enviar avaliação
    if (reviewForm) {
        reviewForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const rating = ratingValue.value;
            const reviewText = document.getElementById('review-text').value;

            // Aqui você enviaria os dados para o servidor
            console.log('Nova avaliação:', { rating, review: reviewText });

            // Fechar modal e recarregar avaliações
            reviewModal.style.display = 'none';
            alert('Avaliação enviada com sucesso!');
            // location.reload(); // Recarregar a página após envio
        });
    }

    // Curtir avaliação
    const likeButtons = document.querySelectorAll('.btn-like');
    likeButtons.forEach(btn => {
        btn.addEventListener('click', function() {
            const countElement = this.querySelector('span');
            let count = parseInt(countElement.textContent);

            if (this.classList.contains('liked')) {
                count--;
                this.classList.remove('liked');
                this.innerHTML = '<i class="far fa-thumbs-up"></i> <span>' + count + '</span>';
            } else {
                count++;
                this.classList.add('liked');
                this.innerHTML = '<i class="fas fa-thumbs-up"></i> <span>' + count + '</span>';
            }

            countElement.textContent = count;
        });
    });

    // Sistema de disponibilidade
    const monthSelect = document.getElementById('availability-month');
    const yearSelect = document.getElementById('availability-year');
    const calendarGrid = document.querySelector('.calendar-grid');
    const timeSlotsGrid = document.querySelector('.time-slots-grid');
    const selectedDateElement = document.getElementById('selected-date');
    const slotModal = document.getElementById('slot-modal');
    const slotForm = document.getElementById('slot-form');
    const addSlotBtn = document.getElementById('add-slot-btn');

    // Gerar calendário
    function generateCalendar(month, year) {
        // Limpar calendário existente (exceto cabeçalhos)
        while (calendarGrid.children.length > 7) {
            calendarGrid.removeChild(calendarGrid.lastChild);
        }

        const firstDay = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();

        // Adicionar dias vazios no início
        for (let i = 0; i < firstDay; i++) {
            const emptyDay = document.createElement('div');
            emptyDay.className = 'calendar-day empty';
            calendarGrid.appendChild(emptyDay);
        }

        // Adicionar dias do mês
        for (let day = 1; day <= daysInMonth; day++) {
            const dayElement = document.createElement('div');
            dayElement.className = 'calendar-day';
            dayElement.textContent = day;

            // Simular disponibilidade (na prática, viria do servidor)
            const random = Math.random();
            if (random > 0.7) {
                dayElement.classList.add('booked');
            } else if (random > 0.3) {
                dayElement.classList.add('available');
            } else {
                dayElement.classList.add('unavailable');
            }

            dayElement.addEventListener('click', function() {
                if (this.classList.contains('available') {
                    // Remover seleção anterior
                    document.querySelectorAll('.calendar-day.selected').forEach(el => {
                        el.classList.remove('selected');
                    });

                    // Selecionar este dia
                    this.classList.add('selected');

                    // Atualizar data selecionada
                    const selectedDate = new Date(year, month, day);
                    const formattedDate = selectedDate.toLocaleDateString('pt-BR');
                    selectedDateElement.textContent = formattedDate;

                    // Carregar horários disponíveis (simulado)
                    loadTimeSlots(selectedDate);
                }
            });

            calendarGrid.appendChild(dayElement);
        }
    }

    // Carregar horários disponíveis
    function loadTimeSlots(date) {
        // Limpar horários existentes
        timeSlotsGrid.innerHTML = '';

        // Simular horários disponíveis (na prática, viria do servidor)
        const hours = [9, 10, 11, 14, 15, 16];
        const minutes = ['00', '30'];

        hours.forEach(hour => {
            minutes.forEach(minute => {
                const time = `${hour}:${minute}`;
                const slotElement = document.createElement('div');
                slotElement.className = 'time-slot';
                slotElement.textContent = time;

                // Simular alguns horários reservados
                if (Math.random() > 0.7) {
                    slotElement.classList.add('booked');
                } else {
                    slotElement.addEventListener('click', function() {
                        if (!this.classList.contains('booked')) {
                            document.querySelectorAll('.time-slot.selected').forEach(el => {
                                el.classList.remove('selected');
                            });
                            this.classList.add('selected');
                        }
                    });
                }

                timeSlotsGrid.appendChild(slotElement);
            });
        });
    }

    // Mudar mês/ano
    if (monthSelect && yearSelect) {
        monthSelect.addEventListener('change', updateCalendar);
        yearSelect.addEventListener('change', updateCalendar);

        function updateCalendar() {
            const month = parseInt(monthSelect.value);
            const year = parseInt(yearSelect.value);
            generateCalendar(month, year);
        }

        // Inicializar calendário
        updateCalendar();
    }

    // Adicionar novo horário
    if (addSlotBtn) {
        addSlotBtn.addEventListener('click', function() {
            slotModal.style.display = 'block';
        });
    }

    // Enviar novo horário
    if (slotForm) {
        slotForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const date = document.getElementById('slot-date').value;
            const time = document.getElementById('slot-time').value;
            const duration = document.getElementById('slot-duration').value;

            // Aqui você enviaria os dados para o servidor
            console.log('Novo horário:', { date, time, duration });

            // Fechar modal e recarregar disponibilidade
            slotModal.style.display = 'none';
            alert('Horário adicionado com su