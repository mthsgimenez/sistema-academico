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
  end;

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

end.
