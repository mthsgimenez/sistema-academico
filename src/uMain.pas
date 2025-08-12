unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Comp.Client,
  Vcl.ComCtrls, Vcl.ExtCtrls, System.Generics.Collections, uDatabase, uEstudanteModel, uEstudante,
  Vcl.Grids, uFormEstudante, uProfessorModel, uProfessor, uFormProfessor, uDisciplina, uDisciplinaModel, uFormDisciplina;

type
  TformMain = class(TForm)
    panelMain: TPanel;
    pageMain: TPageControl;
    tabEstudante: TTabSheet;
    tabProfessor: TTabSheet;
    buttonEstudanteInserir: TButton;
    buttonEstudanteDeletar: TButton;
    buttonEstudanteEditar: TButton;
    gridEstudantes: TStringGrid;
    gridProfessores: TStringGrid;
    buttonProfessorInserir: TButton;
    buttonProfessorEditar: TButton;
    buttonProfessorDeletar: TButton;
    tabDisciplina: TTabSheet;
    gridDisciplinas: TStringGrid;
    buttonDisciplinaEditar: TButton;
    buttonDisciplinaInserir: TButton;
    buttonDisciplinaDeletar: TButton;
    procedure buttonEstudanteInserirClick(Sender: TObject);
    procedure buttonEstudanteDeletarClick(Sender: TObject);
    procedure buttonEstudanteEditarClick(Sender: TObject);
    procedure UpdateStringGrid;
    procedure UpdateGridEstudante;
    procedure UpdateGridProfessor;
    procedure UpdateGridDisciplina;
    procedure tabEstudanteHide(Sender: TObject);
    procedure tabEstudanteShow(Sender: TObject);
    procedure tabProfessorShow(Sender: TObject);
    procedure buttonProfessorInserirClick(Sender: TObject);
    procedure buttonProfessorEditarClick(Sender: TObject);
    procedure buttonProfessorDeletarClick(Sender: TObject);
    procedure tabProfessorHide(Sender: TObject);
    procedure pageMainChange(Sender: TObject);
    procedure buttonDisciplinaInserirClick(Sender: TObject);
    procedure tabDisciplinaShow(Sender: TObject);
    procedure tabDisciplinaHide(Sender: TObject);
    procedure buttonDisciplinaEditarClick(Sender: TObject);
    procedure buttonDisciplinaDeletarClick(Sender: TObject);
  private
    { Private declarations }
  public
  end;

  TTab = (estudante, professor, disciplina);

var
  formMain: TformMain;

implementation

{$R *.dfm}

procedure TformMain.UpdateGridDisciplina;
var
  disciplinas: TObjectList<TDisciplina>;
  newRow, i: Integer;
begin
  i := gridDisciplinas.Row;
  gridDisciplinas.RowCount := 1;
  disciplinas := ModelDisciplina.GetDisciplinas;

  for var disciplina in disciplinas do begin
    newRow := gridDisciplinas.RowCount;
    gridDisciplinas.RowCount := newRow + 1;
    gridDisciplinas.Cells[0, newRow] := disciplina.GetId.ToString;
    gridDisciplinas.Cells[1, newRow] := disciplina.GetNome;
  end;

  if gridDisciplinas.RowCount > 1 then gridDisciplinas.FixedRows := 1;
  if i > gridDisciplinas.RowCount - 1 then i := i - 1;

  gridDisciplinas.Row := i;
end;

procedure TformMain.UpdateGridEstudante;
var
  estudantes: TObjectList<TEstudante>;
  newRow, i: Integer;
begin
  i := gridEstudantes.Row;
  gridEstudantes.RowCount := 1;
  estudantes := ModelEstudante.GetEstudantes;

  for var estudante in estudantes do begin
    newRow := gridEstudantes.RowCount;
    gridEstudantes.RowCount := newRow + 1;
    gridEstudantes.Cells[0, newRow] := estudante.GetId.ToString;
    gridEstudantes.Cells[1, newRow] := estudante.GetNome;
  end;

  if gridEstudantes.RowCount > 1 then gridEstudantes.FixedRows := 1;
  if i > gridEstudantes.RowCount - 1 then i := i - 1;

  gridEstudantes.Row := i;
end;

procedure TformMain.UpdateGridProfessor;
var
  professores: TObjectList<TProfessor>;
  newRow, i: Integer;
begin
  i := gridProfessores.Row;
  gridProfessores.RowCount := 1;
  professores := ModelProfessor.GetProfessores;

  for var professor in professores do begin
    newRow := gridProfessores.RowCount;
    gridProfessores.RowCount := newRow + 1;
    gridProfessores.Cells[0, newRow] := professor.GetId.ToString;
    gridProfessores.Cells[1, newRow] := professor.GetNome;
    gridProfessores.Cells[2, newRow] := professor.GetCpf;
  end;

  if gridProfessores.RowCount > 1 then gridProfessores.FixedRows := 1;
  if i > gridProfessores.RowCount - 1 then i := i - 1;

  gridProfessores.Row := i;
end;

procedure TformMain.UpdateStringGrid;
var
  tab: TTab;
begin
  tab := TTab(pageMain.ActivePage.TabIndex);

  case tab of
    estudante: UpdateGridEstudante;
    professor: UpdateGridProfessor;
    disciplina: UpdateGridDisciplina;
    else raise Exception.Create('UpdateStringGrid: Menu inválido');
  end;
end;

procedure TformMain.buttonDisciplinaDeletarClick(Sender: TObject);
var
  i, choice: Integer;
  disciplina: TDisciplina;
