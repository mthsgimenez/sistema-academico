unit uFormProfessor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, uProfessor, uProfessorModel;

type
  TformProfessor = class(TForm)
    panelProfessor: TPanel;
    buttonConfirmar: TButton;
    editProfessorNome: TEdit;
    editProfessorCPF: TEdit;
    procedure FormShow(Sender: TObject);
    procedure editProfessorNomeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editProfessorCPFKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure buttonConfirmarClick(Sender: TObject);
  private
    currentProfessor: TProfessor;
  public
    constructor Create(aProfessor: TProfessor; AOwner: TComponent);
  end;

var
  formProfessor: TformProfessor;

implementation

{$R *.dfm}

procedure TformProfessor.buttonConfirmarClick(Sender: TObject);
var
  nome, cpf: String;
begin
  nome := editProfessorNome.Text;
  cpf := editProfessorCPF.Text;

  if Self.currentProfessor = nil then begin
    Self.currentProfessor := TProfessor.Create;
    Self.currentProfessor.SetNome(nome);
    Self.currentProfessor.SetCpf(cpf);

    ModelProfessor.Insert(Self.currentProfessor);
    Self.Close;
    exit;
  end;

  Self.currentProfessor.SetNome(nome);
  Self.currentProfessor.SetCpf(cpf);
  ModelProfessor.Edit(Self.currentProfessor);
  Self.Close;
end;

constructor TformProfessor.Create(aProfessor: TProfessor;
  AOwner: TComponent);
begin
  inherited Create(AOwner);
  if aProfessor <> nil then begin
    Self.currentProfessor := aProfessor;
    editProfessorNome.Text := aProfessor.GetNome;
    editProfessorCPF.Text := aProfessor.GetCpf;
  end;
end;

procedure TformProfessor.editProfessorCPFKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = vk_return then buttonConfirmarClick(Sender);
end;

procedure TformProfessor.editProfessorNomeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = vk_return then editProfessorCPF.SetFocus;
end;

procedure TformProfessor.FormShow(Sender: TObject);
begin
  editProfessorNome.SetFocus;
end;

end.
