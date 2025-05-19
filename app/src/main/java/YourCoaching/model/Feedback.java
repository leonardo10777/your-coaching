package YourCoaching.model;

public class Feedback {
    private int id;
    private int coachId;
    private String coachNome;
    private int usuarioId;
    private String usuarioNome;
    private String comentario;

    // Construtores
    public Feedback() {
    }

    public Feedback(int id, int coachId, int usuarioId, String usuarioNome, String comentario) {
        this.id = id;
        this.coachId = coachId;
        this.usuarioId = usuarioId;
        this.usuarioNome = usuarioNome;
        this.comentario = comentario;
    }

    // Getters e Setters (remova os métodos para nota e dataFeedback)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCoachId() {
        return coachId;
    }

    public void setCoachId(int coachId) {
        this.coachId = coachId;
    }

    public String getCoachNome() {
        return coachNome;
    }

    public void setCoachNome(String coachNome) {
        this.coachNome = coachNome;
    }

    public int getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(int usuarioId) {
        this.usuarioId = usuarioId;
    }

    public String getUsuarioNome() {
        return usuarioNome;
    }

    public void setUsuarioNome(String usuarioNome) {
        this.usuarioNome = usuarioNome;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

    @Override
    public String toString() {
        return "Feedback{" +
                "id=" + id +
                ", coachId=" + coachId +
                ", coachNome='" + coachNome + '\'' +
                ", usuarioId=" + usuarioId +
                ", usuarioNome='" + usuarioNome + '\'' +
                ", comentario='" + comentario + '\'' +
                '}';
    }
}