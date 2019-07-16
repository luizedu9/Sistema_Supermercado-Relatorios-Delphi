unit Unit_Persistencia;

interface

uses Unit_DM, System.SysUtils, VCL.Dialogs, Unit_Util, System.Variants;

Type
  Dados_Empresa = Record
    NomeFantasia: String;
    RazaoSocial: String;
    InscricaoEstadual: String;
    CNPJ: String;
    Endereco: String;
    Lucro: Integer;
    Telefone: String;
    Email: String;
    NomeResponsavel: String;
    TelefoneResponsavel: String;

  End;

  Dados_Cliente = Record
    Codigo: Integer;
    Nome: String;
    Endereco: String;
    CPF: String;
    Telefone: String;
    Email: String;
    Sexo: Integer;
    EstadoCivil: String;
    DataNascimento: String;
    Ativo: Integer;
  End;

  Dados_Produto = Record
    Codigo: Integer;
    Descricao: String;
    Cod_Barras: String;
    Preco_Custo: Real;
    Preco_Venda: Real;
    Estoque_Atual: Real;
    Estoque_Minimo: Real;
    Cod_Grupo: Integer;
    Cod_SubGrupo: Integer;
    Ativo: Integer;
  End;

  Dados_GrupoProd = Record
    Codigo: Integer;
    Descricao: String;
    Ativo: Integer;
  End;

  Dados_SubGrupoProd = Record
    Codigo: Integer;
    Descricao: String;
    Cod_Grupo: Integer;
    Ativo: Integer;
  End;

  Dados_ProdutoVenda = Record
    Codigo: Integer;
    Preco: Real;
    Quantidade: Integer;
  End;

  Dados_Fornecedor = Record
    Codigo: Integer;
    NomeFantasia: String;
    RazaoSocial: String;
    InscricaoEstadual: String;
    CNPJ: String;
    Endereco: String;
    Telefone: String;
    Email: String;
    Ativo: Integer;
  End;

  Dados_Nota = Record
    Codigo: Integer;
    CodigoFornecedor: Integer;
    Frete: Real;
    Imposto: Real;
    Total: Real;
  End;

  Dados_Produto_Nota = Record
    CodigoNota: Integer;
    CodigoProduto: Integer;
    Descricao: String;
    PrecoCusto: Real;
    Quantidade: Real;
  End;

  Conta_Receber = Record
    Codigo: Integer;
    Vencimento: String;
    Valor: Real;
    Cliente: Integer;
    Pago: Integer;
    DataPagamento: String;
  End;

  Conta_Pagar = Record
    Codigo: Integer;
    Vencimento: String;
    Valor: Real;
    Fornecedor: Integer;
    Pago: Integer;
    DataPagamento: String;
  End;

  Dado_Caixa = Record
    Codigo: Integer;
    Descricao: String;
    Data: String;
    Hora: String;
    ValorMovimentacao: Real;
    ValorAtual: Real;

  End;

type
  Dados_Caixa = Array of Dado_Caixa;

type
  Clientes_Cadastrados = Array of Dados_Cliente;

type
  Produtos_Cadastrados = Array of Dados_Produto;

type
  GrupoProd_Cadastrados = Array of Dados_GrupoProd;

type
  SubGrupoProd_Cadastrados = Array of Dados_SubGrupoProd;

type
  Prods_Com_SubGrupo = Array of Integer;

type
  Produtos_Venda = Array of Dados_ProdutoVenda;

type
  Fornecedores_Cadastrados = Array of Dados_Fornecedor;

type
  Notas_Cadastradas = Array of Dados_Nota;

type
  Produtos_Notas = Array of Dados_Produto_Nota;

type
  Contas_Receber = Array of Conta_Receber;

type
  Contas_Pagar = Array of Conta_Pagar;

type
  Dados_Venda2 = Record
    Codigo: Integer;
    Data: String;
    Valor: Real;
    ProdutosVenda: Produtos_Venda;
  End;

type
  Vendas = Array of Dados_Venda2;

procedure Commit;

Procedure Grava_Dados_Empresa(Dados_Atuais: Dados_Empresa);
Function Retorna_Dados_Empresa: Dados_Empresa;

Procedure Grava_Dados_Cliente(Dados_Atuais: Dados_Cliente);
Procedure Atualiza_Dados_Cliente(Dados_Atuais: Dados_Cliente);
Function Retorna_Proximo_Codigo_Cliente: String;
Function Retorna_Dados_Cliente(Codigo: Integer): Dados_Cliente;
Function Retorna_Clientes_Cadastrados(Campo, Termo, Ordenacao: String;
  Excluidos: Boolean): Clientes_Cadastrados;
Procedure ApagaCliente(Codigo: Integer);

Procedure Grava_Dados_Produto(Dados_Atuais: Dados_Produto);
Procedure Atualiza_Dados_Produto(Dados_Atuais: Dados_Produto);
Function Retorna_Proximo_Codigo_Produto: String;
Function Retorna_Dados_Produto(Codigo: Integer): Dados_Produto;
Function Retorna_Produtos_Cadastrados(Campo, Termo, Ordenacao: String;
  Excluidos: Boolean): Produtos_Cadastrados;
Function Tem_Prod_SubGrupo(Codigo: Integer): Prods_Com_SubGrupo;
Procedure Atualiza_Produtos_Cascata(Vetor_Prods: Prods_Com_SubGrupo;
  Codigo: Integer);
Procedure Atualiza_Preco_Venda(Cod_Grupo, Cod_SubGrupo: Integer;
  Procentagem: Real);
Procedure ApagaProduto(Codigo: Integer);

Procedure Grava_Dados_GrupoProd(Dados_Atuais: Dados_GrupoProd);
Procedure Atualiza_Dados_GrupoProd(Dados_Atuais: Dados_GrupoProd);
Function Retorna_Proximo_Codigo_GrupoProd: String;
Function Retorna_Dados_GrupoProd(Codigo: Integer): Dados_GrupoProd;
Function Retorna_GrupoProd_Cadastrados(Campo, Termo, Ordenacao: String;
  Excluidos: Boolean): GrupoProd_Cadastrados;
Function Retorna_Codigo_Grupo(Descricao: String): Integer;
Procedure ApagaGrupoProd(Codigo: Integer);

Procedure Grava_Dados_SubGrupoProd(Dados_Atuais: Dados_SubGrupoProd);
Procedure Atualiza_Dados_SubGrupoProd(Dados_Atuais: Dados_SubGrupoProd);
Function Retorna_Proximo_Codigo_SubGrupoProd: String;
Function Retorna_Dados_SubGrupoProd(Codigo: Integer): Dados_SubGrupoProd;
Function Retorna_SubGrupoProd_Cadastrados(Campo, Termo, Ordenacao: String;
  Excluidos: Boolean): SubGrupoProd_Cadastrados;
Function Retorna_Codigo_SubGrupo(Descricao: String): Integer;
Procedure ApagaSubGrupoProd(Codigo: Integer);

Function Retorna_Proximo_Codigo_Venda: String;
Function Retorna_Proximo_Codigo_ProdutoVenda: String;
Procedure Grava_Dados_Venda(CodVenda: String; DataVenda: TDate; Total: Real;
  Vet_Prod: Produtos_Venda);
Function Retorna_Todas_Vendas: Vendas;
Function Retorna_Produtos_Venda(CodVenda: Integer): Produtos_Venda;

Procedure Grava_Dados_Fornecedor(Dados_Atuais: Dados_Fornecedor);
Procedure Atualiza_Dados_Fornecedor(Dados_Atuais: Dados_Fornecedor);
Function Retorna_Proximo_Codigo_Fornecedor: String;
Function Retorna_Dados_Fornecedor(Codigo: Integer): Dados_Fornecedor;
Function Retorna_Fornecedores_Cadastrados(Campo, Termo, Ordenacao: String;
  Excluidos: Boolean): Fornecedores_Cadastrados;
Function Retorna_Fornecedor(Nome: String): Dados_Fornecedor;
Procedure ApagaFornecedor(Codigo: Integer);
function retorna_fornecedores(): Fornecedores_Cadastrados;
function Retorna_Todos_Fornecedores_Cadastrados(): Fornecedores_Cadastrados;

function ultimo_valor_caixa(): Real;
procedure insere_contas_receber(data_vencimento: String; valor_parcela: Real;
  codigo_cliente: Integer);
