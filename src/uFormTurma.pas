unit uFormTurma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.Generics.Collections,
  uTurma, uTurmaModel, uDisciplina, uProfessor, uProfessorModel, uDisciplinaModel;

type
  TformTurma = class(TForm)
    panelTurma: TPanel;
    comboTurmaProfessor: TComboBox;
    labelTurmaProfessor: TLabel;
    labelTurmaDisciplina: TLabel;
    comboTurmaDisciplina: TComboBox;
    buttonConfirmar: TButton;
    procedure FormShow(Sender: TObject);
    procedure buttonConfirmarClick(Sender: TObject);
  private
    currentTurma: TTurma;
  public
    constructor Create(aTurma: TTurma; AOwner: TComponent);
  end;

var
  formTurma: TformTurma;

implementation

{$R *.dfm}

procedure TformTurma.buttonConfirmarClick(Sender: TObject);
var
  selectedProfessor, selectedDisciplina: Integer;
  professor: TProfessor;
  disciplina: TDisciplina;
begin
  selectedProfessor := comboTurmaProfessor.ItemIndex;
  selectedDisciplina := comboTurmaDisciplina.ItemIndex;

  if selectedProfessor = -1 then raise Exception.Create('Nenhum professor selecionado');
  if selectedDisciplina = -1 then raise Exception.Create('Nenhuma disciplina selecionada');

  professor := ModelProfessor.GetProfessorByIndex(selectedProfessor);
  disciplina := ModelDisciplina.GetDisciplinaByIndex(selectedDisciplina);

  if Self.currentTurma = nil then begin
    Self.currentTurma := TTurma.Create;
    Self.currentTurma.SetProfessor(professor);
    Self.currentTurma.SetDisciplina(disciplina);

    ModelTurma.Insert(Self.currentTurma);
    Self.Close;
    exit;
  end;

  Self.currentTurma.SetProfessor(professor);
  Self.currentTurma.SetDisciplina(disciplina);
  ModelTurma.Edit(Self.currentTurma);
  Self.Close;
end;

constructor TformTurma.Create(aTurma: TTurma; AOwner: TComponent);
var
  professores: TObjectList<TProfessor>;
  disciplinas: TObjectList<TDisciplina>;
begin
  inherited Create(AOwner);

  professores := ModelProfessor.GetProfessores;
  disciplinas := ModelDisciplina.GetDisciplinas;

  for var professor in professores do begin
    comboTurmaProfessor.AddItem(professor.GetNome, nil);
  end;

  for var disciplina in disciplinas do begin
    comboTurmaDisciplina.AddItem(disciplina.GetNome, nil);
  end;

  if aTurma <> nil then begin
    Self.currentTurma := aTurma;
  end;

end;

procedure TformTurma.FormShow(Sender: TObject);
begin
  comboTurmaProfessor.SetFocus;
end;

end.
