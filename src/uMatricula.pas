unit uMatricula;

interface

uses uEstudante, uTurma;

  type TMatricula = class
    private
      id: Integer;
      estudante: TEstudante;
      turma: TTurma;
    public
      procedure SetId(aId: Integer);
      function GetId: Integer;
      procedure SetEstudante(aEstudante: TEstudante);
      function GetEstudante: TEstudante;
      procedure SetTurma(aTurma: TTurma);
      function GetTurma: TTurma;
  end;

implementation

{ TMatricula }

function TMatricula.GetTurma: TTurma;
begin
  Result := Self.turma;
end;

function TMatricula.GetId: Integer;
begin
  Result := Self.id;
end;

function TMatricula.GetEstudante: TEstudante;
begin
  Result := Self.estudante;
end;

procedure TMatricula.SetTurma(aTurma: TTurma);
begin
  Self.turma := aTurma;
end;

procedure TMatricula.SetId(aId: Integer);
begin
  Self.id := aId;
end;

procedure TMatricula.SetEstudante(aEstudante: TEstudante);
begin
  Self.estudante := aEstudante;
end;

end.
