unit uProfessor;

interface

uses uCPF;

  type TProfessor = class
    private
      id: Integer;
      nome: String;
      cpf: TCPF;
    public
      procedure SetId(aId: Integer);
      function GetId: Integer;
      procedure SetNome(aNome: String);
      function GetNome: String;
      procedure SetCPF(aCPF: TCPF);
      function GetCPF: String;
  end;

implementation

uses System.SysUtils;

{ TProfessor }

function TProfessor.GetCPF: String;
begin
  Result := Self.cpf.GetCPF;
end;

function TProfessor.GetId: Integer;
begin
  Result := Self.id;
end;

function TProfessor.GetNome: String;
begin
  Result := Self.nome;
end;

procedure TProfessor.SetCPF(aCpf: TCPF);
begin
  Self.cpf := aCPF;
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
