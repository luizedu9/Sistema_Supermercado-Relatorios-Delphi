unit Unit_Feedback;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB,
  Datasnap.DBClient, frxClass, frxDBSet, Unit_Persistencia, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, VCLTee.Series, VCLTee.TeEngine, VCLTee.TeeProcs,
  VCLTee.Chart, DateUtils;

type
  TForm_feedback = class(TForm)
    PageControl1: TPageControl;
    tab_relatorio: TTabSheet;
    tab_grafico: TTabSheet;
    PageControl2: TPageControl;
    tab_cliente: TTabSheet;
    tab_produto: TTabSheet;
    tab_estoqueminimo: TTabSheet;
    tab_venda: TTabSheet;
    tab_contasreceber: TTabSheet;
    tab_contaspagar: TTabSheet;
    tab_movimentacaocaixa: TTabSheet;
    PageControl3: TPageControl;
    tab_vendastotalmes: TTabSheet;
    tab_vendatotalprodutomes: TTabSheet;
    tab_vendadia: TTabSheet;
    tab_vendames: TTabSheet;
    tab_vendaprodutomes: TTabSheet;
    frxDBDataset_cliente: TfrxDBDataset;
    frxReport_cliente: TfrxReport;
    ClientDataSet_cliente: TClientDataSet;
    ClientDataSet_clienteCódigo: TIntegerField;
    ClientDataSet_clienteNome: TStringField;
    ClientDataSet_clienteCPF: TStringField;
    ClientDataSet_clienteSexo: TStringField;
    ClientDataSet_clienteEndereço: TStringField;
    ClientDataSet_clienteTelefone: TStringField;
    ClientDataSet_clienteEmail: TStringField;
    ClientDataSet_clienteEstadoCivil: TStringField;
    pnl_codigo_cliente: TPanel;
    lbl_de_cliente: TLabel;
    lbl_ate_cliente: TLabel;
    edt_codigoinicio_cliente: TEdit;
    edt_codigofim_cliente: TEdit;
    pnl_sexo_cliente: TPanel;
    rad_feminino_cliente: TRadioButton;
    rad_masculino_cliente: TRadioButton;
    Label1: TLabel;
    btn_gera_clisexo: TBitBtn;
    Label2: TLabel;
    btn_gera_clicodigo: TBitBtn;
    Panel1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edt_codigoinicio_produto: TEdit;
    edt_codigofim_produto: TEdit;
    Panel3: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edt_codigoinicio_estoque: TEdit;
    edt_codigofim_estoque: TEdit;
    Panel4: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edt_vendaproduto: TEdit;
    Panel5: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    gfc_vendastotaiproduto: TChart;
    gfc_venda_dia: TChart;
    gfc_venda_produto: TChart;
    BarSeries1: TBarSeries;
    gfc_venda_mes: TChart;
    BarSeries3: TBarSeries;
    edt_avista_inicio: TDateTimePicker;
    edt_avista_fim: TDateTimePicker;
    edt_aprazo_inicio: TDateTimePicker;
    edt_aprazo_fim: TDateTimePicker;
    edt_inicio_receber: TDateTimePicker;
    edt_fim_receber: TDateTimePicker;
    edt_inicio_pagar: TDateTimePicker;
    edt_fim_pagar: TDateTimePicker;
    edt_inicio_caixa: TDateTimePicker;
    edt_fim_caixa: TDateTimePicker;
    edt_inicio_vendastotaismes: TDateTimePicker;
    edt_fim_vendastotaismes: TDateTimePicker;
    edt_fim_vendadia: TDateTimePicker;
    edt_inicio_vendadia: TDateTimePicker;
    DateTimePicker15: TDateTimePicker;
    DateTimePicker16: TDateTimePicker;
    edt_fim_vendaproduto: TDateTimePicker;
    edt_inicio_vendaproduto: TDateTimePicker;
    gfc_vendastotaismes: TChart;
    frxDBDataset_produto: TfrxDBDataset;
    frxReport_produto: TfrxReport;
    ClientDataSet_clienteData: TStringField;
    ClientDataSet_produto: TClientDataSet;
    ClientDataSet_produtoDescrição: TStringField;
    ClientDataSet_produtoCódigo: TIntegerField;
    ClientDataSet_produtoPreçoCusto: TFloatField;
    ClientDataSet_produtoPreçoVenda: TFloatField;
    ClientDataSet_produtoEstoqueMínimo: TFloatField;
    ClientDataSet_produtoEstoqueAtual: TFloatField;
    frxReport_venda: TfrxReport;
    frxDBDataset_venda: TfrxDBDataset;
    ClientDataSet_venda: TClientDataSet;
    ClientDataSet_vendaData: TStringField;
    ClientDataSet_vendaValor: TFloatField;
    ClientDataSet_vendaCodigo: TIntegerField;
    frxDBDataset_receber: TfrxDBDataset;
    frxReport_receber: TfrxReport;
    ClientDataSet_receber: TClientDataSet;
    ClientDataSet_receberCódigo: TIntegerField;
    ClientDataSet_receberValorTotal: TFloatField;
    ClientDataSet_receberCliente: TStringField;
    ClientDataSet_receberVencimento: TStringField;
    frxDBDataset_pagar: TfrxDBDataset;
    frxReport_pagar: TfrxReport;
    ClientDataSet_pagar: TClientDataSet;
    IntegerField1: TIntegerField;
    FloatField1: TFloatField;
    ClientDataSet_pagarFornecedor: TStringField;
    StringField4: TStringField;
    frxDBDataset_caixa: TfrxDBDataset;
    frxReport_caixa: TfrxReport;
    ClientDataSet_caixa: TClientDataSet;
    ClientDataSet_caixaValorTotal: TFloatField;
    ClientDataSet_caixaData: TStringField;
    ClientDataSet_caixaHora: TStringField;
    ClientDataSet_caixaCodigo: TIntegerField;
    ClientDataSet_caixaDescricao: TStringField;
    ClientDataSet_caixaValorMovimentação: TFloatField;
    Series1: TPieSeries;
    Series3: TPieSeries;
    Series2: TBarSeries;
    edt_codigoinicio_receber: TEdit;
    edt_codigofim_receber: TEdit;
    edt_codigoinicio_pagar: TEdit;
    edt_codigofim_pagar: TEdit;
    Label6: TLabel;
    edt_inicio_vendasprodutomes: TDateTimePicker;
    Label7: TLabel;
    edt_fim_vendasprodutomes: TDateTimePicker;
    procedure btn_gera_clicodigoClick(Sender: TObject);
    procedure btn_gera_clisexoClick(Sender: TObject);
    procedure btn_gera_produtoClick(Sender: TObject);
    procedure btn_gera_estoqueminimoClick(Sender: TObject);
    procedure btn_gerar_avistaClick(Sender: TObject);
    procedure btn_gerar_aprazoClick(Sender: TObject);
    procedure btn_grafico_totalmesClick(Sender: TObject);
    procedure btn_grafico_totalprodutoClick(Sender: TObject);
    procedure btn_grafico_vendadiaClick(Sender: TObject);
    procedure btn_grafico_vendamesClick(Sender: TObject);
    procedure btn_grafico_produtomesClick(Sender: TObject);
    procedure btn_gera_recebercodigoClick(Sender: TObject);
    procedure btn_gera_receberdataClick(Sender: TObject);
    procedure btn_gera_pagarcodigoClick(Sender: TObject);
    procedure btn_gera_pagardataClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_feedback: TForm_feedback;

