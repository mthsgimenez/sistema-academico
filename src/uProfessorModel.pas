unit uProfessorModel;

interface

uses uDatabase, uProfessor, System.SysUtils, System.Generics.Collections, uCPF;

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
      function GetProfessorById(aId: Integer): TProfessor;
      procedure Edit(aProfessor: TProfessor);
  end;

var ModelProfessor: TProfessorModel;

implementation

{ TProfessorModel }

constructor TProfessorModel.Create(aDatabase: TDatabase);
var
  professor: TProfessor;
  nome: String;
  id: Integer;
  cpf: TCPF;
begin
  if aDatabase = nil then raise Exception.Create('TProfessorModel.Create: aDatabase não pode ser nulo');

  Self.Database := aDatabase;

  Self.Professores := TObjectList<TProfessor>.Create;

  Self.Database.FDQuery.SQL.Text := 'SELECT * FROM professores WHERE ativo=true';
  Self.Database.FDQuery.Open;

  while not Self.Database.FDQuery.Eof do begin
    nome := Self.Database.FDQuery.FieldByName('nome').AsString;
    id := Self.Database.FDQuery.FieldByName('id').AsInteger;
    cpf := TCPF.Create(Self.Database.FDQuery.FieldByName('cpf').AsString);

    professor := TProfessor.Create;
    professor.SetNome(nome);
    professor.SetId(id);
    professor.SetCPF(cpf);

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

function TProfessorModel.GetProfessorById(aId: Integer): TProfessor;
begin
  if aId < 1 then raise Exception.Create('GetProfessorById: Id inválido');

  for var professor in Self.Professores do begin
    if professor.GetId = aId then begin
      Result := professor;
      Exit;
    end;
  end;

  raise Exception.Create('Professor com id: ' + aId.ToString + ' não encontrado');
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
