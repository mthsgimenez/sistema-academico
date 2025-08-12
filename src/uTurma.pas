unit uTurma;

interface

uses uProfessor, uDisciplina;

  type TTurma = class
    private
      id: Integer;
      professor: TProfessor;
      disciplina: TDisciplina;
    public
      procedure SetId(aId: Integer);
      function GetId: Integer;
      procedure SetProfessor(aProfessor: TProfessor);
      function GetProfessor: TProfessor;
      procedure SetDisciplina(aDisciplina: TDisciplina);
      function GetDisciplina: TDisciplina;
  end;

implementation

{ TTurma }

function TTurma.GetDisciplina: TDisciplina;
begin
  Result := Self.disciplina;
end;

function TTurma.GetId: Integer;
begin
  Result := Self.id;
end;

function TTurma.GetProfessor: TProfessor;
begin
  Result := Self.professor;
end;

procedure TTurma.SetDisciplina(aDisciplina: TDisciplina);
begin
  Self.disciplina := aDisciplina;
end;

procedure TTurma.SetId(aId: Integer);
begin
  Self.id := aId;
end;

procedure TTurma.SetProfessor(aProfessor: TProfessor);
begin
  Self.professor := aProfessor;
end;

end.
