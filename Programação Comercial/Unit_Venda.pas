unit Unit_Venda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Unit_Persistencia, Vcl.Mask, Vcl.Samples.Spin;

type
  TForm_Venda = class(TForm)
    GroupBox1: TGroupBox;
    edit_codVenda: TLabeledEdit;
    edit_Data: TLabeledEdit;
    GroupBox2: TGroupBox;
    Panel3: TPanel;
    edit_CodProduto: TLabeledEdit;
    Edit_Descricao: TLabeledEdit;
    Edit_Preco: TLabeledEdit;
    Edit_Quantidade: TLabeledEdit;
    Btn_Inserir: TBitBtn;
    Btn_Remover: TBitBtn;
    sgd_Produto: TStringGrid;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    lab_qtdParcelas: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit_Total: TLabeledEdit;
    edit_Entrada: TLabeledEdit;
    spin_qtdParcelas: TSpinEdit;
    edit_valorParcelas: TLabeledEdit;
    Panel4: TPanel;
    rad_formaPagamento: TRadioGroup;
    cbx_Cliente: TComboBox;
    edit_cpf: TMaskEdit;
    Panel2: TPanel;
    btn_novo: TBitBtn;
    btn_limpar: TBitBtn;
    btn_cancelar: TBitBtn;
    btn_gravar: TBitBtn;
    btn_sair: TBitBtn;
    procedure btn_novoClick(Sender: TObject);
    procedure btn_limparClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_gravarClick(Sender: TObject);
    procedure btn_sairClick(Sender: TObject);

    procedure HabilitaBotoes(Quais: String);
    procedure HabilitaTela(Habilita: Boolean);
    procedure LimpaTela;
    procedure PintaGrid;
    Procedure TotalizaCompra;
    Function ColetaProdutos: Produtos_Venda;
    function VerificaPreenchimento: Boolean;
    procedure edit_CodProdutoChange(Sender: TObject);
    procedure edit_EntradaChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Btn_InserirClick(Sender: TObject);
    procedure edit_CodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_QuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure Btn_RemoverClick(Sender: TObject);
    procedure rad_formaPagamentoClick(Sender: TObject);
    procedure spin_qtdParcelasChange(Sender: TObject);
    procedure PreencheComboCliente;
    procedure cbx_ClienteSelect(Sender: TObject);
    procedure edit_EntradaKeyPress(Sender: TObject; var Key: Char);
    procedure edit_EntradaExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  function aCFAbrir_NFCe_Daruma(pszCPF, pszNome, pszLgr, psznro, pszBairoc, pszcMun,
    pszMunicipio, pszUF,pszCEP: String): Integer;
    stdCall; external 'DarumaFramework.dll';
  function aCFEfetuarPagamento_NFCe_Daruma(pszFormaPgto, pszValor:String): Integer;
    stdCall; external 'DarumaFramework.dll';
  function aCFVender_NFCe_Daruma(pszCargaTributaria, pszQuantidade, pszPrecoUnitario,
    pszTipoDescAcresc, pszValorDescAcresc, pszcCodigoItem, pszUnidadeMedida,
    pszDescricaoItem : String):Integer;
    stdCall; external 'DarumaFramework.dll';
  function aCFTotalizar_NFCe_Daruma(pszTipoDescAcresc, pszValorDescAcresc: String): Integer;
    stdCall; external 'DarumaFramework.dll';
  function tCFEncerrar_NFCe_Daruma(pszInfoAdic:String):Integer;
    stdCall; external 'DarumaFramework.dll';
var
  Form_Venda: TForm_Venda;
  Linha: Integer;
  Novo: Boolean;

implementation

{$R *.dfm}

Procedure TForm_Venda.TotalizaCompra;
var
  I: Integer;
  Total: Real;
Begin
  Total := 0;
  For I := 1 to sgd_Produto.RowCount - 1 do
    Total := Total + StrToFloat(sgd_Produto.Cells[4, I]);
  Edit_Total.Text := FloatToStr(Total);
