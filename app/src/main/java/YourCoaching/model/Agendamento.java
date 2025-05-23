package YourCoaching.model;

import java.time.LocalDate;
import java.time.LocalTime;

public class Agendamento {
    private Integer id;
    private Integer usuarioId;
    private Integer coachId;
    private LocalDate data;
    private LocalTime horario;

    // Construtores
    public Agendamento() {}

    public Agendamento(Integer usuarioId, Integer coachId, LocalDate data, LocalTime horario) {
        this.usuarioId = usuarioId;
        this.coachId = coachId;
        this.data = data;
        this.horario = horario;
    }

    public Agendamento(Integer id, Integer usuarioId, Integer coachId, LocalDate data, LocalTime horario) {
        this.id = id;
        this.usuarioId = usuarioId;
        this.coachId = coachId;
        this.data = data;
        this.horario = horario;
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

    public Integer getCoachId() {
        return coachId;
    }

    public void setCoachId(Integer coachId) {
        this.coachId = coachId;
    }

    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        this.data = data;
    }

    public LocalTime getHorario() {
        return horario;
    }

    public void setHorario(LocalTime horario) {
        this.horario = horario;
    }

    @Override
    public String toString() {
        return "Agendamento{" +
                "id=" + id +
                ", usuarioId=" + usuarioId +
                ", coachId=" + coachId +
                ", data=" + data +
                ", horario=" + horario +
                '}';
    }
}