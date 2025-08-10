unit uEstudanteModel;

interface

uses uDatabase, uEstudante, System.SysUtils, System.Generics.Collections;

type TEstudanteModel = class
  private
    Database: TDatabase;
    Estudantes: TObjectList<TEstudante>;
  public
    constructor Create(aDatabase: TDatabase);
    destructor Destroy;
    procedure Insert(aEstudante: TEstudante);
    function GetEstudantes: TObjectList<TEstudante>;
    procedure Delete(aEstudante: TEstudante);
    function GetEstudanteByIndex(aId: Integer): TEstudante;
    procedure Edit(aEstudante: TEstudante);
end;

var ModelEstudante: TEstudanteModel;

implementation

{ TEstudanteModel }

constructor TEstudanteModel.Create(aDatabase: TDatabase);
var estudante: TEstudante;
begin
  Self.Database := aDatabase;

  Self.Estudantes := TObjectList<TEstudante>.Create;
  Self.Database.FDQuery.SQL.Text := 'SELECT * FROM estudantes WHERE ativo=TRUE';
  Self.Database.FDQuery.Open;

  while not Self.Database.FDQuery.Eof do begin
    estudante := TEstudante.Create;
    estudante.SetId(Self.Database.FDQuery.FieldByName('id').AsInteger);
    estudante.SetNome(Self.Database.FDQuery.FieldByName('nome').AsString);

    Self.Estudantes.Add(estudante);
    Self.Database.FDQuery.Next;
  end;
  Self.Database.FDQuery.Close;
end;

procedure TEstudanteModel.Delete(aEstudante: TEstudante);
begin
  Self.Database.FDQuery.SQL.Text := 'UPDATE estudantes SET ativo=false WHERE id=' + aEstudante.GetId.ToString;
  Self.Database.FDQuery.ExecSQL;
  Self.Database.FDQuery.Close;
  Self.Estudantes.Remove(aEstudante);
end;

destructor TEstudanteModel.Destroy;
begin
  Self.Estudantes.Free;
  inherited;
end;

procedure TEstudanteModel.Edit(aEstudante: TEstudante);
begin
  Self.Database.FDQuery.SQL.Text := 'UPDATE estudantes SET nome=' + QuotedStr(aEstudante.GetNome) + 'WHERE id=' + aEstudante.GetId.ToString;
  Self.Database.FDQuery.ExecSQL;
  Self.Database.FDQuery.Close;
end;

function TEstudanteModel.GetEstudanteByIndex(aId: Integer): TEstudante;
begin
  Result := Self.Estudantes[aId];
end;

function TEstudanteModel.GetEstudantes: TObjectList<TEstudante>;
begin
  Result := Self.Estudantes;
end;

procedure TEstudanteModel.Insert(aEstudante: TEstudante);
var id: Integer;
begin
  Self.Estudantes.Add(aEstudante);
  Self.Database.FDQuery.SQL.Text := 'INSERT INTO estudantes (nome) VALUES (' + QuotedStr(aEstudante.GetNome) + ') RETURNING id';
  Self.Database.FDQuery.Open;

  id := Self.Database.FDQuery.FieldByName('id').AsInteger;
  aEstudante.SetId(id);

  Self.Database.FDQuery.Close;
end;

end.
