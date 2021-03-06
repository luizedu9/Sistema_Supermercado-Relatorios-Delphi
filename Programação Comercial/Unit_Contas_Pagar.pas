unit Unit_Contas_Pagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Unit_Persistencia,
  Vcl.Buttons;

type
  TForm_Contas_Pagar = class(TForm)
    Panel1: TPanel;
    sgdClientes: TStringGrid;
    Button1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure PintaGrid;
    procedure sgdClientesSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure AtualizaGrid();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Contas_Pagar: TForm_Contas_Pagar;
  codigoConta: Integer;

implementation

{$R *.dfm}

procedure TForm_Contas_Pagar.Button1Click(Sender: TObject);
begin
  if (codigoConta <> -1) then
  begin
    pagaContaForncedor(codigoConta);
    codigoConta := -1;
    ShowMessage('Conta Paga com sucesso !!');
  end
  else
    ShowMessage('Nenhuma Conta Selecionada');
  PintaGrid;
  AtualizaGrid;
end;

procedure TForm_Contas_Pagar.FormShow(Sender: TObject);
var
  pagar: Contas_Pagar;
  i: Integer;
  Valor: real;
begin
  codigoConta := -1;
  PintaGrid;
  pagar := Retorna_Contas_Pagar;
  for i := 0 to Length(pagar) - 1 do
  begin
    sgdClientes.RowCount := sgdClientes.RowCount + 1;
    sgdClientes.Cells[0, i + 1] := IntToStr(pagar[i].Codigo);
    sgdClientes.Cells[1, i + 1] := pagar[i].Vencimento;
    //sgdClientes.Cells[2, i + 1] := FloatToStr(pagar[i].Valor);

    Valor := StrToFloat(FormatFloat('0.00', pagar[i].Valor));
    sgdClientes.Cells[2, i + 1] := FloatToStr(Valor);

    sgdClientes.Cells[3, i + 1] := Retorna_Dados_Fornecedor(pagar[i].Fornecedor)
      .NomeFantasia;
    // sgdClientes.Cells[4,I+1]:= IntToStr(pagar[I].Pago);
    // sgdClientes.Cells[5,I+1]:= pagar[I].DataPagamento;
  end;

end;

procedure TForm_Contas_Pagar.PintaGrid;
begin
  sgdClientes.Cells[0, 0] := 'C�d.';
  sgdClientes.Cells[1, 0] := 'Vencimento';
  sgdClientes.Cells[2, 0] := 'Valor';
  sgdClientes.Cells[3, 0] := 'Fornecedor';
  // sgdClientes.Cells[4,0]:= 'Pago';
  // sgdClientes.Cells[5,0]:= 'Data Pagamento';
  sgdClientes.ColWidths[0] := 60;
  sgdClientes.ColWidths[1] := 100;
  sgdClientes.ColWidths[2] := 100;
  sgdClientes.ColWidths[3] := 250;
  // sgdClientes.ColWidths[4]:= 80;
  // sgdClientes.ColWidths[5]:= 90;
end;

procedure TForm_Contas_Pagar.sgdClientesSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  try
    codigoConta := StrToInt(sgdClientes.Cells[0, ARow]);
  except
    codigoConta := -1;
  end;

end;

procedure TForm_Contas_Pagar.AtualizaGrid();
var
  receber: Contas_Pagar;
  i: Integer;
  Valor: real;
begin
  receber := Retorna_Contas_Pagar;
  sgdClientes.RowCount := Length(receber) + 1;
  PintaGrid;
  for i := 0 to Length(receber) - 1 do
  begin
    sgdClientes.Cells[0, i + 1] := IntToStr(receber[i].Codigo);
    sgdClientes.Cells[1, i + 1] := receber[i].Vencimento;

    Valor := StrToFloat(FormatFloat('0.00', receber[i].Valor));
    sgdClientes.Cells[2, i + 1] := FloatToStr(Valor);

    sgdClientes.Cells[3, i + 1] := Retorna_Dados_Fornecedor
      (receber[i].Fornecedor).NomeFantasia;
    // sgdClientes.Cells[4,I+1]:= IntToStr(receber[I].Pago);
    // sgdClientes.Cells[5,I+1]:= receber[I].DataPagamento;
  end;
end;

end.
