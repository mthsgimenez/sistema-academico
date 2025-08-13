unit uMatriculaModel;

interface

uses
  uMatricula, uDatabase, System.Generics.Collections, System.SysUtils,
  uEstudante, uEstudanteModel,
  uTurma, uTurmaModel;

type
  TMatriculaModel = class
  private
    Database: TDatabase;
    Matriculas: TObjectList<TMatricula>;
    ModelEstudante: TEstudanteModel;
    ModelTurma: TTurmaModel;
  public
    constructor Create(aDatabase: TDatabase; aEstudanteModel: TEstudanteModel; aTurmaModel: TTurmaModel);
    destructor Destroy; override;
    procedure Insert(aMatricula: TMatricula);
    procedure Delete(aMatricula: TMatricula);
    function GetMatriculas: TObjectList<TMatricula>;
    function GetMatriculaByIndex(aIndex: Integer): TMatricula;
    procedure Edit(aMatricula: TMatricula);
  end;

var
  ModelMatricula: TMatriculaModel;

implementation

{ TMatriculaModel }

constructor TMatriculaModel.Create(aDatabase: TDatabase; aEstudanteModel: TEstudanteModel; aTurmaModel: TTurmaModel);
var
  idMatricula, idEstudante, idTurma: Integer;
  matricula: TMatricula;
  estudante: TEstudante;
  turma: TTurma;
begin
  if aDatabase = nil then raise Exception.Create('TMatriculaModel.Create: aDatabase não pode ser nulo');
  if aEstudanteModel = nil then raise Exception.Create('TMatriculaModel.Create: aEstudanteModel não pode ser nulo');
  if aTurmaModel = nil then raise Exception.Create('TMatriculaModel.Create: aTurmaModel não pode ser nulo');

  Self.Database := aDatabase;
  Self.ModelEstudante := aEstudanteModel;
  Self.ModelTurma := aTurmaModel;

  Self.Matriculas := TObjectList<TMatricula>.Create;

  Self.Database.FDQuery.SQL.Text := 'SELECT * FROM matriculas WHERE ativo=true';
  Self.Database.FDQuery.Open;

  while not Self.Database.FDQuery.Eof do begin
    idEstudante := Self.Database.FDQuery.FieldByName('id_estudante').AsInteger;
    estudante := ModelEstudante.GetEstudanteById(idEstudante);

    idTurma := Self.Database.FDQuery.FieldByName('id_turma').AsInteger;
    turma := ModelTurma.GetTurmaById(idTurma);

    idMatricula := Self.Database.FDQuery.FieldByName('id').AsInteger;

    matricula := TMatricula.Create;
    matricula.SetId(idMatricula);
    matricula.SetEstudante(estudante);
    matricula.SetTurma(turma);

    Self.Matriculas.Add(matricula);

    Self.Database.FDQuery.Next;
  end;
  Self.Database.FDQuery.Close;
end;

procedure TMatriculaModel.Delete(aMatricula: TMatricula);
begin
  Self.Matriculas.Remove(aMatricula);

  Self.Database.FDQuery.SQL.Text := 'UPDATE matriculas SET ativo=false WHERE id=' + aMatricula.GetId.ToString;
  Self.Database.FDQuery.ExecSQL;
  Self.Database.FDQuery.Close;
end;

destructor TMatriculaModel.Destroy;
begin
  Self.Matriculas.Free;
  inherited;
end;

procedure TMatriculaModel.Edit(aMatricula: TMatricula);
begin
  Self.Database.FDQuery.SQL.Text := 'UPDATE matriculas SET id_estudante=' + aMatricula.GetEstudante.GetId.ToString + ', id_turma=' + aMatricula.GetTurma.GetId.ToString + ' WHERE id=' + aMatricula.GetId.ToString;
  Self.Database.FDQuery.ExecSQL;
  Self.Database.FDQuery.Close;
end;

function TMatriculaModel.GetMatriculaByIndex(aIndex: Integer): TMatricula;
begin
  if (aIndex < 0) or (aIndex > Self.Matriculas.Count - 1) then raise Exception.Create('GetMatriculaByIndex: aIndex deve estar dentro dos limites da lista');

  Result := Self.Matriculas[aIndex];
end;

function TMatriculaModel.GetMatriculas: TObjectList<TMatricula>;
begin
  Result := Self.Matriculas;
end;

procedure TMatriculaModel.Insert(aMatricula: TMatricula);
var
  id: Integer;
begin
  Self.Database.FDQuery.SQL.Text := 'INSERT INTO matriculas (id_estudante, id_turma) VALUES (' + aMatricula.GetEstudante.GetId.ToString + ', ' + aMatricula.GetTurma.GetId.ToString + ') RETURNING id';
  Self.Database.FDQuery.Open;

  id := Self.Database.FDQuery.FieldByName('id').AsInteger;

  Self.Database.FDQuery.Close;

  aMatricula.SetId(id);
  Self.Matriculas.Add(aMatricula);
end;

end.
