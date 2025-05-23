package YourCoaching.model;

import java.time.LocalDateTime;

public class Agendamento {
    private Integer id;
    private Integer usuarioId;  // ID do usuário
    private String usuarioNome; // Nome do usuário (para exibição)
    private String usuarioImagem; // Imagem do usuário (opcional)
    private Integer coachId;    // ID do coach
    private LocalDateTime dataHora;
    private Integer duracao;    // Em minutos
    private String servico;
    private String observacoes;
    private String status;      // PENDENTE, CONFIRMADO, CANCELADO, REALIZADO

    // Construtores
    public Agendamento() {
    }

    public Agendamento(Integer usuarioId, Integer coachId, LocalDateTime dataHora,
                       Integer duracao, String servico, String status) {
        this.usuarioId = usuarioId;
        this.coachId = coachId;
        this.dataHora = dataHora;
        this.duracao = duracao;
        this.servico = servico;
        this.status = status;
    }

    // Getters e Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(Integer usuarioId) {
        this.usuarioId = usuarioId;
    }

    public String getUsuarioNome() {
        return usuarioNome;
    }

    public void setUsuarioNome(String usuarioNome) {
        this.usuarioNome = usuarioNome;
    }

    public String getUsuarioImagem() {
        return usuarioImagem;
    }

    public void setUsuarioImagem(String usuarioImagem) {
        this.usuarioImagem = usuarioImagem;
    }

    public Integer getCoachId() {
        return coachId;
    }

    public void setCoachId(Integer coachId) {
        this.coachId = coachId;
    }

    public LocalDateTime getDataHora() {
        return dataHora;
    }

    public void setDataHora(LocalDateTime dataHora) {
        this.dataHora = dataHora;
    }

    public Integer getDuracao() {
        return duracao;
    }

    public void setDuracao(Integer duracao) {
        this.duracao = duracao;
    }

    public String getServico() {
        return servico;
    }

    public void setServico(String servico) {
        this.servico = servico;
    }

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // Método toString para facilitar a visualização
    @Override
    public String toString() {
        return "Agendamento{" +
                "id=" + id +
                ", usuarioId=" + usuarioId +
                ", usuarioNome='" + usuarioNome + '\'' +
                ", coachId=" + coachId +
                ", dataHora=" + dataHora +
                ", duracao=" + duracao +
                ", servico='" + servico + '\'' +
                ", status='" + status + '\'' +
                '}';
    }

    // Métodos úteis
    public boolean isPendente() {
        return "PENDENTE".equals(status);
    }

    public boolean isConfirmado() {
        return "CONFIRMADO".equals(status);
    }

    public boolean isCancelado() {
        return "CANCELADO".equals(status);
    }

    public boolean isRealizado() {
        return "REALIZADO".equals(status);
    }
}