End;

procedure TForm_Venda.HabilitaBotoes(Quais: String);
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

procedure TForm_Venda.HabilitaTela(Habilita: Boolean);
begin
  { edit_codVenda.Enabled:=   Habilita;
    edit_Data.Enabled:=       Habilita; }
  edit_CodProduto.Enabled := Habilita;
  Edit_Descricao.Enabled := Habilita;
  Edit_Preco.Enabled := Habilita;
  Edit_Quantidade.Enabled := Habilita;
  // Edit_Total.Enabled:=      Habilita;
  sgd_Produto.Enabled := Habilita;
  Label1.Enabled := Habilita;
  rad_formaPagamento.Enabled := Habilita;
  Btn_Inserir.Enabled := Habilita;
  Btn_Remover.Enabled := Habilita;
end;

procedure TForm_Venda.rad_formaPagamentoClick(Sender: TObject);
var
  valorParcelas: Real;
begin
  if rad_formaPagamento.ItemIndex = 1 then
  begin
    edit_Entrada.Enabled := True;
    lab_qtdParcelas.Enabled := True;
    spin_qtdParcelas.Enabled := True;
    Label2.Enabled := True;
    cbx_Cliente.Enabled := True;
    Label3.Enabled := True;
    edit_cpf.Enabled := True;
    valorParcelas := (StrToFloat(Edit_Total.Text) -
      StrToFloat(edit_Entrada.Text)) / spin_qtdParcelas.Value;
    edit_valorParcelas.Text := FloatToStr(valorParcelas);
  end
  else
  begin
    edit_Entrada.Enabled := False;
    lab_qtdParcelas.Enabled := False;
    spin_qtdParcelas.Enabled := False;
    Label2.Enabled := False;
    cbx_Cliente.Enabled := False;
    Label3.Enabled := False;
    edit_cpf.Enabled := False;
  end;
end;

procedure TForm_Venda.LimpaTela;
begin
  edit_codVenda.Clear;
  edit_Data.Clear;
  edit_CodProduto.Clear;
  Edit_Descricao.Clear;
  Edit_Preco.Clear;
  Edit_Quantidade.Clear;
  rad_formaPagamento.ItemIndex := 0;
  spin_qtdParcelas.Text := '2';
  edit_Entrada.Text := '0,00';
  Edit_Total.Text := '0,00';
  edit_valorParcelas.Text := '0,00';
  sgd_Produto.RowCount := 1;
  cbx_Cliente.ItemIndex := -1;
  edit_cpf.Clear;
end;

procedure TForm_Venda.PintaGrid;
begin
  sgd_Produto.Cells[0, 0] := 'Cód.';
  sgd_Produto.Cells[1, 0] := 'Descrição';
  sgd_Produto.Cells[2, 0] := 'Preço';
  sgd_Produto.Cells[3, 0] := 'Quantidade';
  sgd_Produto.Cells[4, 0] := 'Total';
  sgd_Produto.ColWidths[0] := 60;
  sgd_Produto.ColWidths[1] := 200;
  sgd_Produto.ColWidths[2] := 80;
  sgd_Produto.ColWidths[3] := 80;
  sgd_Produto.ColWidths[4] := 80;
end;

Function TForm_Venda.ColetaProdutos: Produtos_Venda;
Var
  I: Integer;
begin
  SetLength(Result, sgd_Produto.RowCount - 1);
  for I := 1 to sgd_Produto.RowCount - 1 do
  Begin
    Result[I - 1].Codigo := StrToInt(sgd_Produto.Cells[0, I]);
    Result[I - 1].Preco := StrToFloat(sgd_Produto.Cells[2, I]);
    Result[I - 1].Quantidade := StrToInt(sgd_Produto.Cells[3, I]);
  End;
end;

function TForm_Venda.VerificaPreenchimento: Boolean;
begin
  if (sgd_Produto.RowCount = 1) then
    Result := False
  else
    Result := True;
end;