implementation

{$R *.dfm}

procedure TForm_feedback.btn_gera_clisexoClick(Sender: TObject);
Var
    i, sexo: integer;
    registros: Clientes_Cadastrados;
    registro: Dados_Cliente;
  Begin
    ClientDataSet_cliente.EmptyDataSet;
    ClientDataSet_cliente.Open;
    if (rad_masculino_cliente.Checked = true)
      then
        sexo := 0
      else
        sexo := 1;
    registros := Retorna_Clientes_Cadastrados('', '', '12', false);
    for i := 0 to (length(registros) - 1)  do
      Begin
         registro := registros[i];
         if (registro.Sexo = sexo)
           then begin
             ClientDataSet_cliente.Insert;
             ClientDataSet_cliente.FieldByName('Código').AsInteger := registro.codigo;
             ClientDataSet_cliente.FieldByName('Nome').AsString := registro.nome;
             ClientDataSet_cliente.FieldByName('CPF').AsString := registro.cpf;
             ClientDataSet_cliente.FieldByName('Data').AsString := registro.DataNascimento;
             ClientDataSet_cliente.FieldByName('Sexo').AsString := IntToStr(registro.sexo);
             ClientDataSet_cliente.FieldByName('Endereço').AsString := registro.endereco;
             ClientDataSet_cliente.FieldByName('Telefone').AsString := registro.telefone;
             ClientDataSet_cliente.FieldByName('Email').AsString := registro.email;
             ClientDataSet_cliente.FieldByName('Estado Civil').AsString := registro.estadocivil;
             ClientDataSet_cliente.Post;
           end;
      End;
      frxReport_cliente.ShowReport();
  End;

