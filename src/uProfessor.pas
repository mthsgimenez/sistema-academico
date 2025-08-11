unit uProfessor;

interface

  type TProfessor = class
    private
      id: Integer;
      nome: String;
    public
      procedure SetId(aId: Integer);
      function GetId: Integer;
      procedure SetNome(aNome: String);
      function GetNome: String;
  end;

implementation

uses System.SysUtils;

{ TProfessor }

function TProfessor.GetId: Integer;
begin
  Result := Self.id;
end;

function TProfessor.GetNome: String;
begin
  Result := Self.nome;
end;

procedure TProfessor.SetId(aId: Integer);
begin
  Self.id := aId;
end;

procedure TProfessor.SetNome(aNome: String);
begin
  if Trim(aNome) = '' then raise Exception.Create('Nome não pode ser vazio');

  Self.nome := aNome;
end;

end.
