package model;

public class Pessoa { //encapsulamento
    //atributos - privados
    private String nome;
    private String cpf;
    //métodos - públicos
    //construtor
    public Pessoa(String nome, String cpf) {
        this.nome = nome;
        this.cpf = cpf;
    }
    //getter and setters
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getCpf() {
        return cpf;
    }
    public void setCpf(String cpf) {
        this.cpf = cpf;
    }
    //exibir informações
    public void exibirInformacoes(){
        System.out.println("Nome: "+getNome());
        System.out.println("CPF: "+getCpf());
    }


}
