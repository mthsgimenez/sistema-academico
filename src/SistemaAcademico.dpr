program SistemaAcademico;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {formMain},
  uEstudante in 'uEstudante.pas',
  uProfessor in 'uProfessor.pas',
  uDatabase in 'uDatabase.pas' {Database: TDataModule},
  uEstudanteModel in 'uEstudanteModel.pas',
  uFormEstudante in 'uFormEstudante.pas' {FormEstudante};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformMain, formMain);
  Application.CreateForm(TDatabase, Database);
  Application.CreateForm(TFormEstudante, FormEstudante);
  Application.Run;
end.
