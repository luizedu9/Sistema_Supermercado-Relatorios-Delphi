unit Unit_Caixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.ComCtrls, Unit_Persistencia;

type
  TForm_Caixa = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    sgdClientes: TStringGrid;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    btn_sair: TBitBtn;
    btn_gravar: TBitBtn;
    btn_cancelar: TBitBtn;
    btn_limpar: TBitBtn;
    btn_novo: TBitBtn;
    edit_cod: TLabeledEdit;
    edit_Descricao: TLabeledEdit;
    edit_Valor: TLabeledEdit;
    rad_tipoMoviment: TRadioGroup;
    Label1: TLabel;
    edit_Data: TDateTimePicker;
    Label2: TLabel;
    procedure btn_novoClick(Sender: TObject);
    procedure HabilitaTela(Habilita: Boolean);
    procedure HabilitaBotoes(Quais: String);
    procedure btn_limparClick(Sender: TObject);
    procedure LimpaTela;
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_sairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PintaGrid;
    procedure PopulaGrid();
    Function ColetaDados: Dado_Caixa;
    procedure btn_gravarClick(Sender: TObject);
    procedure edit_ValorExit(Sender: TObject);
    procedure edit_ValorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Caixa: TForm_Caixa;
  Novo: Boolean;

implementation

{$R *.dfm}

procedure TForm_Caixa.btn_cancelarClick(Sender: TObject);
begin
  if (Application.MessageBox('Deseja realmente cancelar?', 'Cancelar',
    MB_ICONQUESTION + MB_YESNO) = mrYes) then
  begin
    LimpaTela;
    HabilitaBotoes('10001');
    HabilitaTela(False);
  end;
end;

procedure TForm_Caixa.btn_gravarClick(Sender: TObject);
var
  dados: Dado_Caixa;
begin
  dados := ColetaDados;
  if rad_tipoMoviment.ItemIndex = 1 then
    insere_valor_caixa(dados.Descricao, dados.ValorMovimentacao * -1,
      dados.Data, dados.Hora)
  else
    insere_valor_caixa(dados.Descricao, dados.ValorMovimentacao, dados.Data,
      dados.Hora);

  HabilitaTela(False);
  HabilitaBotoes('10001');
  LimpaTela;
  PopulaGrid;
end;

procedure TForm_Caixa.btn_limparClick(Sender: TObject);
begin
  if (Application.MessageBox('Deseja realmente limpar todos os campos?',
    'Limpar Campos', MB_ICONQUESTION + MB_YESNO) = mrYes) then
  begin
    LimpaTela;
    edit_Descricao.SetFocus;
  end;
end;

Function TForm_Caixa.ColetaDados: Dado_Caixa;
begin
  Result.Descricao := edit_Descricao.Text;
  Result.Data := DateToStr(edit_Data.Date);
  Result.Hora := TimeToStr(Time);
  Result.Codigo := StrToInt(edit_cod.Text);
  Result.ValorMovimentacao := StrToFloat(edit_Valor.Text);
end;

procedure TForm_Caixa.edit_ValorExit(Sender: TObject);
var
  str: String;
begin
  str := CurrToStrF(StrToCurrDef(Trim(edit_Valor.Text), 0), ffNumber, 2);
  edit_Valor.Text := stringReplace(str, '.', '', []);
end;

procedure TForm_Caixa.edit_ValorKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', #8]) then
    Key := #0;
end;

procedure TForm_Caixa.LimpaTela;
begin
  edit_cod.Clear;
  edit_Descricao.Clear;
  edit_Valor.Clear;
end;

procedure TForm_Caixa.btn_novoClick(Sender: TObject);
begin
  Novo := True;
  HabilitaTela(True);
  HabilitaBotoes('01110');
  edit_cod.Text := Retorna_Proximo_Codigo_Caixa;
end;

procedure TForm_Caixa.btn_sairClick(Sender: TObject);
begin
  Form_Caixa.Close;
end;

procedure TForm_Caixa.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  PintaGrid;
  PopulaGrid;
end;

procedure TForm_Caixa.PopulaGrid();
var
  caixa: Dados_Caixa;
  I: Integer;
  valor: real;
begin
  caixa := Retorna_Caixa;
  sgdClientes.RowCount := Length(caixa) + 1;
  PintaGrid;
  for I := 0 to Length(caixa) - 1 do
  begin
    sgdClientes.Cells[0, I + 1] := IntToStr(caixa[I].Codigo);
    sgdClientes.Cells[1, I + 1] := caixa[I].Descricao;
    sgdClientes.Cells[2, I + 1] := caixa[I].Data;
    sgdClientes.Cells[3, I + 1] := caixa[I].Hora;

    valor := StrToFloat(FormatFloat('0.00', caixa[I].ValorMovimentacao));
    sgdClientes.Cells[4, I + 1] := FloatToStr(valor);

    valor := StrToFloat(FormatFloat('0.00', caixa[i].ValorAtual));
    sgdClientes.Cells[5, i + 1] := FloatToStr(valor);
  end;
end;

procedure TForm_Caixa.PintaGrid;
begin
  sgdClientes.Cells[0, 0] := 'Cód.';
  sgdClientes.Cells[1, 0] := 'Descrição';
  sgdClientes.Cells[2, 0] := 'Data';
  sgdClientes.Cells[3, 0] := 'Hora';
  sgdClientes.Cells[4, 0] := 'Valor Movimentação';
  sgdClientes.Cells[5, 0] := 'Valor Atual';
  sgdClientes.ColWidths[0] := 60;
  sgdClientes.ColWidths[1] := 300;
  sgdClientes.ColWidths[2] := 100;
  sgdClientes.ColWidths[3] := 80;
  sgdClientes.ColWidths[4] := 120;
  sgdClientes.ColWidths[5] := 120;
end;

procedure TForm_Caixa.HabilitaTela(Habilita: Boolean);
begin
  { edit_cod.Enabled:=      Habilita; }
  edit_Descricao.Enabled := Habilita;
  edit_Data.Enabled := Habilita;
  edit_Valor.Enabled := Habilita;
  Label1.Enabled := Habilita;
  rad_tipoMoviment.Enabled := Habilita;
end;

procedure TForm_Caixa.HabilitaBotoes(Quais: String);
begin
  if (Quais[1] = '0') then
    btn_novo.Enabled := False
  else
    btn_novo.Enabled := True;
  if (Quais[2] = '0') then
    btn_limpar.Enabled := False
  else
    btn_limpar.Enabled := True;
  if (Quais[3] = '0') then
    btn_cancelar.Enabled := False
  else
    btn_cancelar.Enabled := True;
  if (Quais[4] = '0') then
    btn_gravar.Enabled := False
  else
    btn_gravar.Enabled := True;
  if (Quais[5] = '0') then
    btn_sair.Enabled := False
  else
    btn_sair.Enabled := True;
end;

end.
