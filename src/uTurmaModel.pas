unit uTurmaModel;

interface

uses
  uTurma, uDatabase, System.Generics.Collections, System.SysUtils,
  uProfessor, uProfessorModel,
  uDisciplina, uDisciplinaModel;

  type TTurmaModel = class
    private
      Database: TDatabase;
      Turmas: TObjectList<TTurma>;
      ModelProfessor: TProfessorModel;
      ModelDisciplina: TDisciplinaModel;
    public
      constructor Create(aDatabase: TDatabase; aProfessorModel: TProfessorModel; aDisciplinaModel: TDisciplinaModel);
      destructor Destroy;
      procedure Insert(aTurma: TTurma);
      procedure Delete(aTurma: TTurma);
      function GetTurmas: TObjectList<TTurma>;
      function GetTurmaByIndex(aIndex: Integer): TTurma;
      function GetTurmaById(aId: Integer): TTurma;
      procedure Edit(aTurma: TTurma);
  end;

  var ModelTurma: TTurmaModel;

implementation

{ TTurmaModel }

constructor TTurmaModel.Create(aDatabase: TDatabase;
  aProfessorModel: TProfessorModel; aDisciplinaModel: TDisciplinaModel);
var
  idTurma, idProfessor, idDisciplina: Integer;
  turma: TTurma;
  professor: TProfessor;
  disciplina: TDisciplina;
begin
  if aDatabase = nil then raise Exception.Create('TTurmaModel.Create: aDatabase não pode ser nulo');
  if aProfessorModel = nil then raise Exception.Create('TTurmaModel.Create: aProfessorModel não pode ser nulo');
  if aDisciplinaModel = nil then raise Exception.Create('TTurmaModel.Create: aDisciplinaModel não pode ser nulo');

  Self.Database := aDatabase;
  Self.ModelProfessor := aProfessorModel;
  Self.ModelDisciplina := aDisciplinaModel;

  Self.Turmas := TObjectList<TTurma>.Create;

  Self.Database.FDQuery.SQL.Text := 'SELECT * FROM turmas WHERE ativo=true';
  Self.Database.FDQuery.Open;

  while not Self.Database.FDQuery.Eof do begin
    idProfessor := Self.Database.FDQuery.FieldByName('id_professor').AsInteger;
    professor := ModelProfessor.GetProfessorById(idProfessor);

    idDisciplina := Self.Database.FDQuery.FieldByName('id_disciplina').AsInteger;
    disciplina := ModelDisciplina.GetDisciplinaById(idDisciplina);

    idDisciplina := Self.Database.FDQuery.FieldByName('id').AsInteger;

    turma := TTurma.Create;
    turma.SetId(idDisciplina);
    turma.SetProfessor(professor);
    turma.SetDisciplina(disciplina);

    Self.Turmas.Add(turma);

    Self.Database.FDQuery.Next;
  end;
  Self.Database.FDQuery.Close;

end;

procedure TTurmaModel.Delete(aTurma: TTurma);
begin
  Self.Turmas.Remove(aTurma);

  Self.Database.FDQuery.SQL.Text := 'UPDATE turmas SET ativo=false WHERE id=' + aTurma.GetId.ToString;
  Self.Database.FDQuery.ExecSQL;
  Self.Database.FDQuery.Close;
end;

destructor TTurmaModel.Destroy;
begin
  Self.Turmas.Free;
  inherited;
end;

procedure TTurmaModel.Edit(aTurma: TTurma);
begin
  Self.Database.FDQuery.SQL.Text := 'UPDATE turmas SET id_professor=' + aTurma.GetProfessor.GetId.ToString + ', id_disciplina=' + aTurma.GetDisciplina.GetId.ToString + ' WHERE id=' + aTurma.GetId.ToString;
  Self.Database.FDQuery.ExecSQL;
  Self.Database.FDQuery.Close;
end;

function TTurmaModel.GetTurmaById(aId: Integer): TTurma;
begin
  if aId < 1 then raise Exception.Create('GetTurmaById: Id inválido');

  for var turma in Self.Turmas do begin
    if turma.GetId = aId then begin
      Result := turma;
      Exit;
    end;
  end;

  raise Exception.Create('Turma com id: ' + aId.ToString + ' não encontrado');
end;

function TTurmaModel.GetTurmaByIndex(aIndex: Integer): TTurma;
begin
  if (aIndex < 0) or (aIndex > Self.Turmas.Count - 1) then raise Exception.Create('GetTurmaByIndex: aIndex deve estar dentro dos limites da lista');

  Result := Self.Turmas[aIndex];
end;

function TTurmaModel.GetTurmas: TObjectList<TTurma>;
begin
  Result := Self.Turmas;
end;

procedure TTurmaModel.Insert(aTurma: TTurma);
var
  id: Integer;
begin
  Self.Database.FDQuery.SQL.Text := 'INSERT INTO turmas (id_professor, id_disciplina) VALUES (' + aTurma.GetProfessor.GetId.ToString + ', ' + aTurma.GetDisciplina.GetId.ToString + ') RETURNING id';
  Self.Database.FDQuery.Open;

  id := Self.Database.FDQuery.FieldByName('id').AsInteger;

  Self.Database.FDQuery.Close;

  aTurma.SetId(id);
  Self.Turmas.Add(aTurma);
end;

end.
