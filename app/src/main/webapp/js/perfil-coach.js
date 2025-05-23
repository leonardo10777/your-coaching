document.addEventListener('DOMContentLoaded', function() {
    const addReviewBtn = document.getElementById('add-review-btn');
    const reviewModal = document.getElementById('review-modal');
    const closeModalBtns = document.querySelectorAll('.close-modal');
    const starInputs = document.querySelectorAll('.star-input');
    const reviewForm = document.getElementById('review-form');
    const ratingValue = document.getElementById('rating-value');

    if (addReviewBtn) {
        addReviewBtn.addEventListener('click', function() {
            reviewModal.style.display = 'block';
        });
    }

    closeModalBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            this.closest('.modal').style.display = 'none';
        });
    });

    window.addEventListener('click', function(e) {
        if (e.target.classList.contains('modal')) {
            e.target.style.display = 'none';
        }
    });

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

    if (reviewForm) {
        reviewForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const rating = ratingValue.value;
            const reviewText = document.getElementById('review-text').value;

            console.log('Nova avaliação:', { rating, review: reviewText });
            reviewModal.style.display = 'none';
            alert('Avaliação enviada com sucesso!');
        });
    }

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

    const monthSelect = document.getElementById('availability-month');
    const yearSelect = document.getElementById('availability-year');
    const calendarGrid = document.querySelector('.calendar-grid');
    const timeSlotsGrid = document.querySelector('.time-slots-grid');
    const selectedDateElement = document.getElementById('selected-date');
    const slotModal = document.getElementById('slot-modal');
    const slotForm = document.getElementById('slot-form');
    const addSlotBtn = document.getElementById('add-slot-btn');

    function generateCalendar(month, year) {
        while (calendarGrid.children.length > 7) {
            calendarGrid.removeChild(calendarGrid.lastChild);
        }

        const firstDay = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        // Dias vazios no início
        for (let i = 0; i < firstDay; i++) {
            const emptyDay = document.createElement('div');
            emptyDay.className = 'calendar-day empty';
            calendarGrid.appendChild(emptyDay);
        }

        // Dias do mês
        for (let day = 1; day <= daysInMonth; day++) {
            const dayElement = document.createElement('div');
            dayElement.className = 'calendar-day';
            dayElement.textContent = day;

            const currentDate = new Date(year, month, day);

            // Desabilitar dias passados
            if (currentDate < today) {
                dayElement.classList.add('disabled');
            } else {
                // Simular disponibilidade (na implementação real, virá do backend)
                const random = Math.random();
                if (random > 0.7) {
                    dayElement.classList.add('booked');
                } else if (random > 0.3) {
                    dayElement.classList.add('available');
                } else {
                    dayElement.classList.add('unavailable');
                }

                dayElement.addEventListener('click', function() {
                    if (this.classList.contains('available')) {
                        document.querySelectorAll('.calendar-day.selected').forEach(el => {
                            el.classList.remove('selected');
                        });
                        this.classList.add('selected');

                        const selectedDate = new Date(year, month, day);
                        const formattedDate = selectedDate.toLocaleDateString('pt-BR');
                        selectedDateElement.textContent = formattedDate;
                        loadTimeSlots(selectedDate);
                    }
                });
            }

            calendarGrid.appendChild(dayElement);
        }
    }

    function loadTimeSlots(date) {
        timeSlotsGrid.innerHTML = '';

        const hours = [9, 10, 11, 14, 15, 16];
        const minutes = ['00', '30'];

        hours.forEach(hour => {
            minutes.forEach(minute => {
                const time = `${hour}:${minute}`;
                const slotElement = document.createElement('div');
                slotElement.className = 'time-slot';
                slotElement.textContent = time;

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

    if (monthSelect && yearSelect) {
        monthSelect.addEventListener('change', updateCalendar);
        yearSelect.addEventListener('change', updateCalendar);

        function updateCalendar() {
            const month = parseInt(monthSelect.value);
            const year = parseInt(yearSelect.value);
            generateCalendar(month, year);
        }

        updateCalendar();
    }

    if (addSlotBtn) {
        addSlotBtn.addEventListener('click', function() {
            slotModal.style.display = 'block';
        });
    }

    if (slotForm) {
        slotForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const date = document.getElementById('slot-date').value;
            const time = document.getElementById('slot-time').value;
            const duration = document.getElementById('slot-duration').value;

            console.log('Novo horário:', { date, time, duration });
            slotModal.style.display = 'none';
            alert('Horário adicionado com sucesso');
        });
    }

    const coachImage = document.querySelector('.profile-image img');
    if (coachImage) {
        coachImage.addEventListener('error', function() {
            this.src = 'img/default-coach.jpg';
            this.alt = 'Foto padrão do coach';
        });
    }

    const clientImages = document.querySelectorAll('.client-image img');
    clientImages.forEach(img => {
        img.addEventListener('error', function() {
            this.src = 'img/default-user.jpg';
            this.alt = 'Foto padrão do cliente';
        });
    });
});