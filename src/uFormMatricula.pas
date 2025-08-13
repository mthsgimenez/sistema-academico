unit uFormMatricula;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.Generics.Collections,
  uMatricula, uMatriculaModel, uTurma, uTurmaModel, uEstudante, uEstudanteModel;

type
  TformMatricula = class(TForm)
    panelMatricula: TPanel;
    labelMatriculaEstudante: TLabel;
    labelMatriculaTurma: TLabel;
    comboMatriculaEstudante: TComboBox;
    comboMatriculaTurma: TComboBox;
    buttonConfirmar: TButton;
    procedure FormShow(Sender: TObject);
    procedure buttonConfirmarClick(Sender: TObject);
  private
    currentMatricula: TMatricula;
  public
    constructor Create(aMatricula: TMatricula; AOwner: TComponent);
  end;

var
  formMatricula: TformMatricula;

implementation

{$R *.dfm}

procedure TformMatricula.buttonConfirmarClick(Sender: TObject);
var
  selectedEstudante, selectedTurma: Integer;
  estudante: TEstudante;
  turma: TTurma;
begin
  selectedEstudante := comboMatriculaEstudante.ItemIndex;
  selectedTurma := comboMatriculaTurma.ItemIndex;

  if selectedEstudante = -1 then raise Exception.Create('Nenhum estudante selecionado');
  if selectedTurma = -1 then raise Exception.Create('Nenhuma turma selecionada');

  estudante := ModelEstudante.GetEstudanteByIndex(selectedEstudante);
  turma := ModelTurma.GetTurmaByIndex(selectedTurma);

  if Self.currentMatricula = nil then begin
    Self.currentMatricula := TMatricula.Create;
    Self.currentMatricula.SetEstudante(estudante);
    Self.currentMatricula.SetTurma(turma);

    ModelMatricula.Insert(Self.currentMatricula);
    Self.Close;
    exit;
  end;

  Self.currentMatricula.SetEstudante(estudante);
  Self.currentMatricula.SetTurma(turma);
  ModelMatricula.Edit(Self.currentMatricula);
  Self.Close;
end;

constructor TformMatricula.Create(aMatricula: TMatricula; AOwner: TComponent);
var
  estudantes: TObjectList<TEstudante>;
  turmas: TObjectList<TTurma>;
begin
  inherited Create(AOwner);

  estudantes := ModelEstudante.GetEstudantes;
  turmas := ModelTurma.GetTurmas;

  for var estudante in estudantes do begin
    comboMatriculaEstudante.AddItem(estudante.GetNome, nil);
  end;

  for var turma in turmas do begin
    comboMatriculaTurma.AddItem(turma.GetDisciplina.GetNome + ' - ' + turma.GetProfessor.GetNome, nil);
  end;

  if aMatricula <> nil then begin
    Self.currentMatricula := aMatricula;
  end;
end;

procedure TformMatricula.FormShow(Sender: TObject);
begin
  comboMatriculaEstudante.SetFocus;
end;

end.

