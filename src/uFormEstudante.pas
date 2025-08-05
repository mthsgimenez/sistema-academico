unit uFormEstudante;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Generics.Collections, uDataBase, uEstudante, uEstudanteModel;

type
  TFormEstudante = class(TForm)
    editNomeEstudante: TEdit;
    listEstudantes: TListBox;
    buttonInsertEstudante: TButton;
    buttonAtualizarEstudantes: TButton;
    procedure buttonInsertEstudanteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure buttonAtualizarEstudantesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEstudante: TFormEstudante;
  Model: TEstudanteModel;

implementation

{$R *.dfm}

procedure TFormEstudante.FormCreate(Sender: TObject);
begin
  Model := TEstudanteModel.Create(Database);
end;

procedure TFormEstudante.buttonAtualizarEstudantesClick(Sender: TObject);
var estudantes: TObjectList<TEstudante>;
begin
  listEstudantes.Clear;
  estudantes := Model.GetEstudantes;

  for var estudante in estudantes do begin
    listEstudantes.AddItem(estudante.GetNome, nil);
  end;

  estudantes.Free;
end;

procedure TFormEstudante.buttonInsertEstudanteClick(Sender: TObject);
var
  nome: String;
  estudante: TEstudante;
begin
  nome := editNomeEstudante.Text;

  estudante := TEstudante.Create;
  estudante.SetNome(nome);

  Model.Insert(estudante);
end;

end.