procedure insere_valor_caixa(Descricao: String; valor_movimentacao: Real;
  Data: String; Hora: String);
Function Retorna_Todos_Clientes_Cadastrados: Clientes_Cadastrados;
Function Retorna_Proximo_Codigo_Contas_Receber: String;
Function Retorna_Proximo_Codigo_Caixa: String;
procedure atualiza_produto_compra(codProduto: Integer; Quantidade: Integer;
  preVenda: Real);
Function Retorna_Proximo_Codigo_Contas_Pagar: String;
procedure insere_contas_pagar(data_vencimento: String; valor_parcela: Real;
  cod_Fornecedor: Integer);
Function Retorna_Contas_Receber: Contas_Receber;
Function Retorna_Contas_Pagar: Contas_Pagar;
procedure pagaContaForncedor(codigoConta: Integer);
Function Retorna_Caixa: Dados_Caixa;

procedure pagaConta(codigoConta: Integer);
function retorna_quantidade_estoque(codProduto: Integer): Integer;

Function Retorna_lucro: Real;

implementation

Procedure Commit;
Begin
  With DM.QryCommit do
  Begin
    SQL.Clear;
    SQL.Add('COMMIT');
    ExecSQL;
    Close;
  End;
End;

Procedure Grava_Dados_Empresa(Dados_Atuais: Dados_Empresa);
begin
  With DM.QryEmpresa do
  Begin
    SQL.Clear;
    SQL.Add('UPDATE Empresa SET');
    SQL.Add('Emp_NomeFantasia = ' + QuotedStr(Dados_Atuais.NomeFantasia) + ',');
    SQL.Add('Emp_RazaoSocial = ' + QuotedStr(Dados_Atuais.RazaoSocial) + ',');
    SQL.Add('Emp_InscricaoEstadual = ' +
      QuotedStr(Dados_Atuais.InscricaoEstadual) + ',');
    SQL.Add('Emp_CNPJ = ' + QuotedStr(Dados_Atuais.CNPJ) + ',');
    SQL.Add('Emp_Endereco = ' + QuotedStr(Dados_Atuais.Endereco) + ',');
    SQL.Add('Emp_Lucro = ' + IntToStr(Dados_Atuais.Lucro) + ',');
    SQL.Add('Emp_Telefone = ' + QuotedStr(Dados_Atuais.Telefone) + ',');
    SQL.Add('Emp_Email = ' + QuotedStr(Dados_Atuais.Email) + ',');
    SQL.Add('Emp_NomeResponsavel = ' +
      QuotedStr(Dados_Atuais.NomeResponsavel) + ',');
    SQL.Add('Emp_TelefoneResponsavel = ' +
      QuotedStr(Dados_Atuais.TelefoneResponsavel));
    ExecSQL;
    Commit;
    Close;
  End;
end;

Function Retorna_Dados_Empresa: Dados_Empresa;
begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Empresa ');
    Open;
    FetchAll;
    Result.RazaoSocial := DM.QryAux['Emp_NomeFantasia'];
    Result.NomeFantasia := DM.QryAux['Emp_RazaoSocial'];
    Result.InscricaoEstadual := DM.QryAux['Emp_InscricaoEstadual'];
    Result.CNPJ := DM.QryAux['Emp_CNPJ'];
    Result.Endereco := DM.QryAux['Emp_Endereco'];
    Result.Lucro := DM.QryAux['Emp_Lucro'];
    Result.Telefone := DM.QryAux['Emp_Telefone'];
    Result.Email := DM.QryAux['Emp_Email'];
    Result.NomeResponsavel := DM.QryAux['Emp_NomeResponsavel'];
    Result.TelefoneResponsavel := DM.QryAux['Emp_TelefoneResponsavel'];
    Close;
  End;
end;

Function Retorna_Proximo_Codigo_Cliente: String;
Begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT Cli_Codigo');
    SQL.Add('FROM Cliente');
    SQL.Add('ORDER BY Cli_Codigo DESC');
    Open;
    if DM.QryAux.RecordCount <> 0 Then
      Result := IntToStr(DM.QryAux['Cli_Codigo'] + 1)
    Else
      Result := '1';
    Close;
  End;
End;

Procedure Grava_Dados_Cliente(Dados_Atuais: Dados_Cliente);
begin
  With DM.QryCliente do
  Begin
    SQL.Clear;
    SQL.Add('INSERT INTO Cliente VALUES(');
    SQL.Add(IntToStr(Dados_Atuais.Codigo) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.Nome) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.Endereco) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.CPF) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.Telefone) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.Email) + ',');
    SQL.Add(IntToStr(Dados_Atuais.Sexo) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.EstadoCivil) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.DataNascimento) + ',');
    SQL.Add('1');
    SQL.Add(')');
    ExecSQL;
    Commit;
    Close;
  End;
end;

Procedure Atualiza_Dados_Cliente(Dados_Atuais: Dados_Cliente);
begin
  With DM.QryCliente do
  Begin
    SQL.Clear;
    SQL.Add('UPDATE Cliente SET');
    SQL.Add('Cli_Codigo = ' + IntToStr(Dados_Atuais.Codigo) + ',');
    SQL.Add('Cli_Nome = ' + QuotedStr(Dados_Atuais.Nome) + ',');
    SQL.Add('Cli_Endereco = ' + QuotedStr(Dados_Atuais.Endereco) + ',');
    SQL.Add('Cli_CPF = ' + QuotedStr(Dados_Atuais.CPF) + ',');
    SQL.Add('Cli_Telefone = ' + QuotedStr(Dados_Atuais.Telefone) + ',');
    SQL.Add('Cli_Email = ' + QuotedStr(Dados_Atuais.Email) + ',');
    SQL.Add('Cli_Sexo = ' + IntToStr(Dados_Atuais.Sexo) + ',');
    SQL.Add('Cli_EstadoCivil = ' + QuotedStr(Dados_Atuais.EstadoCivil) + ',');
    SQL.Add('Cli_DataNascimento = ' + QuotedStr(Dados_Atuais.DataNascimento));
    SQL.Add('WHERE Cli_Codigo = ' + IntToStr(Dados_Atuais.Codigo));
    ExecSQL;
    Commit;
    Close;
  End;
end;

Function Retorna_Dados_Cliente(Codigo: Integer): Dados_Cliente;
begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Cliente ');
    SQL.Add('WHERE Cli_Codigo=' + IntToStr(Codigo));
    Open;
    FetchAll;
    Result.Codigo := DM.QryAux['CLI_CODIGO'];
    Result.Nome := DM.QryAux['Cli_Nome'];
    Result.Endereco := DM.QryAux['Cli_Endereco'];
    Result.CPF := DM.QryAux['Cli_Cpf'];
    Result.Telefone := DM.QryAux['Cli_Telefone'];
    Result.Email := DM.QryAux['Cli_Email'];
    Result.Sexo := DM.QryAux['Cli_Sexo'];
    Result.EstadoCivil := DM.QryAux['Cli_EstadoCivil'];
    Result.DataNascimento := DM.QryAux['Cli_DataNascimento'];
    Result.Ativo := DM.QryAux['Cli_Ativo'];
    Close;
  End;
end;

Function Retorna_Clientes_Cadastrados(Campo, Termo, Ordenacao: String;
  Excluidos: Boolean): Clientes_Cadastrados;
{ Valores possiveis para "Campo"
  Codigo: Cli_Codigo
  Nome: Cli_Nome
  Endereco: Cli_Endereco
  Telefone: Cli_Telefone
  CPF: Cli_Cpf }
var
  i: Integer;
begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Cliente ');
    { Filtro }
    if (lowerCase(Campo) = 'codigo') Then
      SQL.Add('WHERE Cli_Codigo = ' + Termo);
    if (lowerCase(Campo) = 'nome') Then
      SQL.Add('WHERE Cli_Nome LIKE ' + QuotedStr('%' + Termo + '%'));
    if (lowerCase(Campo) = 'endereco') Then
      SQL.Add('WHERE Cli_Endereco LIKE ' + QuotedStr('%' + Termo + '%'));
    if (lowerCase(Campo) = 'telefone') Then
      SQL.Add('WHERE Cli_Telefone LIKE ' +
        QuotedStr('%' + removeMascara(Termo) + '%'));
    if (lowerCase(Campo) = 'cpf') Then
      SQL.Add('WHERE Cli_Cpf LIKE ' +
        QuotedStr('%' + removeMascara(Termo) + '%'));
    if (not Excluidos) Then
    Begin
      if (Campo = '') Then
        SQL.Add('WHERE Cli_Ativo=1')
      Else
        SQL.Add('AND Cli_Ativo=1');
    End;
    { Ordenação }
    if (Ordenacao = 'AZ') Then
      SQL.Add('ORDER BY Cli_Nome ASC');
    if (Ordenacao = 'ZA') Then
      SQL.Add('ORDER BY Cli_Nome DESC');
    if (Ordenacao = '12') Then
      SQL.Add('ORDER BY Cli_Codigo ASC');
    if (Ordenacao = '21') Then
      SQL.Add('ORDER BY Cli_Codigo DESC');
    Open;
    FetchAll;
    SetLength(Result, 0);
    for i := 1 to DM.QryAux.RecordCount do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1].Codigo := DM.QryAux['CLI_CODIGO'];
      Result[Length(Result) - 1].Nome := DM.QryAux['Cli_Nome'];
      Result[Length(Result) - 1].Endereco := DM.QryAux['Cli_Endereco'];
      Result[Length(Result) - 1].CPF := DM.QryAux['Cli_Cpf'];
      Result[Length(Result) - 1].Telefone := DM.QryAux['Cli_Telefone'];
      Result[Length(Result) - 1].Email := DM.QryAux['Cli_Email'];
      Result[Length(Result) - 1].Sexo := DM.QryAux['Cli_Sexo'];
      Result[Length(Result) - 1].EstadoCivil := DM.QryAux['Cli_EstadoCivil'];
      Result[Length(Result) - 1].DataNascimento :=
        DM.QryAux['Cli_DataNascimento'];
      Result[Length(Result) - 1].Ativo := DM.QryAux['Cli_Ativo'];
      DM.QryAux.Next;
    end;
    Close;
  End;
end;

Procedure ApagaCliente(Codigo: Integer);
Begin
  With DM.QryCliente do
  Begin
    SQL.Clear;
    SQL.Add('UPDATE Cliente SET');
    SQL.Add('Cli_Ativo = 0');
    SQL.Add('WHERE Cli_Codigo = ' + IntToStr(Codigo));
    ExecSQL;
    Commit;
    Close;
  End;
End;

Function Retorna_Proximo_Codigo_Produto: String;
Begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT Pro_Codigo');
    SQL.Add('FROM Produto');
    SQL.Add('ORDER BY Pro_Codigo DESC');
    Open;
    if DM.QryAux.RecordCount <> 0 Then
      Result := IntToStr(DM.QryAux['Pro_Codigo'] + 1)
    Else
      Result := '1';
    Close;
  End;
End;

Procedure Grava_Dados_Produto(Dados_Atuais: Dados_Produto);
begin
  With DM.QryProduto do
  Begin
    SQL.Clear;
    SQL.Add('INSERT INTO Produto VALUES(');
    SQL.Add(IntToStr(Dados_Atuais.Codigo) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.Descricao) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.Cod_Barras) + ',');
    SQL.Add(FloatToStr(Dados_Atuais.Preco_Custo) + ',');
    SQL.Add(FloatToStr(Dados_Atuais.Preco_Venda) + ',');
    SQL.Add(FloatToStr(Dados_Atuais.Estoque_Atual) + ',');
    SQL.Add(FloatToStr(Dados_Atuais.Estoque_Minimo) + ',');
    SQL.Add(IntToStr(Dados_Atuais.Cod_Grupo) + ',');
    SQL.Add(IntToStr(Dados_Atuais.Cod_SubGrupo) + ',');
    SQL.Add('1');
    SQL.Add(')');
    ExecSQL;
    Commit;
    Close;
  End;
end;

Procedure Atualiza_Dados_Produto(Dados_Atuais: Dados_Produto);
begin
  With DM.QryProduto do
  Begin
    SQL.Clear;
    SQL.Add('UPDATE Produto SET');
    SQL.Add('Pro_Codigo = ' + IntToStr(Dados_Atuais.Codigo) + ',');
    SQL.Add('Pro_Descricao = ' + QuotedStr(Dados_Atuais.Descricao) + ',');
    SQL.Add('Pro_CodBarras = ' + QuotedStr(Dados_Atuais.Cod_Barras) + ',');
    SQL.Add('Pro_PreCusto = ' + FloatToStr(Dados_Atuais.Preco_Custo) + ',');
    SQL.Add('Pro_PreVenda = ' + FloatToStr(Dados_Atuais.Preco_Venda) + ',');
    SQL.Add('Pro_Estoque = ' + FloatToStr(Dados_Atuais.Estoque_Atual) + ',');
    SQL.Add('Pro_EstMinimo = ' + FloatToStr(Dados_Atuais.Estoque_Minimo) + ',');
    SQL.Add('Pro_CodGrupo = ' + IntToStr(Dados_Atuais.Cod_Grupo) + ',');
    SQL.Add('Pro_CodSubGrupo = ' + IntToStr(Dados_Atuais.Cod_SubGrupo));
    SQL.Add('WHERE Pro_Codigo = ' + IntToStr(Dados_Atuais.Codigo));
    ExecSQL;
    Commit;
    Close;
  End;
end;

Function Retorna_Dados_Produto(Codigo: Integer): Dados_Produto;
begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Produto ');
    SQL.Add('WHERE Pro_Codigo = ' + IntToStr(Codigo));
    Open;
    FetchAll;
    if (DM.QryAux['Pro_Codigo'] <> Null) Then
      Result.Codigo := DM.QryAux['Pro_Codigo']
    Else
      Result.Codigo := -1;
    if (DM.QryAux['Pro_Descricao'] <> Null) Then
      Result.Descricao := DM.QryAux['Pro_Descricao']
    Else
      Result.Descricao := '';
    if (DM.QryAux['Pro_CodBarras'] <> Null) Then
      Result.Cod_Barras := DM.QryAux['Pro_CodBarras']
    Else
      Result.Cod_Barras := '';
    if (DM.QryAux['Pro_PreCusto'] <> Null) Then
      Result.Preco_Custo := DM.QryAux['Pro_PreCusto']
    Else
      Result.Preco_Custo := -1;
    if (DM.QryAux['Pro_PreVenda'] <> Null) Then
      Result.Preco_Venda := DM.QryAux['Pro_PreVenda']
    Else
      Result.Preco_Venda := -1;
    if (DM.QryAux['Pro_Estoque'] <> Null) Then
      Result.Estoque_Atual := DM.QryAux['Pro_Estoque']
    Else
      Result.Estoque_Atual := -1;
    if (DM.QryAux['Pro_EstMinimo'] <> Null) Then
      Result.Estoque_Minimo := DM.QryAux['Pro_EstMinimo']
    Else
      Result.Estoque_Minimo := -1;
    if (DM.QryAux['Pro_CodGrupo'] <> Null) Then
      Result.Cod_Grupo := DM.QryAux['Pro_CodGrupo']
    Else
      Result.Cod_Grupo := -1;
    if (DM.QryAux['Pro_CodSubGrupo'] <> Null) Then
      Result.Cod_SubGrupo := DM.QryAux['Pro_CodSubGrupo']
    Else
      Result.Cod_SubGrupo := -1;
    if (DM.QryAux['Pro_Ativo'] <> Null) Then
      Result.Ativo := DM.QryAux['Pro_Ativo']
    Else
      Result.Ativo := 0;
    Close;
  End;
end;

Function Retorna_Produtos_Cadastrados(Campo, Termo, Ordenacao: String;
  Excluidos: Boolean): Produtos_Cadastrados;
{ Valores possiveis para "Campo"
  codigo: Pro_Codigo
  descricao: Pro_Descricao
  codbarras: Pro_CodBarras }
var
  i: Integer;
begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Produto ');
    { Filtro }
    if (lowerCase(Campo) = 'codigo') Then
      SQL.Add('WHERE Pro_Codigo = ' + Termo);
    if (lowerCase(Campo) = 'descricao') Then
      SQL.Add('WHERE Pro_Descricao LIKE ' + QuotedStr('%' + Termo + '%'));
    if (lowerCase(Campo) = 'codbarras') Then
      SQL.Add('WHERE Pro_CodBarras LIKE ' + QuotedStr('%' + Termo + '%'));
    if (not Excluidos) Then
    Begin
      if (Campo = '') Then
        SQL.Add('WHERE Pro_Ativo=1')
      Else
        SQL.Add('AND Pro_Ativo=1');
    End;
    { Ordenação }
    if (Ordenacao = 'AZ') Then
      SQL.Add('ORDER BY Pro_Descricao ASC');
    if (Ordenacao = 'ZA') Then
      SQL.Add('ORDER BY Pro_Descricao DESC');
    if (Ordenacao = '12') Then
      SQL.Add('ORDER BY Pro_Codigo ASC');
    if (Ordenacao = '21') Then
      SQL.Add('ORDER BY Pro_Codigo DESC');
    Open;
    FetchAll;
    SetLength(Result, 0);
    for i := 1 to DM.QryAux.RecordCount do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1].Codigo := DM.QryAux['Pro_Codigo'];
      Result[Length(Result) - 1].Descricao := DM.QryAux['Pro_Descricao'];
      Result[Length(Result) - 1].Cod_Barras := DM.QryAux['Pro_CodBarras'];
      Result[Length(Result) - 1].Preco_Custo := DM.QryAux['Pro_PreCusto'];
      Result[Length(Result) - 1].Preco_Venda := DM.QryAux['Pro_PreVenda'];
      Result[Length(Result) - 1].Estoque_Atual := DM.QryAux['Pro_Estoque'];
      Result[Length(Result) - 1].Estoque_Minimo := DM.QryAux['Pro_EstMinimo'];
      Result[Length(Result) - 1].Cod_Grupo := DM.QryAux['Pro_CodGrupo'];
      Result[Length(Result) - 1].Cod_SubGrupo := DM.QryAux['Pro_CodSubGrupo'];
      Result[Length(Result) - 1].Ativo := DM.QryAux['Pro_Ativo'];
      DM.QryAux.Next;
    end;
    Close;
  End;
end;

Function Tem_Prod_SubGrupo(Codigo: Integer): Prods_Com_SubGrupo;
var
  i: Integer;
Begin
  With DM.QryAux Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('Select Pro_Codigo');
    SQL.Add('From Produto');
    SQL.Add('Where Pro_CodSubGrupo = ' + IntToStr(Codigo));
    Open;
    FetchAll;
    if (DM.QryAux.RecordCount > 0) Then
    Begin
      SetLength(Result, DM.QryAux.RecordCount);
      for i := 1 to DM.QryAux.RecordCount do
      Begin
        Result[i - 1] := DM.QryAux['Pro_Codigo'];
        DM.QryAux.Next;
      End;
    End;
    Close;
  End;
End;

Procedure Atualiza_Produtos_Cascata(Vetor_Prods: Prods_Com_SubGrupo;
  Codigo: Integer);
var
  i: Integer;
Begin
  With DM.QryAux Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Produto SET Pro_CodGrupo = ' + IntToStr(Codigo));
    For i := 0 to Length(Vetor_Prods) - 1 do
    Begin
      If (i = 0) Then
        SQL.Add('WHERE Pro_Codigo = ' + IntToStr(Vetor_Prods[i]))
      Else
        SQL.Add('   OR Pro_Codigo = ' + IntToStr(Vetor_Prods[i]));
    End;
    ExecSQL;
    Commit;
    Close;
  End;
End;

Procedure Atualiza_Preco_Venda(Cod_Grupo, Cod_SubGrupo: Integer;
  Procentagem: Real);
Begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('UPDATE Produto');
    SQL.Add('SET Pro_PreVenda = Pro_PreVenda *' +
      TrocaVirgulaPonto(FloatToStr((Procentagem / 100) + 1)));
    SQL.Add('WHERE Pro_CodGrupo = ' + IntToStr(Cod_Grupo));
    if (Cod_SubGrupo <> -1) Then
      SQL.Add('AND Pro_CodSubGrupo = ' + IntToStr(Cod_SubGrupo));
    ExecSQL;
    Commit;
    Close;
  End;
End;

Procedure ApagaProduto(Codigo: Integer);
Begin
  With DM.QryProduto do
  Begin
    SQL.Clear;
    SQL.Add('UPDATE Produto SET');
    SQL.Add('Pro_Ativo = 0');
    SQL.Add('WHERE Pro_Codigo = ' + IntToStr(Codigo));
    ExecSQL;
    Commit;
    Close;
  End;
End;

Function Retorna_Proximo_Codigo_GrupoProd: String;
Begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT GruP_Codigo');
    SQL.Add('FROM GrupoProd');
    SQL.Add('ORDER BY GruP_Codigo DESC');
    Open;
    if DM.QryAux.RecordCount <> 0 Then
      Result := IntToStr(DM.QryAux['GruP_Codigo'] + 1)
    Else
      Result := '1';
    Close;
  End;
End;

Procedure Grava_Dados_GrupoProd(Dados_Atuais: Dados_GrupoProd);
begin
  With DM.QryGrupoProd do
  Begin
    SQL.Clear;
    SQL.Add('INSERT INTO GrupoProd VALUES(');
    SQL.Add(IntToStr(Dados_Atuais.Codigo) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.Descricao) + ',');
    SQL.Add('1');
    SQL.Add(')');
    ExecSQL;
    Commit;
    Close;
  End;
end;

Procedure Atualiza_Dados_GrupoProd(Dados_Atuais: Dados_GrupoProd);
begin
  With DM.QryGrupoProd do
  Begin
    SQL.Clear;
    SQL.Add('UPDATE GrupoProd SET');
    SQL.Add('GruP_Codigo = ' + IntToStr(Dados_Atuais.Codigo) + ',');
    SQL.Add('GruP_Descricao = ' + QuotedStr(Dados_Atuais.Descricao));
    SQL.Add('WHERE GruP_Codigo = ' + IntToStr(Dados_Atuais.Codigo));
    ExecSQL;
    Commit;
    Close;
  End;
end;

Function Retorna_Dados_GrupoProd(Codigo: Integer): Dados_GrupoProd;
begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM GrupoProd ');
    SQL.Add('WHERE GruP_Codigo = ' + IntToStr(Codigo));
    Open;
    FetchAll;
    Result.Codigo := DM.QryAux['GruP_Codigo'];
    Result.Descricao := DM.QryAux['GruP_Descricao'];
    Result.Ativo := DM.QryAux['GruP_Ativo'];
    Close;
  End;
end;

Function Retorna_Codigo_Grupo(Descricao: String): Integer;
Begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM GrupoProd ');
    SQL.Add('WHERE GruP_Descricao = ' + QuotedStr(Descricao));
    Open;
    if DM.QryAux.RecordCount <> 0 Then
      Result := DM.QryAux['GruP_Codigo']
    Else
      Result := -1;
    Close;
  End;
End;

Procedure ApagaGrupoProd(Codigo: Integer);
Begin
  With DM.QryGrupoProd do
  Begin
    SQL.Clear;
    SQL.Add('UPDATE GrupoProd SET');
    SQL.Add('GruP_Ativo = 0');
    SQL.Add('WHERE GruP_Codigo = ' + IntToStr(Codigo));
    ExecSQL;
    Commit;
    Close;
  End;
End;

Function Retorna_GrupoProd_Cadastrados(Campo, Termo, Ordenacao: String;
  Excluidos: Boolean): GrupoProd_Cadastrados;
{ Valores possiveis para "Campo"
  codigo: Pro_Codigo
  descricao: Pro_Descricao }
var
  i: Integer;
begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM GrupoProd ');
    { Filtro }
    if (lowerCase(Campo) = 'codigo') Then
      SQL.Add('WHERE GruP_Codigo = ' + Termo);
    if (lowerCase(Campo) = 'descricao') Then
      SQL.Add('WHERE GruP_Descricao LIKE ' + QuotedStr('%' + Termo + '%'));
    if (not Excluidos) Then
    Begin
      if (Campo = '') Then
        SQL.Add('WHERE GruP_Ativo=1')
      Else
        SQL.Add('AND GruP_Ativo=1');
    End;
    { Ordenação }
    if (Ordenacao = 'AZ') Then
      SQL.Add('ORDER BY GruP_Descricao ASC');
    if (Ordenacao = 'ZA') Then
      SQL.Add('ORDER BY GruP_Descricao DESC');
    if (Ordenacao = '12') Then
      SQL.Add('ORDER BY GruP_Codigo ASC');
    if (Ordenacao = '21') Then
      SQL.Add('ORDER BY GruP_Codigo DESC');
    Open;
    FetchAll;
    SetLength(Result, 0);
    for i := 1 to DM.QryAux.RecordCount do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1].Codigo := DM.QryAux['GruP_Codigo'];
      Result[Length(Result) - 1].Descricao := DM.QryAux['GruP_Descricao'];
      Result[Length(Result) - 1].Ativo := DM.QryAux['GruP_Ativo'];
      DM.QryAux.Next;
    end;
    Close;
  End;
