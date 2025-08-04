program SistemaAcademico;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {formMain},
  uEstudante in 'uEstudante.pas',
  uProfessor in 'uProfessor.pas',
  uDatabase in 'uDatabase.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformMain, formMain);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
