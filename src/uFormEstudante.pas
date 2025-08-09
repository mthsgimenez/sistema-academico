unit uFormEstudante;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uEstudante, uEstudanteModel;

type
  TformEstudante = class(TForm)
    panelEstudante: TPanel;
    buttonConfirmar: TButton;
    editEstudanteNome: TEdit;
    procedure buttonConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure editEstudanteNomeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    currentEstudante: TEstudante;
  public
    constructor Create(aEstudante: TEstudante; AOwner: TComponent);
  end;

var
  formEstudante: TformEstudante;

implementation

{$R *.dfm}

{ TformEstudante }

procedure TformEstudante.buttonConfirmarClick(Sender: TObject);
var nome: String;
begin
  nome := editEstudanteNome.Text;

  if Self.currentEstudante = nil then begin
    Self.currentEstudante := TEstudante.Create;
    Self.currentEstudante.SetNome(nome);
    ModelEstudante.Insert(Self.currentEstudante);
    Self.Close;
    Exit;
  end;

  Self.currentEstudante.SetNome(nome);
  ModelEstudante.Edit(self.currentEstudante);
  Self.Close;
end;

constructor TformEstudante.Create(aEstudante: TEstudante; AOwner: TComponent);
begin
  inherited Create(AOwner);
  if aEstudante <> nil then begin
    Self.currentEstudante := aEstudante;
    Self.editEstudanteNome.Text := Self.currentEstudante.GetNome;
  end;
end;

procedure TformEstudante.editEstudanteNomeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = vk_return then buttonConfirmarClick(Sender);
end;

procedure TformEstudante.FormShow(Sender: TObject);
begin
  editEstudanteNome.SetFocus;
end;

end.
