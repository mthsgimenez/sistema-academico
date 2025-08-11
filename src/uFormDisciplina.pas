unit uFormDisciplina;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, uDisciplina, uDisciplinaModel;

type
  TformDisciplina = class(TForm)
    panelDisciplina: TPanel;
    editDisciplinaNome: TEdit;
    buttonConfirmar: TButton;
    procedure FormShow(Sender: TObject);
    procedure editDisciplinaNomeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure buttonConfirmarClick(Sender: TObject);
  private
    currentDisciplina: TDisciplina;
  public
    constructor Create(aDisciplina: TDisciplina; AOwner: TComponent);
  end;

var
  formDisciplina: TformDisciplina;

implementation

{$R *.dfm}

procedure TformDisciplina.buttonConfirmarClick(Sender: TObject);
var
  nome: String;
begin
  nome := editDisciplinaNome.Text;

  if Self.currentDisciplina = nil then begin
    Self.currentDisciplina := TDisciplina.Create;
    Self.currentDisciplina.SetNome(nome);

    ModelDisciplina.Insert(Self.currentDisciplina);
    Self.Close;
    Exit;
  end;

  Self.currentDisciplina.SetNome(nome);
  ModelDisciplina.Edit(Self.currentDisciplina);
  Self.Close;
end;

constructor TformDisciplina.Create(aDisciplina: TDisciplina;
  AOwner: TComponent);
begin
  inherited Create(AOwner);
  if aDisciplina <> nil then begin
    Self.currentDisciplina := aDisciplina;
    editDisciplinaNome.Text := Self.currentDisciplina.GetNome;
  end;

end;

procedure TformDisciplina.editDisciplinaNomeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = vk_return then buttonConfirmarClick(Sender);
end;

procedure TformDisciplina.FormShow(Sender: TObject);
begin
  editDisciplinaNome.SetFocus;
end;

end.
