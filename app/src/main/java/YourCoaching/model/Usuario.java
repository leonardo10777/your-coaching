package YourCoaching.model;

import java.time.LocalDate;

public class Usuario {
    private Integer id;
    private String nome;
    private String email;
    private String telefone;
    private String senha;
    private LocalDate dataNascimento;

    // Construtor sem ID (para inserções)
    public Usuario(String nome, String email, String telefone, String senha, LocalDate dataNascimento) {
        this.nome = nome;
        this.email = email;
        this.telefone = telefone;
        this.senha = senha;
        this.dataNascimento = dataNascimento;
    }

    // Construtor completo (para consultas)
    public Usuario(Integer id, String nome, String email, String telefone, String senha, LocalDate dataNascimento) {
        this.id = id;
        this.nome = nome;
        this.email = email;
        this.telefone = telefone;
        this.senha = senha;
        this.dataNascimento = dataNascimento;
    }

    // Getters e Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public LocalDate getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(LocalDate dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    // Método toString() para debug/logging (opcional)
    @Override
    public String toString() {
        return "Usuario{" +
                "id=" + id +
                ", nome='" + nome + '\'' +
                ", email='" + email + '\'' +
                ", telefone='" + telefone + '\'' +
                ", dataNascimento=" + dataNascimento +
                '}';
    }
}