procedure TForm_feedback.BitBtn1Click(Sender: TObject);
  Var
    i: integer;
    registros: Dados_Caixa;
    registro: Dado_Caixa;
  Begin
    ClientDataSet_caixa.EmptyDataSet;
    ClientDataSet_caixa.Open;
    registros := Retorna_Caixa();
    for i := 0 to length(registros) - 1 do
      Begin
         registro := registros[i];
         if ((StrToDate(registro.Data) > edt_inicio_caixa.Date) and (StrToDate(registro.Data) < edt_fim_caixa.Date))
          then Begin
                 ClientDataSet_caixa.Insert;
                 ClientDataSet_caixa.FieldByName('Codigo').AsInteger := registro.codigo;
                 ClientDataSet_caixa.FieldByName('Descrição').AsString := registro.Descricao;
                 ClientDataSet_caixa.FieldByName('Valor Movimentação').AsFloat := registro.ValorMovimentacao;
                 ClientDataSet_caixa.FieldByName('Valor Atual').AsFloat := registro.ValorAtual;
                 ClientDataSet_caixa.FieldByName('Data').AsString := registro.Data;
                 ClientDataSet_caixa.FieldByName('Hora').AsString := registro.Hora;
                 ClientDataSet_caixa.Post;
          End;
      End;
      frxReport_caixa.ShowReport();
end;

procedure TForm_feedback.btn_gerar_aprazoClick(Sender: TObject);
  Var
    i: integer;
    registros: Vendas;
    registro: Dados_Venda2;
  Begin
    ClientDataSet_venda.EmptyDataSet;
    ClientDataSet_venda.Open;
    registros := Retorna_Todas_Vendas;
    for i := 0 to (length(registros) - 1)  do
      Begin
         registro := registros[i];
         if ((StrToDate(registro.data) > edt_aprazo_inicio.Date) and (StrToDate(registro.data) < edt_aprazo_fim.Date))
           then Begin
             ClientDataSet_venda.Insert;
             ClientDataSet_venda.FieldByName('Codigo').AsInteger := registro.codigo;
             ClientDataSet_venda.FieldByName('Data').AsString := registro.data;
             ClientDataSet_venda.FieldByName('Valor').AsFloat := registro.valor;
             ClientDataSet_venda.Post;
           End;
      End;
      frxReport_venda.ShowReport();
end;

procedure TForm_feedback.btn_gerar_avistaClick(Sender: TObject);
  Var
    i: integer;
    registros: Vendas;
    registro: Dados_Venda2;
  Begin
    ClientDataSet_venda.EmptyDataSet;
    ClientDataSet_venda.Open;
    registros := Retorna_Todas_Vendas;
    for i := 0 to (length(registros) - 1)  do
      Begin
         registro := registros[i];
         if ((StrToDate(registro.data) > edt_avista_inicio.Date) and (StrToDate(registro.data) < edt_avista_fim.Date))
           then Begin
             ClientDataSet_venda.Insert;
             ClientDataSet_venda.FieldByName('Codigo').AsInteger := registro.codigo;
             ClientDataSet_venda.FieldByName('Data').AsString := registro.data;
             ClientDataSet_venda.FieldByName('Valor').AsFloat := registro.valor;
             ClientDataSet_venda.Post;
           End;
      End;
      frxReport_venda.ShowReport();
end;

