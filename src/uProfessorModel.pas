unit uProfessorModel;

interface

uses uDatabase, uProfessor, System.SysUtils, System.Generics.Collections;

  type TProfessorModel = class
    private
      Database: TDatabase;
      Professores: TObjectList<TProfessor>;
    public
      constructor Create(aDatabase: TDatabase);
      destructor Destroy;
      procedure Insert(aProfessor: TProfessor);
      function GetProfessores: TObjectList<TProfessor>;
      procedure Delete(aProfessor: TProfessor);
      function GetProfessorByIndex(aIndex: Integer): TProfessor;
      procedure Edit(aProfessor: TProfessor);
  end;

var ModelProfessor: TProfessorModel;

implementation

{ TProfessorModel }

constructor TProfessorModel.Create(aDatabase: TDatabase);
var professor: TProfessor;
begin
  Self.Database := aDatabase;

  Self.Professores := TObjectList<TProfessor>.Create;

  Self.Database.FDQuery.SQL.Text := 'SELECT * FROM professores WHERE ativo=true';
  Self.Database.FDQuery.Open;

  while not Self.Database.FDQuery.Eof do begin
    professor := TProfessor.Create;
    professor.SetNome(Self.Database.FDQuery.FieldByName('nome').AsString);
    professor.SetId(Self.Database.FDQuery.FieldByName('id').AsInteger);
    professor.SetCpf(Self.Database.FDQuery.FieldByName('cpf').AsString);

    Self.Professores.Add(professor);

    Self.Database.FDQuery.Next;
  end;
  Self.Database.FDQuery.Close;

end;

procedure TProfessorModel.Delete(aProfessor: TProfessor);
begin
  Self.Professores.Remove(aProfessor);

  Self.Database.FDQuery.SQL.Text := 'UPDATE professores SET ativo=false WHERE id=' + aProfessor.GetId.ToString;
  Self.Database.FDQuery.ExecSQL;
  Self.Database.FDQuery.Close;
end;

destructor TProfessorModel.Destroy;
begin
  Self.Professores.Free;
  inherited;
end;

procedure TProfessorModel.Edit(aProfessor: TProfessor);
begin
  Self.Database.FDQuery.SQL.Text := 'UPDATE professores SET nome=' + QuotedStr(aProfessor.GetNome) + ', cpf=' + QuotedStr(aProfessor.GetCpf) + ' WHERE id=' + aProfessor.GetId.ToString;
  Self.Database.FDQuery.ExecSQL;
  Self.Database.FDQuery.Close;
end;

function TProfessorModel.GetProfessorByIndex(aIndex: Integer): TProfessor;
begin
  if (aIndex < 0) or (aIndex > Self.Professores.Count - 1) then raise Exception.Create('GetProfessorByIndex: aIndex deve estar dentro dos limites da lista');

  Result := Self.Professores[aIndex];
end;

function TProfessorModel.GetProfessores: TObjectList<TProfessor>;
begin
  Result := Self.Professores;
end;

procedure TProfessorModel.Insert(aProfessor: TProfessor);
var id: Integer;
begin
  Self.Database.FDQuery.SQL.Text := 'INSERT INTO professores (nome, cpf) VALUES (' + QuotedStr(aProfessor.GetNome) + ', ' + QuotedStr(aProfessor.GetCpf) + ') RETURNING id';
  Self.Database.FDQuery.Open;

  id := Self.Database.FDQuery.FieldByName('id').AsInteger;

  aProfessor.SetId(id);
  Self.Professores.Add(aProfessor);
end;

end.
