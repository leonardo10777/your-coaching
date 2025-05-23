package YourCoaching.model;

import java.time.LocalDate;

public class Cliente {
    private Usuario usuario;
    private Integer totalSessoes;
    private Double ultimaAvaliacao;
    private LocalDate ultimaSessao;

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Integer getTotalSessoes() {
        return totalSessoes;
    }

    public void setTotalSessoes(Integer totalSessoes) {
        this.totalSessoes = totalSessoes;
    }

    public Double getUltimaAvaliacao() {
        return ultimaAvaliacao;
    }

    public void setUltimaAvaliacao(Double ultimaAvaliacao) {
        this.ultimaAvaliacao = ultimaAvaliacao;
    }

    public LocalDate getUltimaSessao() {
        return ultimaSessao;
    }

    public void setUltimaSessao(LocalDate ultimaSessao) {
        this.ultimaSessao = ultimaSessao;
    }
}