begin
  i := gridDisciplinas.Row - 1;
  if i = -1 then raise Exception.Create('Nenhuma disciplina selecionada');

  disciplina := ModelDisciplina.GetDisciplinaByIndex(i);

  choice := MessageDlg('Deseja mesmo deletar a disciplina: ' + disciplina.GetNome + '?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0);

  if choice = mrNo then exit;

  ModelDisciplina.Delete(disciplina);

  UpdateStringGrid;
end;

procedure TformMain.buttonDisciplinaEditarClick(Sender: TObject);
var
  form: TFormDisciplina;
  i: Integer;
  disciplina: TDisciplina;
begin
  i := gridDisciplinas.Row - 1;
  if i = -1 then raise Exception.Create('Nenhuma disciplina selecionada');

  disciplina := ModelDisciplina.GetDisciplinaByIndex(i);

  form := TformDisciplina.Create(disciplina, nil);
  form.ShowModal;
  form.Free;

  UpdateStringGrid;
end;

procedure TformMain.buttonDisciplinaInserirClick(Sender: TObject);
var
  form: TformDisciplina;
begin
  form := TformDisciplina.Create(nil, nil);
  form.ShowModal;
  form.Free;

  UpdateStringGrid;
end;

procedure TformMain.buttonEstudanteDeletarClick(Sender: TObject);
var
  i, choice: Integer;
  estudante: TEstudante;
begin
  i := gridEstudantes.Row - 1;
  if i = -1 then raise Exception.Create('Nenhum estudante selecionado');

  estudante := modelEstudante.GetEstudanteByIndex(i);

  choice := MessageDlg('Deseja mesmo deletar o estudante: ' + estudante.GetNome + '?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0);

  if choice = mrNo then exit;

  modelEstudante.Delete(estudante);
  UpdateStringGrid;
end;

procedure TformMain.buttonEstudanteEditarClick(Sender: TObject);
var
  form: TFormEstudante;
  i: Integer;
  estudante: TEstudante;
begin
  i := gridEstudantes.Row - 1;
  if i = -1 then raise Exception.Create('Nenhum estudante selecionado');

  estudante := modelEstudante.GetEstudanteByIndex(i);

  form := TformEstudante.Create(estudante, nil);
  form.ShowModal;
  form.Free;

  UpdateStringGrid;
end;

procedure TformMain.buttonEstudanteInserirClick(Sender: TObject);
var
  form: TFormEstudante;
begin
  form := TFormEstudante.Create(nil, nil);
  form.ShowModal;
  form.Free;

  UpdateStringGrid;
end;

procedure TformMain.buttonProfessorDeletarClick(Sender: TObject);
var
  i, choice: Integer;
  professor: TProfessor;
begin
  i := gridProfessores.Row - 1;
  if i = -1 then raise Exception.Create('Nenhum professor selecionado');

  professor := modelProfessor.GetProfessorByIndex(i);

  choice := MessageDlg('Deseja mesmo deletar o professor: ' + professor.GetNome + '?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0);

  if choice = mrNo then exit;

  modelProfessor.Delete(professor);
  UpdateStringGrid;
end;

procedure TformMain.buttonProfessorEditarClick(Sender: TObject);
var
  form: TFormProfessor;
  i: Integer;
  professor: TProfessor;
begin
  i := gridProfessores.Row - 1;
  if i = -1 then raise Exception.Create('Nenhum professor selecionado');

  professor := modelProfessor.GetProfessorByIndex(i);

  form := TFormProfessor.Create(professor, nil);
  form.ShowModal;
  form.Free;

  UpdateStringGrid;
end;

procedure TformMain.buttonProfessorInserirClick(Sender: TObject);
var
  form: TFormProfessor;
begin
  form := TFormProfessor.Create(nil, nil);
  form.ShowModal;
  form.Free;

  UpdateStringGrid;
end;

procedure TformMain.pageMainChange(Sender: TObject);
begin
  UpdateStringGrid;
end;

procedure TformMain.tabDisciplinaHide(Sender: TObject);
begin
  uDisciplinaModel.ModelDisciplina.Free;
end;

procedure TformMain.tabDisciplinaShow(Sender: TObject);
begin
  uDisciplinaModel.ModelDisciplina := TDisciplinaModel.Create(Database);

  gridDisciplinas.Cells[0, 0] := 'Código';
  gridDisciplinas.Cells[1, 0] := 'Nome';
  gridDisciplinas.ColWidths[0] := 100;
  gridDisciplinas.ColWidths[1] := gridDisciplinas.Width - 100;
end;

procedure TformMain.tabEstudanteHide(Sender: TObject);
begin
  uEstudanteModel.ModelEstudante.Free;
end;

procedure TformMain.tabEstudanteShow(Sender: TObject);
begin
  uEstudanteModel.ModelEstudante := TEstudanteModel.Create(Database);

  gridEstudantes.Cells[0, 0] := 'Código';
  gridEstudantes.Cells[1, 0] := 'Nome';
  gridEstudantes.ColWidths[0] := 100;
  gridEstudantes.ColWidths[1] := gridEstudantes.Width - 100;

  UpdateStringGrid;
end;

procedure TformMain.tabProfessorHide(Sender: TObject);
begin
  uProfessorModel.ModelProfessor.Free;
end;

procedure TformMain.tabProfessorShow(Sender: TObject);
begin
  uProfessorModel.ModelProfessor := TProfessorModel.Create(Database);

  gridProfessores.Cells[0, 0] := 'Código';
  gridProfessores.Cells[1, 0] := 'Nome';
  gridProfessores.Cells[2, 0] := 'CPF';

  gridProfessores.ColWidths[0] := 100;
  gridProfessores.ColWidths[1] := Round((gridEstudantes.Width - 100) / 2);
  gridProfessores.ColWidths[2] := Round((gridEstudantes.Width - 100) / 2);

  UpdateStringGrid;
end;

end.
