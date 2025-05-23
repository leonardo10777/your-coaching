document.addEventListener('DOMContentLoaded', function() {
    // FAQ - Todas as respostas começam fechadas
    const faqQuestions = document.querySelectorAll('.faq-question');


    faqQuestions.forEach(question => {
        question.addEventListener('click', () => {
            const answer = question.nextElementSibling;
            const icon = question.querySelector('i');

            // Fecha todas as outras respostas
            document.querySelectorAll('.faq-answer').forEach(item => {
                if (item !== answer) {
                    item.classList.remove('show');
                    item.previousElementSibling.querySelector('i').classList.remove('rotate');
                }
            });

            // Alterna a resposta atual
            answer.classList.toggle('show');
            icon.classList.toggle('rotate');
        });
    });

    // Validação do Formulário de Contato
    const contactForm = document.getElementById('contactForm');

    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();

            // Validação básica
            const name = document.getElementById('name').value.trim();
            const email = document.getElementById('email').value.trim();
            const subject = document.getElementById('subject').value;
            const message = document.getElementById('message').value.trim();

            let isValid = true;

            // Validação do Nome
            if (name === '') {
                isValid = false;
                showError('name', 'Por favor, insira seu nome completo');
            } else {
                removeError('name');
            }

            // Validação do Email
            if (email === '') {
                isValid = false;
                showError('email', 'Por favor, insira seu email');
            } else if (!isValidEmail(email)) {
                isValid = false;
                showError('email', 'Por favor, insira um email válido');
            } else {
                removeError('email');
            }

            // Validação do Assunto
            if (subject === '') {
                isValid = false;
                showError('subject', 'Por favor, selecione um assunto');
            } else {
                removeError('subject');
            }

            // Validação da Mensagem
            if (message === '') {
                isValid = false;
                showError('message', 'Por favor, escreva sua mensagem');
            } else if (message.length < 10) {
                isValid = false;
                showError('message', 'A mensagem deve ter pelo menos 10 caracteres');
            } else {
                removeError('message');
            }

            // Se o formulário for válido, pode enviar
            if (isValid) {
                // Simulação de envio
                const submitBtn = contactForm.querySelector('button[type="submit"]');
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Enviando...';
                submitBtn.disabled = true;

                setTimeout(() => {
                    alert('Mensagem enviada com sucesso! Entraremos em contato em breve.');
                    contactForm.reset();
                    submitBtn.innerHTML = '<i class="fas fa-paper-plane"></i> Enviar Mensagem';
                    submitBtn.disabled = false;
                }, 1500);
            }
        });
    }

    // Funções auxiliares
    function showError(fieldId, message) {
        const field = document.getElementById(fieldId);
        const formGroup = field.closest('.form-group');

        // Remove mensagens de erro existentes
        const existingError = formGroup.querySelector('.error-message');
        if (existingError) {
            existingError.remove();
        }

        // Adiciona a nova mensagem de erro
        const errorElement = document.createElement('p');
        errorElement.className = 'error-message';
        errorElement.textContent = message;
        errorElement.style.color = '#e74c3c';
        errorElement.style.marginTop = '5px';
        errorElement.style.fontSize = '0.9rem';

        formGroup.appendChild(errorElement);
        field.style.borderColor = '#e74c3c';
    }

    function removeError(fieldId) {
        const field = document.getElementById(fieldId);
        const formGroup = field.closest('.form-group');
        const errorElement = formGroup.querySelector('.error-message');

        if (errorElement) {
            errorElement.remove();
        }

        field.style.borderColor = '#ddd';
    }

    function isValidEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }
});