end;

Function Retorna_Proximo_Codigo_SubGrupoProd: String;
Begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT SubGruP_Codigo');
    SQL.Add('FROM SubGrupoProd');
    SQL.Add('ORDER BY SubGruP_Codigo DESC');
    Open;
    if DM.QryAux.RecordCount <> 0 Then
      Result := IntToStr(DM.QryAux['SubGruP_Codigo'] + 1)
    Else
      Result := '1';
    Close;
  End;
End;

Procedure Grava_Dados_SubGrupoProd(Dados_Atuais: Dados_SubGrupoProd);
begin
  With DM.QrySubGrupoProd do
  Begin
    SQL.Clear;
    SQL.Add('INSERT INTO SubGrupoProd VALUES(');
    SQL.Add(IntToStr(Dados_Atuais.Codigo) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.Descricao) + ',');
    SQL.Add(IntToStr(Dados_Atuais.Cod_Grupo) + ',');
    SQL.Add('1');
    SQL.Add(')');
    ExecSQL;
    Commit;
    Close;
  End;
end;

Procedure Atualiza_Dados_SubGrupoProd(Dados_Atuais: Dados_SubGrupoProd);
begin
  With DM.QrySubGrupoProd do
  Begin
    SQL.Clear;
    SQL.Add('UPDATE SubGrupoProd SET');
    SQL.Add('SubGruP_Codigo = ' + IntToStr(Dados_Atuais.Codigo) + ',');
    SQL.Add('SubGruP_Descricao = ' + QuotedStr(Dados_Atuais.Descricao) + ',');
    SQL.Add('SubGruP_CodGrupo = ' + IntToStr(Dados_Atuais.Cod_Grupo));
    SQL.Add('WHERE SubGruP_Codigo = ' + IntToStr(Dados_Atuais.Codigo));
    ExecSQL;
    Commit;
    Close;
  End;
end;

Function Retorna_Dados_SubGrupoProd(Codigo: Integer): Dados_SubGrupoProd;
begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM SubGrupoProd ');
    SQL.Add('WHERE SubGruP_Codigo = ' + IntToStr(Codigo));
    Open;
    FetchAll;
    Result.Codigo := DM.QryAux['SubGruP_Codigo'];
    Result.Descricao := DM.QryAux['SubGruP_Descricao'];
    Result.Cod_Grupo := DM.QryAux['SubGruP_CodGrupo'];
    Result.Ativo := DM.QryAux['SubGruP_Ativo'];
    Close;
  End;
end;

Function Retorna_SubGrupoProd_Cadastrados(Campo, Termo, Ordenacao: String;
  Excluidos: Boolean): SubGrupoProd_Cadastrados;
{ Valores possiveis para "Campo"
  codigo: SubGruP_Codigo
  descricao: SubGruP_Descricao
  codGrupo: SubGruP_CodGrupo }
var
  i: Integer;
begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM SubGrupoProd ');
    { Filtro }
    if (lowerCase(Campo) = 'codigo') Then
      SQL.Add('WHERE SubGruP_Codigo = ' + Termo);
    if (lowerCase(Campo) = 'descricao') Then
      SQL.Add('WHERE SubGruP_Descricao LIKE ' + QuotedStr('%' + Termo + '%'));
    if (lowerCase(Campo) = 'codgrupo') Then
      SQL.Add('WHERE SubGruP_CodGrupo = ' + Termo);
    if (not Excluidos) Then
    Begin
      if (Campo = '') Then
        SQL.Add('WHERE SubGruP_Ativo=1')
      Else
        SQL.Add('AND SubGruP_Ativo=1');
    End;
    { Ordenação }
    if (Ordenacao = 'AZ') Then
      SQL.Add('ORDER BY SubGruP_Descricao ASC');
    if (Ordenacao = 'ZA') Then
      SQL.Add('ORDER BY SubGruP_Descricao DESC');
    if (Ordenacao = '12') Then
      SQL.Add('ORDER BY SubGruP_Codigo ASC');
    if (Ordenacao = '21') Then
      SQL.Add('ORDER BY SubGruP_Codigo DESC');
    Open;
    FetchAll;
    SetLength(Result, 0);
    for i := 1 to DM.QryAux.RecordCount do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1].Codigo := DM.QryAux['SubGruP_Codigo'];
      Result[Length(Result) - 1].Descricao := DM.QryAux['SubGruP_Descricao'];
      Result[Length(Result) - 1].Cod_Grupo := DM.QryAux['SubGruP_CodGrupo'];
      Result[Length(Result) - 1].Ativo := DM.QryAux['SubGruP_Ativo'];
      DM.QryAux.Next;
    end;
    Close;
  End;
end;

Function Retorna_Codigo_SubGrupo(Descricao: String): Integer;
Begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM SubGrupoProd ');
    SQL.Add('WHERE SubGruP_Descricao = ' + QuotedStr(Descricao));
    Open;
    if DM.QryAux.RecordCount <> 0 Then
      Result := DM.QryAux['SubGruP_Codigo']
    Else
      Result := -1;
    Close;
  End;
End;

Procedure ApagaSubGrupoProd(Codigo: Integer);
Begin
  With DM.QrySubGrupoProd do
  Begin
    SQL.Clear;
    SQL.Add('UPDATE SubGrupoProd SET');
    SQL.Add('SubGruP_Ativo = 0');
    SQL.Add('WHERE SubGruP_Codigo = ' + IntToStr(Codigo));
    ExecSQL;
    Commit;
    Close;
  End;
End;

Function Retorna_Proximo_Codigo_Venda: String;
Begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT Ven_Codigo');
    SQL.Add('FROM Venda');
    SQL.Add('ORDER BY Ven_Codigo DESC');
    Open;
    if DM.QryAux.RecordCount <> 0 Then
      Result := IntToStr(DM.QryAux['Ven_Codigo'] + 1)
    Else
      Result := '1';
    Close;
  End;
End;

Function Retorna_Proximo_Codigo_ProdutoVenda: String;
Begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT ProdVen_Codigo');
    SQL.Add('FROM Produto_Venda');
    SQL.Add('ORDER BY ProdVen_Codigo DESC');
    Open;
    if DM.QryAux.RecordCount <> 0 Then
      Result := IntToStr(DM.QryAux['ProdVen_Codigo'] + 1)
    Else
      Result := '1';
    Close;
  End;
End;

Procedure Grava_Dados_Venda(CodVenda: String; DataVenda: TDate; Total: Real;
  Vet_Prod: Produtos_Venda);
var
  i: Integer;
  prod: Dados_Produto;
  qtde: Real;
begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('INSERT INTO Venda VALUES(');
    SQL.Add(CodVenda + ',');
    SQL.Add(QuotedStr(TransformaData(DataVenda)) + ',');
    SQL.Add(TrocaVirgulaPonto(FloatToStr(Total)));
    SQL.Add(')');
    ExecSQL;
    Commit;
    Close;
  End;

  for i := 0 to Length(Vet_Prod) - 1 do
  Begin
    With DM.QryProdutoVenda do
    Begin
      SQL.Clear;
      SQL.Add('INSERT INTO Produto_Venda VALUES(');
      SQL.Add(Retorna_Proximo_Codigo_ProdutoVenda + ',');
      // codigo da propria tabela
      SQL.Add(CodVenda + ',');
      SQL.Add(IntToStr(Vet_Prod[i].Codigo) + ',');
      SQL.Add(IntToStr(Vet_Prod[i].Quantidade) + ',');
      SQL.Add(TrocaVirgulaPonto(FloatToStr(Vet_Prod[i].Preco)));
      SQL.Add(')');
      ExecSQL;
      Commit;
      Close;
    End;
  End;

  for i := 0 to Length(Vet_Prod) - 1 do
  Begin
    qtde := retorna_quantidade_estoque(Vet_Prod[i].Codigo);
    qtde := qtde - Vet_Prod[i].Quantidade;
    With DM.QryAux do
    Begin
      SQL.Clear;
      SQL.Add('UPDATE Produto SET');
      SQL.Add('Pro_ESTOQUE = ' + TrocaVirgulaPonto(FloatToStr(qtde)));
      SQL.Add('WHERE Pro_Codigo = ' + IntToStr(Vet_Prod[i].Codigo));
      ExecSQL;
      Commit;
      Close;
    End;
  End;
