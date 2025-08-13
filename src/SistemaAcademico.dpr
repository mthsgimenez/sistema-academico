program SistemaAcademico;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {formMain},
  uEstudante in 'uEstudante.pas',
  uDatabase in 'uDatabase.pas' {Database: TDataModule},
  uEstudanteModel in 'uEstudanteModel.pas',
  uFormEstudante in 'uFormEstudante.pas' {formEstudante},
  uProfessor in 'uProfessor.pas',
  uProfessorModel in 'uProfessorModel.pas',
  uFormProfessor in 'uFormProfessor.pas' {formProfessor},
  uCPF in 'uCPF.pas',
  uDisciplina in 'uDisciplina.pas',
  uDisciplinaModel in 'uDisciplinaModel.pas',
  uFormDisciplina in 'uFormDisciplina.pas' {formDisciplina},
  uTurma in 'uTurma.pas',
  uTurmaModel in 'uTurmaModel.pas',
  uFormTurma in 'uFormTurma.pas' {formTurma},
  uMatricula in 'uMatricula.pas',
  uMatriculaModel in 'uMatriculaModel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDatabase, Database);
  Application.CreateForm(TformMain, formMain);
  Application.CreateForm(TformEstudante, formEstudante);
  Application.CreateForm(TformProfessor, formProfessor);
  Application.CreateForm(TformDisciplina, formDisciplina);
  Application.CreateForm(TformTurma, formTurma);
  Application.Run;
end.
