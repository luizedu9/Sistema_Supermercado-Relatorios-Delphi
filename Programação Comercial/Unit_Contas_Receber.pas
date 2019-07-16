unit Unit_Contas_Receber;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Unit_Persistencia,
  Vcl.Grids, Vcl.Buttons;

type
  TForm_Receber_Conta = class(TForm)
    Panel1: TPanel;
    sgdClientes: TStringGrid;
    Button1: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PintaGrid();
    procedure sgdClientesSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure AtualizaGrid();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Receber_Conta: TForm_Receber_Conta;
  codigoConta: Integer;

implementation

{$R *.dfm}

procedure TForm_Receber_Conta.Button1Click(Sender: TObject);
begin
  if (codigoConta <> -1) then
  begin
    pagaConta(codigoConta);
    codigoConta := -1;
    ShowMessage('Conta recebida com sucesso !!');
  end
  else
    ShowMessage('Nenhuma Conta Selecionada');
  PintaGrid;
  AtualizaGrid;
end;

procedure TForm_Receber_Conta.FormShow(Sender: TObject);
var
  receber: Contas_Receber;
  i: Integer;
  valor: real;
begin
  codigoConta := -1;
  PintaGrid;
  receber := Retorna_Contas_Receber;
  for i := 0 to Length(receber) - 1 do
  begin
    sgdClientes.RowCount := sgdClientes.RowCount + 1;
    sgdClientes.Cells[0, i + 1] := IntToStr(receber[i].Codigo);
    sgdClientes.Cells[1, i + 1] := receber[i].Vencimento;

    valor := StrToFloat(FormatFloat('0.00', receber[i].valor));
    sgdClientes.Cells[2, i + 1] := FloatToStr(valor);

    sgdClientes.Cells[3, i + 1] := Retorna_Dados_Cliente
      (receber[i].Cliente).Nome;
    // sgdClientes.Cells[4,I+1]:= IntToStr(receber[I].Pago);
    // sgdClientes.Cells[5,I+1]:= receber[I].DataPagamento;
  end;

end;

procedure TForm_Receber_Conta.PintaGrid;
begin
  sgdClientes.Cells[0, 0] := 'Cód.';
  sgdClientes.Cells[1, 0] := 'Vencimento';
  sgdClientes.Cells[2, 0] := 'Valor';
  sgdClientes.Cells[3, 0] := 'Cliente';
  // sgdClientes.Cells[4,0]:= 'Pago';
  // sgdClientes.Cells[5,0]:= 'Data Pagamento';
  sgdClientes.ColWidths[0] := 60;
  sgdClientes.ColWidths[1] := 100;
  sgdClientes.ColWidths[2] := 100;
  sgdClientes.ColWidths[3] := 200;
  // sgdClientes.ColWidths[4]:= 80;
  // sgdClientes.ColWidths[5]:= 90;
end;

procedure TForm_Receber_Conta.sgdClientesSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  try
    codigoConta := StrToInt(sgdClientes.Cells[0, ARow]);
  except
    codigoConta := -1;
  end;
end;

procedure TForm_Receber_Conta.AtualizaGrid();
var
  receber: Contas_Receber;
  i: Integer;
begin
  receber := Retorna_Contas_Receber;
  sgdClientes.RowCount := Length(receber) + 1;
  PintaGrid;
  for i := 0 to Length(receber) - 1 do
  begin
    sgdClientes.Cells[0, i + 1] := IntToStr(receber[i].Codigo);
    sgdClientes.Cells[1, i + 1] := receber[i].Vencimento;
    sgdClientes.Cells[2, i + 1] := FloatToStr(receber[i].valor);
    sgdClientes.Cells[3, i + 1] := Retorna_Dados_Cliente
      (receber[i].Cliente).Nome;
    // sgdClientes.Cells[4,I+1]:= IntToStr(receber[I].Pago);
    // sgdClientes.Cells[5,I+1]:= receber[I].DataPagamento;
  end;
end;

end.