procedure TForm_feedback.btn_gera_clicodigoClick(Sender: TObject);
  Var
    i: integer;
    registros: Clientes_Cadastrados;
    registro: Dados_Cliente;
  Begin
    ClientDataSet_cliente.EmptyDataSet;
    ClientDataSet_cliente.Open;
    registros := Retorna_Clientes_Cadastrados('', '', '12', false);
    for i := StrToInt(edt_codigoinicio_cliente.Text) - 1 to length(registros) - 1 do
      Begin
         registro := registros[i];
         if (registro.Codigo <= StrToInt(edt_codigofim_cliente.Text))
          then Begin
                 ClientDataSet_cliente.Insert;
                 ClientDataSet_cliente.FieldByName('Código').AsInteger := registro.codigo;
                 ClientDataSet_cliente.FieldByName('Nome').AsString := registro.nome;
                 ClientDataSet_cliente.FieldByName('CPF').AsString := registro.cpf;
                 ClientDataSet_cliente.FieldByName('Data').AsString := registro.DataNascimento;
                 ClientDataSet_cliente.FieldByName('Sexo').AsInteger := registro.sexo;
                 ClientDataSet_cliente.FieldByName('Endereço').AsString := registro.endereco;
                 ClientDataSet_cliente.FieldByName('Telefone').AsString := registro.telefone;
                 ClientDataSet_cliente.FieldByName('Email').AsString := registro.email;
                 ClientDataSet_cliente.FieldByName('Estado Civil').AsString := registro.estadocivil;
                 ClientDataSet_cliente.Post;
          End;
      End;
      frxReport_cliente.ShowReport();
  End;

procedure TForm_feedback.btn_gera_pagarcodigoClick(Sender: TObject);
  Var
    i: integer;
    registros: Contas_Pagar;
    registro: Conta_Pagar;
  Begin
    ClientDataSet_pagar.EmptyDataSet;
    ClientDataSet_pagar.Open;
    registros := Retorna_Contas_Pagar();
    for i := StrToInt(edt_codigoinicio_pagar.Text) - 1 to length(registros) - 1 do
      Begin
         registro := registros[i];
         if (registro.Codigo <= StrToInt(edt_codigofim_pagar.Text))
          then Begin
                 ClientDataSet_pagar.Insert;
                 ClientDataSet_pagar.FieldByName('Código').AsInteger := registro.codigo;
                 ClientDataSet_pagar.FieldByName('Valor').AsFloat := registro.valor;
                 ClientDataSet_pagar.FieldByName('Vencimento').AsString := registro.Vencimento;
                 ClientDataSet_pagar.FieldByName('Fornecedor').AsString := Retorna_Dados_Fornecedor(registro.Fornecedor).NomeFantasia;
                 ClientDataSet_pagar.Post;
          End;
      End;
      frxReport_pagar.ShowReport();
end;

procedure TForm_feedback.btn_gera_pagardataClick(Sender: TObject);
  Var
    i: integer;
    registros: Contas_Pagar;
    registro: Conta_Pagar;
  Begin
    ClientDataSet_pagar.EmptyDataSet;
    ClientDataSet_pagar.Open;
    registros := Retorna_Contas_Pagar();
    for i := 0 to length(registros) - 1 do
      Begin
         registro := registros[i];
         if ((StrToDate(registro.Vencimento) > edt_inicio_pagar.Date) and (StrToDate(registro.Vencimento) < edt_fim_pagar.Date))
          then Begin
                 ClientDataSet_pagar.Insert;
                 ClientDataSet_pagar.FieldByName('Código').AsInteger := registro.codigo;
                 ClientDataSet_pagar.FieldByName('Valor').AsFloat := registro.valor;
                 ClientDataSet_pagar.FieldByName('Vencimento').AsString := registro.Vencimento;
                 ClientDataSet_pagar.FieldByName('Fornecedor').AsString := Retorna_Dados_Fornecedor(registro.Fornecedor).NomeFantasia;
                 ClientDataSet_pagar.Post;
          End;
      End;
      frxReport_pagar.ShowReport();
end;

