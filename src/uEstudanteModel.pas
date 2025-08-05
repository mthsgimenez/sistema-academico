unit uEstudanteModel;

interface

uses uDatabase, uEstudante, System.SysUtils, System.Generics.Collections;

type TEstudanteModel = class
  private
    Database: TDatabase;
  public
    constructor Create(aDatabase: TDatabase);
    procedure Insert(aEstudante: TEstudante);
    function GetEstudantes: TObjectList<TEstudante>;
end;

implementation

{ TEstudanteModel }

constructor TEstudanteModel.Create(aDatabase: TDatabase);
begin
  Self.Database := aDatabase;
end;

function TEstudanteModel.GetEstudantes: TObjectList<TEstudante>;
var lista: TObjectList<TEstudante>;
var estudante: TEstudante;
begin
  lista := TObjectList<TEstudante>.Create;
  Self.Database.FDQuery.SQL.Text := 'SELECT * FROM estudantes;';
  Self.Database.FDQuery.Open;

  while not Self.Database.FDQuery.Eof do begin
    estudante := TEstudante.Create;
    estudante.SetId(Self.Database.FDQuery.FieldByName('id').AsInteger);
    estudante.SetNome(Self.Database.FDQuery.FieldByName('nome').AsString);

    lista.Add(estudante);
    Self.Database.FDQuery.Next;
  end;
  Self.Database.FDQuery.Close;

  Result := lista;
end;

procedure TEstudanteModel.Insert(aEstudante: TEstudante);
begin
  Self.Database.FDQuery.SQL.Text := 'INSERT INTO estudantes (nome) VALUES (' + QuotedStr(aEstudante.GetNome) + ');';
  Self.Database.FDQuery.ExecSQL;
  Self.Database.FDQuery.Close;
end;

end.
