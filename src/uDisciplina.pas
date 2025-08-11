unit uDisciplina;

interface

  type TDisciplina = class
    private
      id: Integer;
      nome: String;
    public
      function GetId: Integer;
      function GetNome: String;
      procedure SetId(aId: Integer);
      procedure SetNome(aNome: String);
  end;

implementation

uses System.SysUtils;

{ TDisciplina }

function TDisciplina.GetId: Integer;
begin
  Result := Self.id;
end;

procedure TDisciplina.SetId(aId: Integer);
begin
  Self.id := aId;
end;

function TDisciplina.GetNome: String;
begin
  Result := Self.nome;
end;

procedure TDisciplina.SetNome(aNome: String);
begin
  if Trim(aNome) = '' then begin
    raise Exception.Create('Nome não pode ser vazio');
  end;

  Self.nome := aNome;
end;

end.
