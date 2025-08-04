program SistemaAcademico;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {formMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.
