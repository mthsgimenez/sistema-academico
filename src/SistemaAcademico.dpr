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
  uFormProfessor in 'uFormProfessor.pas' {formProfessor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDatabase, Database);
  Application.CreateForm(TformMain, formMain);
  Application.CreateForm(TformEstudante, formEstudante);
  Application.CreateForm(TformProfessor, formProfessor);
  Application.Run;
end.
