package YourCoaching.model;

import java.time.LocalDate;

public class Coach {
    private Integer id;
    private String nome;
    private String email;
    private String telefone;
    private String senha;
    private LocalDate dataNascimento;
    private String curso;
    private String area;
    private String descricaoprofissional;
    private String preco;

    public Coach(String nome, String email, String telefone, String senha, LocalDate dataNascimento, String curso, String area, String descricaoprofissional, String preco) {
        this.nome = nome;
        this.email = email;
        this.telefone = telefone;
        this.senha = senha;
        this.dataNascimento = dataNascimento;
        this.curso = curso;
        this.area = area;
        this.descricaoprofissional = descricaoprofissional;
        this.preco = preco;
    }

    public Coach(Integer id,String nome, String email, String telefone, String senha, LocalDate dataNascimento, String curso, String area, String descricaoprofissional, String preco) {
        this.id = id;
        this.nome = nome;
        this.email = email;
        this.telefone = telefone;
        this.senha = senha;
        this.dataNascimento = dataNascimento;
        this.curso = curso;
        this.area = area;
        this.descricaoprofissional = descricaoprofissional;
        this.preco = preco;
    }

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

    public String getCurso() {
        return curso;
    }

    public void setCurso(String curso) {
        this.curso = curso;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getDescricaoprofissional() {
        return descricaoprofissional;
    }

    public void setDescricaoprofissional(String descricaoprofissional) {
        this.descricaoprofissional = descricaoprofissional;
    }

    public String getPreco() {
        return preco;
    }

    public void setPreco(String preco) {
        this.preco = preco;
    }

    @Override
    public String toString() {
        return "Coach{" +
                "id=" + id +
                ", nome='" + nome + '\'' +
                ", email='" + email + '\'' +
                ", telefone='" + telefone + '\'' +
                ", senha='" + senha + '\'' +
                ", dataNascimento=" + dataNascimento +
                ", curso='" + curso + '\'' +
                ", area='" + area + '\'' +
                ", descricaoprofissional='" + descricaoprofissional + '\'' +
                ", preco='" + preco + '\'' +
                '}';
    }
}