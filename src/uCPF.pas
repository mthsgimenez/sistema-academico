unit uCPF;

interface

  type TCPF = class
    private
      cpf: String;
    public
      function Validate(aCPF: String): Boolean;
      constructor Create(aCPF: String);
      function GetCPF: String;
      procedure SetCPF(aCPF: String);
  end;

implementation

uses System.SysUtils;

{ TCPF }

constructor TCPF.Create(aCPF: String);
begin
  Self.SetCPF(aCPF);
end;

function TCPF.GetCPF: String;
begin
  Result := Self.cpf;
end;

procedure TCPF.SetCPF(aCPF: String);
begin
  Validate(Trim(aCPF));

  Self.cpf := Trim(aCPF);
end;

function TCPF.Validate(aCPF: String): Boolean;
var
  dig10, dig11: String;
  soma, i, resto, peso: Integer;
begin
  Result := False;

  if aCPF.Length <> 11 then raise Exception.Create('CPF deve conter 11 digitos');
  for i := 1 to 11 do begin
    if not (aCPF[i] in ['0'..'9']) then raise Exception.Create('CPF deve conter somente números');
  end;

  soma := 0;
  peso := 10;
  for i := 1 to 9 do begin
    soma := soma + (StrToInt(aCPF[i]) * peso);
    peso := peso - 1;
  end;
  resto := (soma * 10) mod 11;
  if resto > 9 then dig10 := '0' else dig10 := IntToStr(resto);

  if dig10 <> aCPF[10] then raise Exception.Create('CPF inválido');

  soma := 0;
  peso := 11;
  for i := 1 to 10 do begin
    soma := soma + (StrToInt(aCPF[i]) * peso);
    peso := peso - 1;
  end;
  resto := (soma * 10) mod 11;
  if resto > 9 then dig11 := '0' else dig11 := IntToStr(resto);

  if dig11 <> aCPF[11] then raise Exception.Create('CPF inválido');

  Result := True;
end;

end.