procedure TForm_Venda.edit_CodProdutoChange(Sender: TObject);
Var
  Produto_Temp: Dados_Produto;
  precoProduto: Real;
begin
  if (edit_CodProduto.Text = '') Then
    Produto_Temp.Codigo := -1
  Else
    Produto_Temp := Retorna_Dados_Produto(StrToInt(edit_CodProduto.Text));
  if (Produto_Temp.Codigo <> -1) Then
  Begin
    Edit_Descricao.Text := Produto_Temp.Descricao;
    precoProduto := StrToFloat(FormatFloat('0.00', Produto_Temp.Preco_Venda));
    Edit_Preco.Text := FloatToStr(precoProduto);
  End
  Else
  Begin
    Edit_Descricao.Text := '';
    Edit_Preco.Text := '';
  End;
end;

procedure TForm_Venda.edit_CodProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) Then
    Edit_Quantidade.SetFocus;
end;

procedure TForm_Venda.Edit_QuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) Then
    Btn_Inserir.Click;
end;

procedure TForm_Venda.FormShow(Sender: TObject);
begin
  PintaGrid;
  Linha := 1;
end;

procedure TForm_Venda.btn_cancelarClick(Sender: TObject);
begin
  if (Application.MessageBox('Deseja realmente cancelar?', 'Cancelar',
    MB_ICONQUESTION + MB_YESNO) = mrYes) then
  begin
    LimpaTela;
    HabilitaBotoes('10001');
    HabilitaTela(False);
  end;
end;

procedure TForm_Venda.edit_EntradaChange(Sender: TObject);
var
  valorParcelas: Real;
begin
  valorParcelas := (StrToFloat(Edit_Total.Text) - StrToFloat(edit_Entrada.Text))
    / spin_qtdParcelas.Value;
  edit_valorParcelas.Text := FloatToStr(valorParcelas);
end;

procedure TForm_Venda.edit_EntradaExit(Sender: TObject);
var str : String;
begin
str := CurrToStrF(StrToCurrDef(Trim(edit_Entrada.Text),0),ffNumber,2);
edit_Entrada.text := stringReplace(str, '.', '', []);
end;

procedure TForm_Venda.edit_EntradaKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8]) then key :=#0;
end;

procedure TForm_Venda.btn_gravarClick(Sender: TObject);
Var
  Prods: Produtos_Venda;
  forma_pagamento: Boolean;
  Total, entrada, valor_parcela: Real;
  qtdeParcelas, codigo_cliente, I: Integer;
  data_vencimento: tdatetime;
  Parte: TStringList;
  salva: Boolean;
  retorno: Integer;
