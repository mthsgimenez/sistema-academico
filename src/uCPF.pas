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
  firstDigit, secondDigit, soma: Integer;
begin
  Result := False;

  if aCPF.Length <> 11 then raise Exception.Create('CPF deve conter 11 digitos');

  soma := 0;
  for var i := 0 to 8 do begin
    try
      soma := soma + (StrToInt(aCPF[i]) * (10 - i));
    except
      raise Exception.Create('O CPF deve conter somente números');
    end;
  end;
  firstDigit := (soma * 10) mod 11;

  if StrToInt(aCPF[9]) <> firstDigit then raise Exception.Create('CPF inválido');

  soma := 0;
  for var i := 0 to 9 do begin
    try
      soma := soma + (StrToInt(aCPF[i]) * (11 - i));
    except
      raise Exception.Create('O CPF deve conter somente números');
    end;
  end;
  secondDigit := (soma * 10) mod 11;

  if StrToInt(aCPF[10]) <> secondDigit then raise Exception.Create('CPF inválido');

  Result := True;
end;

end.