end;

Function Retorna_Proximo_Codigo_Fornecedor: String;
Begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT For_Codigo');
    SQL.Add('FROM Fornecedor');
    SQL.Add('ORDER BY For_Codigo DESC');
    Open;
    if DM.QryAux.RecordCount <> 0 Then
      Result := IntToStr(DM.QryAux['For_Codigo'] + 1)
    Else
      Result := '1';
    Close;
  End;
End;

Procedure Grava_Dados_Fornecedor(Dados_Atuais: Dados_Fornecedor);
begin
  With DM.QryFornecedor do
  Begin
    SQL.Clear;
    SQL.Add('INSERT INTO Fornecedor VALUES(');
    SQL.Add(IntToStr(Dados_Atuais.Codigo) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.NomeFantasia) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.RazaoSocial) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.InscricaoEstadual) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.CNPJ) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.Endereco) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.Telefone) + ',');
    SQL.Add(QuotedStr(Dados_Atuais.Email) + ',');
    SQL.Add('1');
    SQL.Add(')');
    ExecSQL;
    Commit;
    Close;
  End;
end;

Procedure Atualiza_Dados_Fornecedor(Dados_Atuais: Dados_Fornecedor);
begin
  With DM.QryFornecedor do
  Begin
    SQL.Clear;
    SQL.Add('UPDATE Fornecedor SET');
    SQL.Add('For_Codigo = ' + IntToStr(Dados_Atuais.Codigo) + ',');
    SQL.Add('For_NomeFantasia = ' + QuotedStr(Dados_Atuais.NomeFantasia) + ',');
    SQL.Add('For_RazaoSocial = ' + QuotedStr(Dados_Atuais.RazaoSocial) + ',');
    SQL.Add('For_InscricaoEstadual = ' +
      QuotedStr(Dados_Atuais.InscricaoEstadual) + ',');
    SQL.Add('For_CNPJ = ' + QuotedStr(Dados_Atuais.CNPJ) + ',');
    SQL.Add('For_Endereco = ' + QuotedStr(Dados_Atuais.Endereco) + ',');
    SQL.Add('For_Telefone = ' + QuotedStr(Dados_Atuais.Telefone) + ',');
    SQL.Add('For_Email = ' + QuotedStr(Dados_Atuais.Email));
    SQL.Add('WHERE For_Codigo = ' + IntToStr(Dados_Atuais.Codigo));
    ExecSQL;
    Commit;
    Close;
  End;
end;

Function Retorna_Dados_Fornecedor(Codigo: Integer): Dados_Fornecedor;
begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Fornecedor ');
    SQL.Add('WHERE For_Codigo=' + IntToStr(Codigo));
    Open;
    FetchAll;
    Result.Codigo := DM.QryAux['For_Codigo'];
    Result.NomeFantasia := DM.QryAux['For_NomeFantasia'];
    Result.RazaoSocial := DM.QryAux['For_RazaoSocial'];
    Result.InscricaoEstadual := DM.QryAux['For_InscricaoEstadual'];
    Result.CNPJ := DM.QryAux['For_CNPJ'];
    Result.Endereco := DM.QryAux['For_Endereco'];
    Result.Telefone := DM.QryAux['For_Telefone'];
    Result.Email := DM.QryAux['For_Email'];
    Result.Ativo := DM.QryAux['For_Ativo'];
    Close;
  End;
end;

Function Retorna_Fornecedores_Cadastrados(Campo, Termo, Ordenacao: String;
  Excluidos: Boolean): Fornecedores_Cadastrados;
{ Valores possiveis para "Campo"
  Codigo: For_Codigo
  Nome: For_NomeFantasia
  Endereco: For_Endereco
  Telefone: For_Telefone
  CNPJ: For_CNPJ }
var
  i: Integer;
begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Fornecedor ');
    { Filtro }
    if (lowerCase(Campo) = 'codigo') Then
      SQL.Add('WHERE For_Codigo = ' + Termo);
    if (lowerCase(Campo) = 'nome') Then
      SQL.Add('WHERE For_NomeFantasia LIKE ' + QuotedStr('%' + Termo + '%'));
    if (lowerCase(Campo) = 'endereco') Then
      SQL.Add('WHERE For_Endereco LIKE ' + QuotedStr('%' + Termo + '%'));
    if (lowerCase(Campo) = 'telefone') Then
      SQL.Add('WHERE For_Telefone LIKE ' +
        QuotedStr('%' + removeMascara(Termo) + '%'));
    if (lowerCase(Campo) = 'cnpj') Then
      SQL.Add('WHERE For_CNPJ LIKE ' +
        QuotedStr('%' + removeMascara(Termo) + '%'));
    if (not Excluidos) Then
    Begin
      if (Campo = '') Then
        SQL.Add('WHERE For_Ativo=1')
      Else
        SQL.Add('AND For_Ativo=1');
    End;
    { Ordenação }
    if (Ordenacao = 'AZ') Then
      SQL.Add('ORDER BY For_NomeFantasia ASC');
    if (Ordenacao = 'ZA') Then
      SQL.Add('ORDER BY For_NomeFantasia DESC');
    if (Ordenacao = '12') Then
      SQL.Add('ORDER BY For_Codigo ASC');
    if (Ordenacao = '21') Then
      SQL.Add('ORDER BY For_Codigo DESC');
    Open;
    FetchAll;
    SetLength(Result, 0);
    for i := 1 to DM.QryAux.RecordCount do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1].Codigo := DM.QryAux['For_Codigo'];
      Result[Length(Result) - 1].NomeFantasia := DM.QryAux['For_NomeFantasia'];
      Result[Length(Result) - 1].RazaoSocial := DM.QryAux['For_RazaoSocial'];
      Result[Length(Result) - 1].InscricaoEstadual :=
        DM.QryAux['For_InscricaoEstadual'];
      Result[Length(Result) - 1].CNPJ := DM.QryAux['For_CNPJ'];
      Result[Length(Result) - 1].Endereco := DM.QryAux['For_Endereco'];
      Result[Length(Result) - 1].Telefone := DM.QryAux['For_Telefone'];
      Result[Length(Result) - 1].Email := DM.QryAux['For_Email'];
      Result[Length(Result) - 1].Ativo := DM.QryAux['For_Ativo'];
      DM.QryAux.Next;
    end;
    Close;
  End;
end;

Function Retorna_Fornecedor(Nome: String): Dados_Fornecedor;
var
  i: Integer;
begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Fornecedor ');
    SQL.Add('WHERE For_NomeFantasia = ' + QuotedStr(Nome));
    // ShowMessage(SQL.Text);
    Open;
    Result.Codigo := DM.QryAux['For_Codigo'];
    Result.NomeFantasia := DM.QryAux['For_NomeFantasia'];
    Result.RazaoSocial := DM.QryAux['For_RazaoSocial'];
    Result.InscricaoEstadual := DM.QryAux['For_InscricaoEstadual'];
    Result.CNPJ := DM.QryAux['For_CNPJ'];
    Result.Endereco := DM.QryAux['For_Endereco'];
    Result.Telefone := DM.QryAux['For_Telefone'];
    Result.Email := DM.QryAux['For_Email'];
    Result.Ativo := DM.QryAux['For_Ativo'];
    Close;
  End;
end;

Procedure ApagaFornecedor(Codigo: Integer);
Begin
  With DM.QryFornecedor do
  Begin
    SQL.Clear;
    SQL.Add('UPDATE Fornecedor SET');
    SQL.Add('For_Ativo = 0');
    SQL.Add('WHERE For_Codigo = ' + IntToStr(Codigo));
    ExecSQL;
    Commit;
    Close;
  End;
End;

function retorna_fornecedores(): Fornecedores_Cadastrados;
var
  i: Integer;

begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM FORNECEDOR');
    SQL.Add('WHERE For_Ativo = 1');
    // Sql.Add('ORDER BY For_NomeFantasia ASC');
    // ShowMessage(SQL.GetText);
    Open;
    for i := 1 to DM.QryAux.RecordCount do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1].Codigo := DM.QryAux['For_Codigo'];
      Result[Length(Result) - 1].NomeFantasia := DM.QryAux['For_NomeFantasia'];
      Result[Length(Result) - 1].RazaoSocial := DM.QryAux['For_RazaoSocial'];
      Result[Length(Result) - 1].InscricaoEstadual :=
        DM.QryAux['For_InscricaoEstadual'];
      Result[Length(Result) - 1].CNPJ := DM.QryAux['For_CNPJ'];
      Result[Length(Result) - 1].Endereco := DM.QryAux['For_Endereco'];
      Result[Length(Result) - 1].Telefone := DM.QryAux['For_Telefone'];
      Result[Length(Result) - 1].Email := DM.QryAux['For_Email'];
      Result[Length(Result) - 1].Ativo := DM.QryAux['For_Ativo'];
      DM.QryAux.Next;
    end;
    Close;
  End;
end;

function Retorna_Todos_Fornecedores_Cadastrados(): Fornecedores_Cadastrados;
var
  i: Integer;

begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM FORNECEDOR');
    SQL.Add('ORDER BY For_NomeFantasia ASC');
    Open;
    FetchAll;
    SetLength(Result, 0);
    for i := 1 to DM.QryAux.RecordCount do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1].Codigo := DM.QryAux['For_Codigo'];
      Result[Length(Result) - 1].NomeFantasia := DM.QryAux['For_NomeFantasia'];
      Result[Length(Result) - 1].RazaoSocial := DM.QryAux['For_RazaoSocial'];
      Result[Length(Result) - 1].InscricaoEstadual :=
        DM.QryAux['For_InscricaoEstadual'];
      Result[Length(Result) - 1].CNPJ := DM.QryAux['For_CNPJ'];
      Result[Length(Result) - 1].Endereco := DM.QryAux['For_Endereco'];
      Result[Length(Result) - 1].Telefone := DM.QryAux['For_Telefone'];
      Result[Length(Result) - 1].Email := DM.QryAux['For_Email'];
      Result[Length(Result) - 1].Ativo := DM.QryAux['For_Ativo'];
      DM.QryAux.Next;
    end;
    Close;
  End;
end;

// Valor inserido na tabela CAIXA no campo CAI_VALORATUAL
// Pegando pelo ultimo valor inserido, ordenando pelo código
function ultimo_valor_caixa(): Real;
begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT CAI_VALORATUAL');
    SQL.Add('FROM CAIXA');
    SQL.Add('ORDER BY CAI_CODIGO DESC');
    Open;
    if DM.QryAux.RecordCount <> 0 Then
      Result := DM.QryAux['CAI_VALORATUAL']
    Else
      Result := 0;
    Close;
  End;
end;

Function Retorna_Todos_Clientes_Cadastrados: Clientes_Cadastrados;
{ Valores possiveis para "Campo"
  Codigo: Cli_Codigo
  Nome: Cli_Nome
  Endereco: Cli_Endereco
  Telefone: Cli_Telefone
  CPF: Cli_Cpf }
var
  i: Integer;
begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Cliente ');
    SQL.Add('ORDER BY Cli_Nome ASC');
    Open;
    FetchAll;
    SetLength(Result, 0);
    for i := 1 to DM.QryAux.RecordCount do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1].Codigo := DM.QryAux['CLI_CODIGO'];
      Result[Length(Result) - 1].Nome := DM.QryAux['Cli_Nome'];
      Result[Length(Result) - 1].Endereco := DM.QryAux['Cli_Endereco'];
      Result[Length(Result) - 1].CPF := DM.QryAux['Cli_Cpf'];
      Result[Length(Result) - 1].Telefone := DM.QryAux['Cli_Telefone'];
      { Result[Length(Result)-1].Celular:= Dm.QryAux['Cli_Celular'];
        Result[Length(Result)-1].Time:= Dm.QryAux['Cli_Time'];
        Result[Length(Result)-1].Religiao:= Dm.QryAux['Cli_Religiao']; }
      Result[Length(Result) - 1].Sexo := DM.QryAux['Cli_Sexo'];
      DM.QryAux.Next;
    end;
    Close;
  End;
end;

procedure insere_valor_caixa(Descricao: String; valor_movimentacao: Real;
  Data: String; Hora: String);
var
  total_atual: Real;
  val: String;
  tot: String;
begin
  total_atual := valor_movimentacao + ultimo_valor_caixa();
  val := TrocaVirgulaPonto(FloatToStr(valor_movimentacao));
  tot := TrocaVirgulaPonto(FloatToStr(total_atual));
  With DM.QryCaixa do
  Begin
    SQL.Clear;
    SQL.Add('INSERT INTO CAIXA VALUES(');
    SQL.Add(Retorna_Proximo_Codigo_Caixa + ',');
    SQL.Add(QuotedStr(Descricao) + ',');
    SQL.Add(QuotedStr(Data) + ',');
    SQL.Add(QuotedStr(Hora) + ',');
    SQL.Add(val + ',');
    SQL.Add(tot);
    SQL.Add(')');
    ExecSQL;
    Commit;
    Close;
  End;
end;

procedure insere_contas_receber(data_vencimento: String; valor_parcela: Real;
  codigo_cliente: Integer);

var
  Valor: String;
begin
  Valor := TrocaVirgulaPonto(FloatToStr(valor_parcela));
  With DM.QryCaixa do
  Begin
    SQL.Clear;
    SQL.Add('INSERT INTO CONTAS_RECEBER VALUES(');
    SQL.Add(Retorna_Proximo_Codigo_Contas_Receber + ',');
    SQL.Add(QuotedStr(data_vencimento) + ',');
    SQL.Add(Valor + ',');
    SQL.Add(IntToStr(codigo_cliente) + ',');
    SQL.Add(IntToStr(0) + ',');
    SQL.Add(QuotedStr(''));
    SQL.Add(')');
    ExecSQL;
    Commit;
    Close;
  End;
end;

Function Retorna_Proximo_Codigo_Caixa: String;
Begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT CAI_CODIGO');
    SQL.Add('FROM CAIXA');
    SQL.Add('ORDER BY CAI_CODIGO DESC');
    Open;
    if DM.QryAux.RecordCount <> 0 Then
      Result := IntToStr(DM.QryAux['CAI_CODIGO'] + 1)
    Else
      Result := '1';
    Close;
  End;
End;

Function Retorna_Proximo_Codigo_Contas_Receber: String;
Begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT CREC_CODIGO');
    SQL.Add('FROM CONTAS_RECEBER');
    SQL.Add('ORDER BY CREC_CODIGO DESC');
    Open;
    if DM.QryAux.RecordCount <> 0 Then
      Result := IntToStr(DM.QryAux['CREC_CODIGO'] + 1)
    Else
      Result := '1';
    Close;
  End;
End;

Function Retorna_Proximo_Codigo_Contas_Pagar: String;
Begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT CPA_CODIGO');
    SQL.Add('FROM CONTAS_PAGAR');
    SQL.Add('ORDER BY CPA_CODIGO DESC');
    Open;
    if DM.QryAux.RecordCount <> 0 Then
      Result := IntToStr(DM.QryAux['CPA_CODIGO'] + 1)
    Else
      Result := '1';
    Close;
  End;
End;

procedure pagaConta(codigoConta: Integer);
var
  Valor: Real;
begin
  With DM.QryContaReceber do
  Begin
    SQL.Clear;
    SQL.Add('UPDATE CONTAS_RECEBER SET');
    SQL.Add('CREC_PAGO = ' + IntToStr(1) + ',');
    SQL.Add('CREC_DATA_PAGAMENTO = ' + QuotedStr(DateToStr(Date)));
    SQL.Add('WHERE CREC_CODIGO = ' + IntToStr(codigoConta));
    ExecSQL;
    Commit;
    Close;
  End;

  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT CREC_VALOR');
    SQL.Add('FROM CONTAS_RECEBER');
    SQL.Add('WHERE CREC_CODIGO = ' + IntToStr(codigoConta));
    Open;
    if DM.QryAux.RecordCount <> 0 Then
      Valor := DM.QryAux['CREC_VALOR'];
    Close;
  End;

  insere_valor_caixa('Pagamento Parcela', Valor, DateToStr(Date),
    TimeToStr(Time));
