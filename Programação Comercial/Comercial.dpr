program Comercial;

uses
  Vcl.Forms,
  Unit_Empresa in 'Unit_Empresa.pas' {Form_DadosEmpresa},
  Vcl.Themes,
  Vcl.Styles,
  Unit_Persistencia in 'Unit_Persistencia.pas',
  Unit_Util in 'Unit_Util.pas',
  Unit_Principal in 'Unit_Principal.pas' {Form_Principal},
  Unit_Clientes in 'Unit_Clientes.pas' {Form_Clientes},
  Unit_DM in 'Unit_DM.pas' {DM: TDataModule},
  Unit_Produtos in 'Unit_Produtos.pas' {Form_Produtos},
  Unit_GrupoProd in 'Unit_GrupoProd.pas' {Form_GrupoProd},
  Unit_SubGrupoProd in 'Unit_SubGrupoProd.pas' {Form_SubGrupoProd},
  Unit_AlteraPreco in 'Unit_AlteraPreco.pas' {Form_AlteraPreco},
  Unit_Venda in 'Unit_Venda.pas' {Form_Venda},
  Unit_Fornecedores in 'Unit_Fornecedores.pas' {Form_Fornecedores},
  Unit_Contas_Receber in 'Unit_Contas_Receber.pas' {Form_Receber_Conta},
  Unit_Entrada_Produtos in 'Unit_Entrada_Produtos.pas' {Form_Entrada_Produtos},
  Unit_Feedback in 'Unit_Feedback.pas' {Form_feedback},
  Unit_Contas_Pagar in 'Unit_Contas_Pagar.pas' {Form_Contas_Pagar},
  Unit_Caixa in 'Unit_Caixa.pas' {Form_Caixa};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm_Principal, Form_Principal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
