package model;

public class Professor extends Pessoa{
    //encapsulamento
    //atributos - privados
    private double salario;
    //métodos - publicos
    //construtor
    public Professor(String nome, String cpf, double salario) {
        super(nome, cpf);
        this.salario = salario;
        
    }
    public double getSalario() {
        return salario;
    }
    public void setSalario(double salario) {
        this.salario = salario;
    }
    @Override //exibirInformações - polimorfismo
    public void exibirInformacoes(){
        super.exibirInformacoes();
        System.out.println("salario: "+getSalario());
    }
    
}