procedure TForm_feedback.btn_gera_produtoClick(Sender: TObject);
  Var
    i: integer;
    registro: Dados_Produto;
  Begin
    ClientDataSet_produto.EmptyDataSet;
    ClientDataSet_produto.Open;
    for i := StrToInt(edt_codigoinicio_produto.Text) to StrToInt(edt_codigofim_produto.Text) do
      Begin
         registro := Retorna_Dados_Produto(i);
         if not(registro.Codigo = -1)
          then begin
                 ClientDataSet_produto.Insert;
                 ClientDataSet_produto.FieldByName('Código').AsInteger := registro.codigo;
                 ClientDataSet_produto.FieldByName('Descrição').AsString := registro.Descricao;
                 ClientDataSet_produto.FieldByName('Estoque Atual').AsFloat := registro.Estoque_Atual;
                 ClientDataSet_produto.FieldByName('Estoque Mínimo').AsFloat := registro.Estoque_Minimo;
                 ClientDataSet_produto.FieldByName('Preço Custo').AsString := FormatFloat('0.00', registro.Preco_Custo);
                 ClientDataSet_produto.FieldByName('Preço Venda').AsString := FormatFloat('0.00', registro.Preco_Venda);
                 ClientDataSet_produto.Post;
          end;
      End;
      frxReport_produto.ShowReport();
  End;

procedure TForm_feedback.btn_gera_recebercodigoClick(Sender: TObject);
  Var
    i: integer;
    registros: Contas_Receber;
    registro: Conta_Receber;
  Begin
    ClientDataSet_receber.EmptyDataSet;
    ClientDataSet_receber.Open;
    registros := Retorna_Contas_Receber();
    for i := StrToInt(edt_codigoinicio_receber.Text) - 1 to length(registros) - 1 do
      Begin
         registro := registros[i];
         if (registro.Codigo <= StrToInt(edt_codigofim_receber.Text))
          then Begin
                 ClientDataSet_receber.Insert;
                 ClientDataSet_receber.FieldByName('Código').AsInteger := registro.codigo;
                 ClientDataSet_receber.FieldByName('Valor').AsFloat := registro.valor;
                 ClientDataSet_receber.FieldByName('Vencimento').AsString := registro.Vencimento;
                 ClientDataSet_receber.FieldByName('Cliente').AsString := Retorna_Dados_Cliente(registro.Cliente).Nome;
                 ClientDataSet_receber.Post;
          End;
      End;
      frxReport_receber.ShowReport();
end;

procedure TForm_feedback.btn_gera_receberdataClick(Sender: TObject);
  Var
    i: integer;
    registros: Contas_Receber;
    registro: Conta_Receber;
  Begin
    ClientDataSet_receber.EmptyDataSet;
    ClientDataSet_receber.Open;
    registros := Retorna_Contas_Receber();
    for i := 0 to length(registros) - 1 do
      Begin
         registro := registros[i];
         if ((StrToDate(registro.Vencimento) > edt_inicio_receber.Date) and (StrToDate(registro.Vencimento) < edt_fim_receber.Date))
          then Begin
                 ClientDataSet_receber.Insert;
                 ClientDataSet_receber.FieldByName('Código').AsInteger := registro.codigo;
                 ClientDataSet_receber.FieldByName('Valor').AsFloat := registro.valor;
                 ClientDataSet_receber.FieldByName('Vencimento').AsString := registro.Vencimento;
                 ClientDataSet_receber.FieldByName('Cliente').AsString := Retorna_Dados_Cliente(registro.Cliente).Nome;
                 ClientDataSet_receber.Post;
          End;
      End;
      frxReport_receber.ShowReport();
end;

procedure TForm_feedback.btn_gera_estoqueminimoClick(Sender: TObject);
  Var
    i: integer;
    registro: Dados_Produto;
  Begin
    ClientDataSet_produto.EmptyDataSet;
    ClientDataSet_produto.Open;
    for i := StrToInt(edt_codigoinicio_estoque.Text) to StrToInt(edt_codigofim_estoque.Text) do
      Begin
         registro := Retorna_Dados_Produto(i);
         if registro.Estoque_Atual < registro.Estoque_Minimo
           then begin
             ClientDataSet_produto.Insert;
             ClientDataSet_produto.FieldByName('Código').AsInteger := registro.codigo;
             ClientDataSet_produto.FieldByName('Descrição').AsString := registro.Descricao;
             ClientDataSet_produto.FieldByName('Estoque Atual').AsFloat := registro.Estoque_Atual;
             ClientDataSet_produto.FieldByName('Estoque Mínimo').AsFloat := registro.Estoque_Minimo;
             ClientDataSet_produto.FieldByName('Preço Custo').AsString := FormatFloat('0.00', registro.Preco_Custo);
             ClientDataSet_produto.FieldByName('Preço Venda').AsString := FormatFloat('0.00', registro.Preco_Venda);
             ClientDataSet_produto.Post;
           end;
      End;
      frxReport_produto.ShowReport();
  End;

  //GRAFICOS --------------------------------------

