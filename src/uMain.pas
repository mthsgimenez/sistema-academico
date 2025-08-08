unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Comp.Client,
  Vcl.ComCtrls, Vcl.ExtCtrls, System.Generics.Collections, uDatabase, uEstudanteModel, uEstudante,
  Vcl.Grids;

type
  TformMain = class(TForm)
    panelMain: TPanel;
    pageMain: TPageControl;
    tabAluno: TTabSheet;
    tabProfessor: TTabSheet;
    buttonEstudanteInserir: TButton;
    editEstudanteNome: TEdit;
    listEstudantes: TListBox;
    buttonEstudanteDeletar: TButton;
    buttonEstudanteEditar: TButton;
    buttonEstudanteEditarAcao: TButton;
    procedure FormCreate(Sender: TObject);
    procedure buttonEstudanteInserirClick(Sender: TObject);
    procedure buttonEstudanteDeletarClick(Sender: TObject);
    procedure buttonEstudanteEditarClick(Sender: TObject);
    procedure buttonEstudanteEditarAcaoClick(Sender: TObject);
    procedure AtualizarListBox;
  private
    { Private declarations }
  public
    modelEstudante: TEstudanteModel;
  end;

var
  formMain: TformMain;

implementation

{$R *.dfm}

procedure TformMain.AtualizarListBox;
var estudantes: TObjectList<TEstudante>;
begin
  listEstudantes.Clear;
  estudantes := Self.modelEstudante.GetEstudantes;

  for var estudante in estudantes do begin
    listEstudantes.AddItem(estudante.GetNome, estudante);
  end;
end;

procedure TformMain.buttonEstudanteDeletarClick(Sender: TObject);
var i: Integer;
estudante: TEstudante;
begin
  i := listEstudantes.ItemIndex;
  if i = -1 then raise Exception.Create('Nenhum usuário selecionado');

  estudante := modelEstudante.GetEstudanteByIndex(i);
  modelEstudante.Delete(estudante);
  AtualizarListBox;
end;

procedure TformMain.buttonEstudanteEditarAcaoClick(Sender: TObject);
var i: Integer;
estudante: TEstudante;
begin
  i := listEstudantes.ItemIndex;
  if i = -1 then raise Exception.Create('Nenhum usuário selecionado');

  estudante := modelEstudante.GetEstudanteByIndex(i);

  estudante.SetNome(editEstudanteNome.Text);
  modelEstudante.Edit(estudante);
  buttonEstudanteInserir.Visible := True;
  buttonEstudanteEditarAcao.Visible := False;
  editEstudanteNome.Clear;
  AtualizarListBox;
end;

procedure TformMain.buttonEstudanteEditarClick(Sender: TObject);
var i: Integer;
estudante: TEstudante;
begin
  i := listEstudantes.ItemIndex;
  if i = -1 then raise Exception.Create('Nenhum usuário selecionado');

  estudante := modelEstudante.GetEstudanteByIndex(i);

  editEstudanteNome.Text := estudante.GetNome;
  buttonEstudanteInserir.Visible := False;
  buttonEstudanteEditarAcao.Visible := True;
end;

procedure TformMain.buttonEstudanteInserirClick(Sender: TObject);
var estudante: TEstudante;
begin
  estudante := TEstudante.Create;
  estudante.SetNome(editEstudanteNome.Text);

  Self.modelEstudante.Insert(estudante);

  editEstudanteNome.Clear;
  AtualizarListBox;
end;

procedure TformMain.FormCreate(Sender: TObject);
begin
  Self.modelEstudante := TEstudanteModel.Create(Database);
  AtualizarListBox;
end;

end.
