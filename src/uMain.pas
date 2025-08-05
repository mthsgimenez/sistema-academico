unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Comp.Client;

type
  TformMain = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formMain: TformMain;

implementation

{$R *.dfm}

uses uFormEstudante;

procedure TformMain.Button1Click(Sender: TObject);
var
  formEstudante: TFormEstudante;
begin
  formEstudante := TFormEstudante.Create(nil);
  formEstudante.ShowModal;
  formEstudante.Free;
end;

end.
