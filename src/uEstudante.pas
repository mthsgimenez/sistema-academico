unit uEstudante;

interface

  type TEstudante = class
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

{ TEstudante }

function TEstudante.GetId: Integer;
begin
  Result := Self.id;
end;

procedure TEstudante.SetId(aId: Integer);
begin
  Self.id := aId;
end;

function TEstudante.GetNome: String;
begin
  Result := Self.nome;
end;

procedure TEstudante.SetNome(aNome: String);
begin
  if Trim(aNome) = '' then begin
    raise Exception.Create('Nome não pode ser vazio');
  end;

  Self.nome := aNome;
end;

end.
