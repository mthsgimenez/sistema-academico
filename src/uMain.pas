unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Comp.Client;

type
  TformMain = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
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

uses uDatabase;

procedure TformMain.Button1Click(Sender: TObject);
var
  Query: TFDQuery;
begin
  Query := uDatabase.DataModule1.FDQueryEstudantes;

  Query.Open;

  while not uDatabase.DataModule1.FDQueryEstudantes.Eof do begin
    ListBox1.Items.Add(uDatabase.DataModule1.FDQueryEstudantes.FieldByName('nome').AsString);
    uDatabase.DataModule1.FDQueryEstudantes.Next;
  end;
end;

end.
