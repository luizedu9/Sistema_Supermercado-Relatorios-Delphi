unit Unit_Util;

interface

function isCNPJ(CNPJ: string): boolean;
function imprimeCNPJ(CNPJ: string): string;
function isCPF(CPF: string): boolean;
function imprimeCPF(CPF: string): string;
function removeMascara(Termo: String): String;
function TrocaVirgulaPonto(Termo: String): String;
function TransformaData(Data: TDate): String;
function isNumero(numero: String):Boolean;

implementation

uses System.SysUtils, StrUtils;

function isNumero(numero: String):Boolean;
var i:integer;
Const Numeros = ['0'..'9'];
Begin
    for I := 1 to Length(numero) do
        Begin
            if(not(numero[I] in Numeros))
              Then result:= false;
        End;
    result:= True;
End;

function TransformaData(Data: TDate): String;
var Dia, Mes, Ano: Word;
Begin
    DecodeDate(Data, Ano, Mes, Dia);
    case Mes of
      01: Result:= IntToStr(Dia)+'-Jan-'+IntToStr(Ano);
      02: Result:= IntToStr(Dia)+'-Feb-'+IntToStr(Ano);
      03: Result:= IntToStr(Dia)+'-Mar-'+IntToStr(Ano);
      04: Result:= IntToStr(Dia)+'-Apr-'+IntToStr(Ano);
      05: Result:= IntToStr(Dia)+'-May-'+IntToStr(Ano);
      06: Result:= IntToStr(Dia)+'-Jun-'+IntToStr(Ano);
      07: Result:= IntToStr(Dia)+'-Jul-'+IntToStr(Ano);
      08: Result:= IntToStr(Dia)+'-Aug-'+IntToStr(Ano);
      09: Result:= IntToStr(Dia)+'-Sep-'+IntToStr(Ano);
      10: Result:= IntToStr(Dia)+'-Oct-'+IntToStr(Ano);
      11: Result:= IntToStr(Dia)+'-Nov-'+IntToStr(Ano);
      12: Result:= IntToStr(Dia)+'-Dec-'+IntToStr(Ano);
    end;
End;

function removeMascara(Termo: String): String;
Begin
    Termo:= AnsiReplaceStr(Termo, '-','');
    Termo:= AnsiReplaceStr(Termo, ' ','');
    Termo:= AnsiReplaceStr(Termo, '.','');
    Termo:= AnsiReplaceStr(Termo, '(','');
    Termo:= AnsiReplaceStr(Termo, ')','');
    Termo:= AnsiReplaceStr(Termo, '/','');
    Result:= Trim(Termo);
End;

function TrocaVirgulaPonto(Termo: String): String;
Begin
    Termo:= AnsiReplaceStr(Termo, ',','.');
    Result:= Trim(Termo);
End;

function isCNPJ(CNPJ: string): boolean;
var   dig13, dig14: string;
    sm, i, r, peso: integer;
begin
// length - retorna o tamanho da string do CNPJ (CNPJ é um número formado por 14 dígitos)
  if ((CNPJ = '00000000000000') or (CNPJ = '11111111111111') or
      (CNPJ = '22222222222222') or (CNPJ = '33333333333333') or
      (CNPJ = '44444444444444') or (CNPJ = '55555555555555') or
      (CNPJ = '66666666666666') or (CNPJ = '77777777777777') or
      (CNPJ = '88888888888888') or (CNPJ = '99999999999999') or
      (length(CNPJ) <> 14))
     then begin
            isCNPJ := false;
            exit;
          end;

// "try" - protege o código para eventuais erros de conversão de tipo através da função "StrToInt"
  try
{ *-- Cálculo do 1o. Digito Verificador --* }
    sm := 0;
    peso := 2;
    for i := 12 downto 1 do
    begin
// StrToInt converte o i-ésimo caractere do CNPJ em um número
      sm := sm + (StrToInt(CNPJ[i]) * peso);
      peso := peso + 1;
      if (peso = 10)
         then peso := 2;
    end;
    r := sm mod 11;
    if ((r = 0) or (r = 1))
       then dig13 := '0'
    else str((11-r):1, dig13); // converte um número no respectivo caractere numérico

{ *-- Cálculo do 2o. Digito Verificador --* }
    sm := 0;
    peso := 2;
    for i := 13 downto 1 do
    begin
      sm := sm + (StrToInt(CNPJ[i]) * peso);
      peso := peso + 1;
      if (peso = 10)
         then peso := 2;
    end;
    r := sm mod 11;
    if ((r = 0) or (r = 1))
       then dig14 := '0'
    else str((11-r):1, dig14);

{ Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig13 = CNPJ[13]) and (dig14 = CNPJ[14]))
       then isCNPJ := true
    else isCNPJ := false;
  except
    isCNPJ := false
  end;
end;

function imprimeCNPJ(CNPJ: string): string;
begin
{ máscara do CNPJ: 99.999.999.9999-99 }
  imprimeCNPJ := copy(CNPJ, 1, 2) + '.' + copy(CNPJ, 3, 3) + '.' +
    copy(CNPJ, 6, 3) + '.' + copy(CNPJ, 9, 4) + '-' + copy(CNPJ, 13, 2);
end;

function isCPF(CPF: string): boolean;
var  dig10, dig11: string;
    s, i, r, peso: integer;
begin
// length - retorna o tamanho da string (CPF é um número formado por 11 dígitos)
  if ((CPF = '00000000000') or (CPF = '11111111111') or
      (CPF = '22222222222') or (CPF = '33333333333') or
      (CPF = '44444444444') or (CPF = '55555555555') or
      (CPF = '66666666666') or (CPF = '77777777777') or
      (CPF = '88888888888') or (CPF = '99999999999') or
      (length(CPF) <> 11))
     then begin
              isCPF := false;
              exit;
            end;

// try - protege o código para eventuais erros de conversão de tipo na função StrToInt
  try
{ *-- Cálculo do 1o. Digito Verificador --* }
    s := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
// StrToInt converte o i-ésimo caractere do CPF em um número
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig10 := '0'
    else str(r:1, dig10); // converte um número no respectivo caractere numérico

{ *-- Cálculo do 2o. Digito Verificador --* }
    s := 0;
    peso := 11;
    for i := 1 to 10 do
    begin
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig11 := '0'
    else str(r:1, dig11);

{ Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig10 = CPF[10]) and (dig11 = CPF[11]))
       then isCPF := true
    else isCPF := false;
  except
    isCPF := false
  end;
end;

function imprimeCPF(CPF: string): string;
begin
  imprimeCPF := copy(CPF, 1, 3) + '.' + copy(CPF, 4, 3) + '.' +
    copy(CPF, 7, 3) + '-' + copy(CPF, 10, 2);
end;

end.
