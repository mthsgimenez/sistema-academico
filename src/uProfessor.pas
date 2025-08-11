unit uProfessor;

interface

  type TProfessor = class
    private
      id: Integer;
      nome: String;
      cpf: String;
    public
      procedure SetId(aId: Integer);
      function GetId: Integer;
      procedure SetNome(aNome: String);
      function GetNome: String;
      procedure SetCpf(aCpf: String);
      function GetCpf: String;
  end;

implementation

uses System.SysUtils;

{ TProfessor }

function TProfessor.GetCpf: String;
begin
  Result := Self.cpf;
end;

function TProfessor.GetId: Integer;
begin
  Result := Self.id;
end;

function TProfessor.GetNome: String;
begin
  Result := Self.nome;
end;

procedure TProfessor.SetCpf(aCpf: String);
begin
  if aCpf.Length <> 11 then raise Exception.Create('CPF inválido');

  Self.cpf := aCpf;
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
