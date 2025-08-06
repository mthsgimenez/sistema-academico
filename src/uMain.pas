unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Comp.Client,
  Vcl.ComCtrls, Vcl.ExtCtrls, System.Generics.Collections, uDatabase, uEstudanteModel, uEstudante;

type
  TformMain = class(TForm)
    panelMain: TPanel;
    pageMain: TPageControl;
    tabAluno: TTabSheet;
    tabProfessor: TTabSheet;
    buttonEstudanteInserir: TButton;
    editEstudanteNome: TEdit;
    listEstudantes: TListBox;
    buttonEstudanteAtualizar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure buttonEstudanteInserirClick(Sender: TObject);
    procedure buttonEstudanteAtualizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    modelEstudante: TEstudanteModel;
  end;

var
  formMain: TformMain;

implementation

{$R *.dfm}

procedure TformMain.buttonEstudanteAtualizarClick(Sender: TObject);
var estudantes: TObjectList<TEstudante>;
begin
  listEstudantes.Clear;
  estudantes := Self.modelEstudante.GetEstudantes;

  for var estudante in estudantes do begin
    listEstudantes.AddItem(estudante.GetNome, nil);
  end;

  estudantes.Free;
end;

procedure TformMain.buttonEstudanteInserirClick(Sender: TObject);
var estudante: TEstudante;
begin
  estudante := TEstudante.Create;
  estudante.SetNome(editEstudanteNome.Text);

  Self.modelEstudante.Insert(estudante);
end;

procedure TformMain.FormCreate(Sender: TObject);
begin
  Self.modelEstudante := TEstudanteModel.Create(Database);
end;

end.
