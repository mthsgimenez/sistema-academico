unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Comp.Client,
  Vcl.ComCtrls, Vcl.ExtCtrls, System.Generics.Collections, uDatabase, uEstudanteModel, uEstudante,
  Vcl.Grids, uFormEstudante;

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
    procedure buttonEstudanteInserirClick(Sender: TObject);
    procedure buttonEstudanteDeletarClick(Sender: TObject);
    procedure buttonEstudanteEditarClick(Sender: TObject);
    procedure UpdateStringGrid;
    procedure tabEstudanteHide(Sender: TObject);
    procedure tabEstudanteShow(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  formMain: TformMain;

implementation

{$R *.dfm}

procedure TformMain.UpdateStringGrid;
var
  estudantes: TObjectList<TEstudante>;
  newRow: Integer;
begin
  gridEstudantes.RowCount := 1;
  estudantes := ModelEstudante.GetEstudantes;

  for var estudante in estudantes do begin
    newRow := gridEstudantes.RowCount;
    gridEstudantes.RowCount := newRow + 1;
    gridEstudantes.Cells[0, newRow] := estudante.GetId.ToString;
    gridEstudantes.Cells[1, newRow] := estudante.GetNome;
  end;

  if gridEstudantes.RowCount > 1 then gridEstudantes.FixedRows := 1;
end;

procedure TformMain.buttonEstudanteDeletarClick(Sender: TObject);
var
  i, choice: Integer;
  estudante: TEstudante;
begin
  i := gridEstudantes.Row - 1;
  if i = -1 then raise Exception.Create('Nenhum usuário selecionado');

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
  if i = -1 then raise Exception.Create('Nenhum usuário selecionado');

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

end.
