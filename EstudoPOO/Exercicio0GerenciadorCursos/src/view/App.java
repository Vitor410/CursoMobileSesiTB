package view;

import java.util.Scanner;

import Controller.Curso;
import model.Aluno;
import model.Professor;

public class App {
    public static void main(String[] args) throws Exception {
        //criar curso e incluir professor
        Professor professor = new Professor("José Pereira", "123.456.789.", 0);
        Curso curso = new Curso("professor java", professor);
        //menu de opções
        int operacao;
        boolean continuar = true;
        Scanner sc = new Scanner(System.in);
        while (continuar) {
            System.out.println("========================");
            System.out.println("Escolha a opção Desejada:");
            System.out.println("1. Adicionar Aluno");
            System.out.println("2. Informações do Curso");
            System.out.println("3. Sair");
            System.out.println("========================");
            operacao = sc.nextInt();
            switch (operacao) {
                case 1://adicionar aluno
                    System.out.println("Informe o Nome do Aluno:");
                    String nomeA = sc.next();
                    System.out.println("Informe o CPF do Aluno:");
                    String cpfA = sc.next();
                    System.out.println("Informe o numero da Matricula:");
                    String matriculaA = sc.next();
                    System.out.println("Informe a nota do Aluno:");
                    double notaA = sc.nextDouble();
                    Aluno aluno = new Aluno(nomeA, cpfA, matriculaA, notaA);
                    curso.adicionarAluno(aluno);
                    System.out.println("Aluno Adicionado com sucesso");
                    System.out.println("==========================");
                    break;
                case 2://Exibir informações do curso
                    curso.exibirInformacoesCurso();
                    break;

                case 3:
                    curso.exibirInformacoesCurso();
                    break;

                case 4://sair
                    System.out.println("Encerrando o sistema");
                    continuar = false;
                    break;
                default:
                    System.out.println("Informe um valor Valido!");

                    break;
            }
        }
        sc.close();
    }
}

