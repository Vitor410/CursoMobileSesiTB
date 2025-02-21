package model;

public class Aluno extends Pessoa implements AVALIAVEL{
    //encapsulamento
    //atributos - privados
    private String matricula;
    private double nota;
    //métodos - publicos
    //construtor
    public Aluno(String nome, String cpf, String matricula, double nota) {
        super(nome, cpf);
        this.matricula = matricula;
        this.nota = nota;
    }
    //getter and setters
    public String getMatricula() {
        return matricula;
    }
    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }
    public double getNota() {
        return nota;
    }
    public void setNota(double nota) {
        this.nota = nota;
    }
    @Override //exibirInformações - polimorfismo
    public void exibirInformacoes(){
        super.exibirInformacoes();
        System.out.println("Matricula: "+getMatricula());
        System.out.println("Nota: "+getNota());
    }
    //incluir o método abstrato avaliarDesempenho
    @Override
    public void avaliarDesempenho(){
        if (nota >6) {
            System.out.println("Aluno Aprovado");
        }else{
            System.out.println("Aluno Reprovado");
        }
    }
}