procedure TForm_feedback.btn_grafico_totalmesClick(Sender: TObject);
const
  mes: array[1..12] of String = ('Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez');
var
  i: integer;
  qtd: array[1..12] of integer;
  cor: TColor;
  registros: Vendas;
  registro: Dados_Venda2;
begin
  gfc_vendastotaismes.Series[0].Clear;
  gfc_vendastotaismes.Visible := true;
  registros := Retorna_Todas_Vendas;
  for i := 1 to 12 do
    qtd[i] := 0;
  for i := 0 to (length(registros) - 1)  do
    Begin
      registro := registros[i];
      if ((StrToDate(registro.data) >= edt_inicio_vendastotaismes.Date) and (StrToDate(registro.data) <= edt_fim_vendastotaismes.Date))
        then Begin
          qtd[MonthOf(StrToDate(registro.data))] := qtd[MonthOf(StrToDate(registro.data))] + 1;
        End;
    End;
  for i := MonthOf(edt_inicio_vendastotaismes.Date) to MonthOf(edt_fim_vendastotaismes.Date) do
    Begin
      cor := RGB(Random(255), Random(255), Random(255));
      if qtd[i] > 0
        then
          gfc_vendastotaismes.Series[0].Add(qtd[i], mes[i], cor);
    End;
end;

procedure TForm_feedback.btn_grafico_totalprodutoClick(Sender: TObject);
type RelatorioPizza = Record
                        codigo: integer;
                        qtd: integer;
                      End;
var
  i, j, k: integer;
  Validacao: boolean;
  grafico: array of RelatorioPizza;
  cor:TColor;
  registros: Vendas;
  registro: Dados_Venda2;
Begin
  gfc_vendastotaiproduto.Series[0].Clear;
  gfc_vendastotaiproduto.Visible := true;
  registros := Retorna_Todas_Vendas;
  Setlength(grafico, 0);
  for i := 0 to (length(registros) - 1)  do
    Begin
      registro := registros[i];
      if ((StrToDate(registro.data) >= edt_inicio_vendasprodutomes.Date) and (StrToDate(registro.data) <= edt_fim_vendasprodutomes.Date))
        then begin
               for j := 0 to (length(registro.ProdutosVenda) - 1) do
                 begin
                   validacao := false;
                   if (length(grafico) > 0)
                     then Begin
                            for k := 0 to (length(grafico) - 1) do
                              begin
                                if (grafico[k].codigo = registro.ProdutosVenda[j].Codigo)
                                  then Begin
                                         grafico[k].qtd := grafico[k].qtd + registro.ProdutosVenda[j].Quantidade;
                                         validacao := true;
                                         break;
                                       End;
                              end;
                          End;
                   if (validacao = false)
                     then begin
                            Setlength(grafico, length(grafico) + 1);
                            grafico[length(grafico) - 1].codigo := registro.ProdutosVenda[j].Codigo;
                            grafico[length(grafico) - 1].qtd := registro.ProdutosVenda[j].Quantidade;
                          end;
                 end;
             end;
    end;
      for i := 0 to length(grafico) - 1 do
        Begin
            cor := RGB(Random(255), Random(255), Random(255));
            gfc_vendastotaiproduto.Series[0].Add(grafico[i].qtd, Retorna_Dados_Produto(grafico[i].codigo).Descricao, cor);
        End;
end;

procedure TForm_feedback.btn_grafico_vendadiaClick(Sender: TObject);
type RelatorioPizza = Record
                        dia: TDate;
                        qtd: integer;
                      End;
var
  i, j, k: integer;
  Validacao: boolean;
  grafico: array of RelatorioPizza;
  cor: TColor;
  registros: Vendas;
  registro: Dados_Venda2;