begin
  if (VerificaPreenchimento()) then
  // verifica se pelo menos um produto foi inserido
  begin
    salva := True;
    Prods := ColetaProdutos;
    Grava_Dados_Venda(edit_codVenda.Text, Now,
      StrToFloat(Edit_Total.Text), Prods);

    if (rad_formaPagamento.ItemIndex = 0) then
    // se a forma de pagamento for a vista
    begin
      ShowMessage('Venda a Vista');
      insere_valor_caixa('Venda a Vista', StrToFloat(Edit_Total.Text),
        DateToStr(Date), TimeToStr(Time));
    end
    else
    begin
       if (rad_formaPagamento.ItemIndex = 1) then
       // se a forma de pagamento for a prazo
       begin
        if (cbx_Cliente.ItemIndex <> -1) then
        // neste caso, e obrigatorio informar o cliente
        begin
          ShowMessage('Venda a Prazo');
          entrada := StrToFloat(edit_Entrada.Text);
          Total := StrToFloat(Edit_Total.Text);
          qtdeParcelas := StrToInt(spin_qtdParcelas.Text);
          Parte := TStringList.Create;
          Parte.Delimiter := '-';
          Parte.DelimitedText := cbx_Cliente.Items[cbx_Cliente.ItemIndex];
          codigo_cliente := StrToInt(Parte[0]);
          data_vencimento := Date;
          data_vencimento := data_vencimento + 30;
          valor_parcela := StrToFloat(edit_valorParcelas.Text);
          for I := 1 to qtdeParcelas do
          begin
            insere_contas_receber(DateToStr(data_vencimento), valor_parcela,
              codigo_cliente);
            data_vencimento := data_vencimento + 30;
          end;
          insere_valor_caixa('Entrada', entrada, DateToStr(Date),
            TimeToStr(Time));
        end
        else // caso o cliente nao seja informado, acontece este erro
        begin
          ShowMessage('Não foi possível salvar. Informe o cliente.');
          cbx_Cliente.SetFocus;
          salva := False;
        end;
       end  // final da condicional da forma de pagamento a prazo
       else
       // se a forma de pagamento for cartao
       begin
          //ShowMessage(Edit_Total.Text);
          retorno:= aCFAbrir_NFCe_Daruma('12312312312', 'Daruma Developer Community',
            'Av. Shishima Hifumi', '2911','Urbanova', '3549904', 'São José dos Campos',
            'SP', '12244000');
          retorno:= aCFVender_NFCe_Daruma('I1', '1,00', Edit_Total.Text, 'D$', '0,00', '7896230301146',
            'UN', 'Bolacha');
          retorno:= aCFTotalizar_NFCe_Daruma('D$','0,00');
          retorno:= aCFEfetuarPagamento_NFCe_Daruma('4',Edit_Total.Text);
          retorno:= tCFEncerrar_NFCe_Daruma('Fechaaa');
          ShowMessage('Venda com Cartão');
          insere_valor_caixa('Venda com Cartao', StrToFloat(Edit_Total.Text),
                             DateToStr(Date), TimeToStr(Time));
       end;
    end;
  end
  else // caso nao tenha sido informado nenhum produto, acontece este erro
  begin
    ShowMessage('Não foi possível salvar. Insira ao menos um produto.');
    edit_CodProduto.SetFocus;
    salva := False;
  end;

  if (salva) then
  begin
    HabilitaTela(False);
    //ShowMessage(FloatToStr(ultimo_valor_caixa));
    HabilitaBotoes('10001');
    LimpaTela;
  end;
end;

procedure TForm_Venda.Btn_InserirClick(Sender: TObject);
Var
  Produto_Temp: Dados_Produto;
  precoProduto: Real;
  valorParcelas: Real;
begin
  if (Edit_Quantidade.Text = '') Then
  Begin
    Application.MessageBox(PChar('Informe a Quantidade de Produtos'),
      'Informe a Quantidade', MB_ICONWARNING + MB_OK);
    Edit_Quantidade.SetFocus;
    Exit;
  End;
  if (edit_CodProduto.Text = '') Then
    Produto_Temp.Codigo := -1
  Else
    Produto_Temp := Retorna_Dados_Produto(StrToInt(edit_CodProduto.Text));
  if (Produto_Temp.Codigo = -1) Then
  Begin
    Application.MessageBox
      (PChar('Não Existe um produto cadastrado com o código = ' +
      QuotedStr(edit_CodProduto.Text)), 'Produto não Cadastrado',
      MB_ICONERROR + MB_OK);
    Exit;
  End;
  if not((sgd_Produto.RowCount = 2) And (sgd_Produto.Cells[0, 1] = '')) Then
    sgd_Produto.RowCount := sgd_Produto.RowCount + 1;
  sgd_Produto.Cells[0, sgd_Produto.RowCount - 1] :=
    IntToStr(Produto_Temp.Codigo);
  sgd_Produto.Cells[1, sgd_Produto.RowCount - 1] := Produto_Temp.Descricao;

  precoProduto := StrToFloat(FormatFloat('0.00', Produto_Temp.Preco_Venda));
  sgd_Produto.Cells[2, sgd_Produto.RowCount - 1] := FloatToStr(precoProduto);

  sgd_Produto.Cells[3, sgd_Produto.RowCount - 1] := Edit_Quantidade.Text;
  sgd_Produto.Cells[4, sgd_Produto.RowCount - 1] :=
    FloatToStr(StrToFloat(Edit_Quantidade.Text) * precoProduto);
  TotalizaCompra;

  if rad_formaPagamento.ItemIndex = 1
    then begin
          valorParcelas := (StrToFloat(Edit_Total.Text) - StrToFloat(edit_Entrada.Text))
    / spin_qtdParcelas.Value;
  edit_valorParcelas.Text := FloatToStr(valorParcelas);
         end;