end;

function retorna_quantidade_estoque(codProduto: Integer): Integer;
begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM PRODUTO');
    SQL.Add('WHERE PRO_CODIGO = ' + IntToStr(codProduto));
    Open;
    if DM.QryAux.RecordCount <> 0 Then
    begin
      Result := DM.QryAux['PRO_ESTOQUE'];
    end;
    Close;
  End;
end;

procedure atualiza_produto_compra(codProduto: Integer; Quantidade: Integer;
  preVenda: Real);
var
  qtdeAtual: Real;
begin
  qtdeAtual := Quantidade + retorna_quantidade_estoque(codProduto);
  With DM.QryProduto do
  Begin
    SQL.Clear;
    SQL.Add('UPDATE PRODUTO SET');
    SQL.Add('PRO_ESTOQUE = ' + FloatToStr(qtdeAtual) + ',');
    SQL.Add('PRO_PREVENDA = ' + TrocaVirgulaPonto(FloatToStr(preVenda)));
    SQL.Add('WHERE PRO_CODIGO = ' + IntToStr(codProduto));
    ExecSQL;
    Commit;
    Close;
  End;

end;

procedure insere_contas_pagar(data_vencimento: String; valor_parcela: Real;
  cod_Fornecedor: Integer);
var
  Codigo: String;
  val_parcela: String;
begin
  Codigo := Retorna_Proximo_Codigo_Contas_Pagar;
  valor_parcela := Trunc(valor_parcela * 100) / 100;
  val_parcela := TrocaVirgulaPonto(FloatToStr(valor_parcela));
  With DM.QryContaPagar do
  Begin
    SQL.Clear;
    SQL.Add('INSERT INTO CONTAS_PAGAR VALUES(');
    SQL.Add(Codigo + ',');
    SQL.Add(val_parcela + ',');
    SQL.Add(QuotedStr(data_vencimento) + ',');
    SQL.Add(IntToStr(cod_Fornecedor) + ',');
    SQL.Add(IntToStr(0) + ',');
    SQL.Add(QuotedStr(''));
    SQL.Add(')');
    ExecSQL;
    Commit;
    Close;
  End;
end;

Function Retorna_Produtos_Venda(CodVenda: Integer): Produtos_Venda;
var
  i: Integer;
begin
  With DM.QryProduto do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Produto_Venda ');
    { Filtro }
    SQL.Add('WHERE ProdVen_CodVenda = ' + IntToStr(CodVenda));

    Open;
    FetchAll;
    SetLength(Result, 0);

    for i := 1 to DM.QryProduto.RecordCount do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1].Codigo := DM.QryProduto['ProdVen_CodProduto'];
      Result[Length(Result) - 1].Preco := DM.QryProduto['Preco_Venda'];
      Result[Length(Result) - 1].Quantidade :=
        DM.QryProduto['ProdVen_QtdProduto'];
      DM.QryProduto.Next;
    end;
    Close;
  End;
end;

Function Retorna_Todas_Vendas: Vendas;
var
  i, CodVenda: Integer;
begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Venda ');
    SQL.Add('ORDER BY Ven_Codigo ASC');
    Open;
    FetchAll;
    SetLength(Result, 0);
    for i := 1 to DM.QryAux.RecordCount do
    begin
      SetLength(Result, Length(Result) + 1);
      CodVenda := DM.QryAux['VEN_CODIGO'];
      Result[Length(Result) - 1].Codigo := CodVenda;
      Result[Length(Result) - 1].Data := DM.QryAux['VEN_DATA'];
      Result[Length(Result) - 1].Valor := DM.QryAux['VEN_TOTAL'];
      Result[Length(Result) - 1].ProdutosVenda :=
        Retorna_Produtos_Venda(CodVenda);

      DM.QryAux.Next;
    end;
    Close;
  End;
end;

Function Retorna_lucro: Real;
Begin
  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT EMP_LUCRO');
    SQL.Add('FROM EMPRESA');
    Open;
    if DM.QryAux.RecordCount <> 0 Then
      Result := DM.QryAux['EMP_LUCRO']
    Else
      Result := 0;
    Close;
  End;
End;

Function Retorna_Contas_Receber: Contas_Receber;
var
  i, CodVenda: Integer;
begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM CONTAS_RECEBER ');
    SQL.Add('WHERE CREC_PAGO = 0');
    Open;
    FetchAll;
    SetLength(Result, 0);
    for i := 1 to DM.QryAux.RecordCount do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1].Codigo := DM.QryAux['CREC_CODIGO'];
      Result[Length(Result) - 1].Vencimento :=
        DM.QryAux['CREC_DATA_VENCIMENTO'];
      Result[Length(Result) - 1].Valor := DM.QryAux['CREC_VALOR'];
      Result[Length(Result) - 1].Cliente := DM.QryAux['CREC_CLIENTE_CODIGO'];
      Result[Length(Result) - 1].Pago := DM.QryAux['CREC_PAGO'];
      Result[Length(Result) - 1].DataPagamento :=
        DM.QryAux['CREC_DATA_PAGAMENTO'];
      DM.QryAux.Next;
    end;
    Close;
  End;
end;

Function Retorna_Contas_Pagar: Contas_Pagar;
var
  i, CodVenda: Integer;
begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM CONTAS_PAGAR ');
    SQL.Add('WHERE CPA_PAGO = 0');
    Open;
    FetchAll;
    SetLength(Result, 0);
    for i := 1 to DM.QryAux.RecordCount do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1].Codigo := DM.QryAux['CPA_CODIGO'];
      Result[Length(Result) - 1].Vencimento := DM.QryAux['CPA_VENCIMENTO'];
      Result[Length(Result) - 1].Valor := DM.QryAux['CPA_VALOR'];
      Result[Length(Result) - 1].Fornecedor :=
        DM.QryAux['CPA_CODIGO_FORNECEDOR'];
      Result[Length(Result) - 1].Pago := DM.QryAux['CPA_PAGO'];
      Result[Length(Result) - 1].DataPagamento :=
        DM.QryAux['CPA_DATA_PAGAMENTO'];
      DM.QryAux.Next;
    end;
    Close;
  End;
end;

procedure pagaContaForncedor(codigoConta: Integer);
var
  Valor: Real;
begin
  With DM.QryContaReceber do
  Begin
    SQL.Clear;
    SQL.Add('UPDATE CONTAS_PAGAR SET');
    SQL.Add('CPA_PAGO = ' + IntToStr(1) + ',');
    SQL.Add('CPA_DATA_PAGAMENTO = ' + QuotedStr(DateToStr(Date)));

    SQL.Add('WHERE CPA_CODIGO = ' + IntToStr(codigoConta));
    ExecSQL;
    Commit;
    Close;
  End;

  With DM.QryAux do
  Begin
    SQL.Clear;
    SQL.Add('SELECT CPA_VALOR');
    SQL.Add('FROM CONTAS_PAGAR');
    SQL.Add('WHERE CPA_CODIGO = ' + IntToStr(codigoConta));
    Open;
    if DM.QryAux.RecordCount <> 0 Then
      Valor := DM.QryAux['CPA_VALOR'];
    Close;
  End;
  Valor := Valor * -1;
  insere_valor_caixa('Pagamento Parcela', Valor, DateToStr(Date),
    TimeToStr(Time));
end;

Function Retorna_Caixa: Dados_Caixa;
var
  i, CodVenda: Integer;
begin
  With DM.QryAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM CAIXA ');
    Open;
    FetchAll;
    SetLength(Result, 0);
    for i := 1 to DM.QryAux.RecordCount do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1].Codigo := DM.QryAux['CAI_CODIGO'];
      Result[Length(Result) - 1].Descricao := DM.QryAux['CAI_DESCRICAO'];
      Result[Length(Result) - 1].Data := DM.QryAux['CAI_DATA'];
      Result[Length(Result) - 1].Hora := DM.QryAux['CAI_HORA'];
      Result[Length(Result) - 1].ValorMovimentacao :=
        DM.QryAux['CAI_VALORMOVIMENTACAO'];
      Result[Length(Result) - 1].ValorAtual := DM.QryAux['CAI_VALORATUAL'];
      DM.QryAux.Next;
    end;
    Close;
  End;
end;

end.
