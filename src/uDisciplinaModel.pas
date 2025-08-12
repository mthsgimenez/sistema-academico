unit uDisciplinaModel;

interface

uses uDatabase, uDisciplina, System.SysUtils, System.Generics.Collections;

type
  TDisciplinaModel = class
  private
    Database: TDatabase;
    Disciplinas: TObjectList<TDisciplina>;
  public
    constructor Create(aDatabase: TDatabase);
    destructor Destroy; override;
    procedure Insert(aDisciplina: TDisciplina);
    function GetDisciplinas: TObjectList<TDisciplina>;
    procedure Delete(aDisciplina: TDisciplina);
    function GetDisciplinaByIndex(aIndex: Integer): TDisciplina;
    function GetDisciplinaById(aId: Integer): TDisciplina;
    procedure Edit(aDisciplina: TDisciplina);
  end;

var
  ModelDisciplina: TDisciplinaModel;

implementation

{ TDisciplinaModel }

constructor TDisciplinaModel.Create(aDatabase: TDatabase);
var
  disciplina: TDisciplina;
begin
  if aDatabase = nil then raise Exception.Create('TDisciplinaModel.Create: aDatabase não pode ser nulo');

  Self.Database := aDatabase;

  Self.Disciplinas := TObjectList<TDisciplina>.Create;
  Self.Database.FDQuery.SQL.Text := 'SELECT * FROM disciplinas WHERE ativo=TRUE';
  Self.Database.FDQuery.Open;

  while not Self.Database.FDQuery.Eof do begin
    disciplina := TDisciplina.Create;
    disciplina.SetId(Self.Database.FDQuery.FieldByName('id').AsInteger);
    disciplina.SetNome(Self.Database.FDQuery.FieldByName('nome').AsString);

    Self.Disciplinas.Add(disciplina);
    Self.Database.FDQuery.Next;
  end;
  Self.Database.FDQuery.Close;
end;

procedure TDisciplinaModel.Delete(aDisciplina: TDisciplina);
begin
  Self.Database.FDQuery.SQL.Text := 'UPDATE disciplinas SET ativo=false WHERE id=' + aDisciplina.GetId.ToString;
  Self.Database.FDQuery.ExecSQL;
  Self.Database.FDQuery.Close;
  Self.Disciplinas.Remove(aDisciplina);
end;

destructor TDisciplinaModel.Destroy;
begin
  Self.Disciplinas.Free;
  inherited;
end;

procedure TDisciplinaModel.Edit(aDisciplina: TDisciplina);
begin
  Self.Database.FDQuery.SQL.Text := 'UPDATE disciplinas SET nome=' + QuotedStr(aDisciplina.GetNome) + ' WHERE id=' + aDisciplina.GetId.ToString;
  Self.Database.FDQuery.ExecSQL;
  Self.Database.FDQuery.Close;
end;

function TDisciplinaModel.GetDisciplinaById(aId: Integer): TDisciplina;
begin
  if aId < 1 then raise Exception.Create('GetDisciplinaById: Id inválido');

  for var disciplina in Self.Disciplinas do begin
    if disciplina.GetId = aId then begin
      Result := disciplina;
      Exit;
    end;
  end;

  raise Exception.Create('Disciplina com id: ' + aId.ToString + ' não encontrada');
end;

function TDisciplinaModel.GetDisciplinaByIndex(aIndex: Integer): TDisciplina;
begin
  if (aIndex > Self.Disciplinas.Count - 1) or (aIndex < 0) then
    raise Exception.Create('GetDisciplinaByIndex: aIndex deve estar dentro dos limites da lista');

  Result := Self.Disciplinas[aIndex];
end;

function TDisciplinaModel.GetDisciplinas: TObjectList<TDisciplina>;
begin
  Result := Self.Disciplinas;
end;

procedure TDisciplinaModel.Insert(aDisciplina: TDisciplina);
var
  id: Integer;
begin
  Self.Disciplinas.Add(aDisciplina);
  Self.Database.FDQuery.SQL.Text := 'INSERT INTO disciplinas (nome) VALUES (' + QuotedStr(aDisciplina.GetNome) + ') RETURNING id';
  Self.Database.FDQuery.Open;

  id := Self.Database.FDQuery.FieldByName('id').AsInteger;
  aDisciplina.SetId(id);

  Self.Database.FDQuery.Close;
end;

end.