end;

procedure TForm_Venda.btn_limparClick(Sender: TObject);
begin
  If (Application.MessageBox('Deseja realmente limpar todos os campos?',
    'Limpar Campos', MB_ICONQUESTION + MB_YESNO) = mrYes) Then
    LimpaTela;
end;

procedure TForm_Venda.btn_novoClick(Sender: TObject);
begin
  Novo := True;
  HabilitaTela(True);
  HabilitaBotoes('01110');
  edit_codVenda.Text := Retorna_Proximo_Codigo_Venda;
  edit_Data.Text := DateToStr(Now);
  PintaGrid;
  edit_CodProduto.SetFocus;
  PreencheComboCliente;
end;

procedure TForm_Venda.Btn_RemoverClick(Sender: TObject);
var
  I: Integer;
begin
  if sgd_Produto.RowCount = 2 then
  Begin
    sgd_Produto.Cells[0, 1] := '';
    sgd_Produto.Cells[1, 1] := '';
    sgd_Produto.Cells[2, 1] := '';
    sgd_Produto.Cells[3, 1] := '';
    sgd_Produto.Cells[4, 1] := '';
    sgd_Produto.RowCount := 1;
    TotalizaCompra;
    Exit;
  End;

  for I := Linha to sgd_Produto.RowCount do
  Begin
    sgd_Produto.Cells[0, I] := sgd_Produto.Cells[0, I + 1];
    sgd_Produto.Cells[1, I] := sgd_Produto.Cells[1, I + 1];
    sgd_Produto.Cells[2, I] := sgd_Produto.Cells[2, I + 1];
    sgd_Produto.Cells[3, I] := sgd_Produto.Cells[3, I + 1];
    sgd_Produto.Cells[4, I] := sgd_Produto.Cells[4, I + 1];
  End;
  sgd_Produto.RowCount := sgd_Produto.RowCount - 1;
  TotalizaCompra;
  PintaGrid;
end;

procedure TForm_Venda.btn_sairClick(Sender: TObject);
begin
  Form_Venda.Close;
end;

procedure TForm_Venda.cbx_ClienteSelect(Sender: TObject);
var
  cli: Dados_Cliente;
  Parte: TStringList;
begin
  Parte := TStringList.Create;
  Parte.Delimiter := '-';
  Parte.DelimitedText := cbx_Cliente.Items[cbx_Cliente.ItemIndex];
  cli := Retorna_Dados_Cliente(StrToInt(Parte[0]));
  edit_cpf.Text := cli.CPF;
end;

procedure TForm_Venda.spin_qtdParcelasChange(Sender: TObject);
var
  valorParcelas: Real;
begin
  valorParcelas := (StrToFloat(Edit_Total.Text) - StrToFloat(edit_Entrada.Text))
    / spin_qtdParcelas.Value;
  valorParcelas := StrToFloat(FormatFloat('0.00', valorParcelas));
  edit_valorParcelas.Text := FloatToStr(valorParcelas);
end;

procedure TForm_Venda.PreencheComboCliente;
var
  listaCli: Clientes_Cadastrados;
  I: Integer;
begin
  listaCli := Retorna_Todos_Clientes_Cadastrados;

  cbx_Cliente.Items.Clear;

  for I := 0 to Length(listaCli) - 1 do
  begin
    cbx_Cliente.Items.Add(IntToStr(listaCli[I].Codigo) + ' - ' +
      listaCli[I].Nome);
  end;
end;

end.
