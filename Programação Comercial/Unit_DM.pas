unit Unit_DM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBDatabase, IBCustomDataSet, IBQuery;

type
  TDM = class(TDataModule)
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    QryCliente: TIBQuery;
    QryCommit: TIBQuery;
    QryAux: TIBQuery;
    QryEmpresa: TIBQuery;
    QryProduto: TIBQuery;
    QryGrupoProd: TIBQuery;
    QrySubGrupoProd: TIBQuery;
    QryProdutoVenda: TIBQuery;
    qryFornecedor: TIBQuery;
    QryCaixa: TIBQuery;
    QryContaReceber: TIBQuery;
    QryContaPagar: TIBQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.