Begin
  gfc_venda_dia.Visible := true;
  gfc_venda_dia.Series[0].Clear;
  registros := Retorna_Todas_Vendas;
  Setlength(grafico, 0);
  for i := 0 to (length(registros) - 1)  do
    Begin
      registro := registros[i];
      if ((StrToDate(registro.data) >= edt_inicio_vendadia.Date) and (StrToDate(registro.data) <= edt_fim_vendadia.Date))
        then begin
               validacao := false;
               if (length(grafico) > 0)
                 then Begin
                        for k := 0 to (length(grafico) - 1) do
                          begin
                            if (grafico[k].dia = StrToDate(registro.data))
                              then Begin
                                     grafico[k].qtd := grafico[k].qtd + 1;
                                     validacao := true;
                                     break;
                                   End;
                          end;
                      End;
               if (validacao = false)
                 then begin
                        Setlength(grafico, length(grafico) + 1);
                        grafico[length(grafico) - 1].dia := StrToDate(registro.data);
                        grafico[length(grafico) - 1].qtd := 1;
                      end;
             end;
    end;
  for i := 0 to length(grafico) - 1 do
    Begin
      cor := RGB(Random(255), Random(255), Random(255));
      gfc_venda_dia.Series[0].Add(grafico[i].qtd, DateToStr(grafico[i].dia), cor);
    End;
end;

procedure TForm_feedback.btn_grafico_vendamesClick(Sender: TObject);
const
  mes: array[1..12] of String = ('Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez');
var
  i: integer;
  qtd: array[1..12] of integer;
  cor: TColor;
  registros: Vendas;
  registro: Dados_Venda2;
begin
  gfc_venda_mes.Series[0].Clear;
  gfc_venda_mes.Visible := true;
  registros := Retorna_Todas_Vendas;
  for i := 1 to 12 do
    qtd[i] := 0;
  for i := 0 to (length(registros) - 1)  do
    Begin
      registro := registros[i];
      if ((StrToDate(registro.data) >= edt_inicio_vendastotaismes.Date) and (StrToDate(registro.data) <= edt_fim_vendastotaismes.Date))
        then Begin
          qtd[MonthOf(StrToDate(registro.data))] := qtd[MonthOf(StrToDate(registro.data))] + 1;
        End;
    End;
  for i := MonthOf(edt_inicio_vendastotaismes.Date) to MonthOf(edt_fim_vendastotaismes.Date) do
    Begin
      cor := RGB(Random(255), Random(255), Random(255));
      if qtd[i] > 0
        then
          gfc_venda_mes.Series[0].Add(qtd[i], mes[i], cor);
    End;
end;

procedure TForm_feedback.btn_grafico_produtomesClick(Sender: TObject);
const
  mes: array[1..12] of String = ('Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez');
var
  i, j: integer;
  qtd: array[1..12] of integer;
  cor: TColor;
  registros: Vendas;
  registro: Dados_Venda2;
begin
  gfc_venda_produto.Series[0].Clear;
  gfc_venda_produto.Visible := true;
  registros := Retorna_Todas_Vendas;
  for i := 1 to 12 do
    qtd[i] := 0;
  for i := 0 to (length(registros) - 1)  do
    Begin
      registro := registros[i];
      if ((StrToDate(registro.data) >= edt_inicio_vendastotaismes.Date) and (StrToDate(registro.data) <= edt_fim_vendastotaismes.Date))
        then Begin
               for j := 0 to length(registro.ProdutosVenda) do
                 begin
                   if (registro.ProdutosVenda[j].Codigo = StrToInt(edt_vendaproduto.Text))
                     then
                       qtd[MonthOf(StrToDate(registro.data))] := qtd[MonthOf(StrToDate(registro.data))] + registro.ProdutosVenda[j].Quantidade;
                 end;
        End;
    End;
  for i := MonthOf(edt_inicio_vendastotaismes.Date) to MonthOf(edt_fim_vendastotaismes.Date) do
    Begin
      cor := RGB(Random(255), Random(255), Random(255));
      if qtd[i] > 0
        then
          gfc_venda_produto.Series[0].Add(qtd[i], mes[i], cor);
    End;
end;

end.


