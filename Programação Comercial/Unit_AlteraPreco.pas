unit Unit_AlteraPreco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ExtCtrls, Unit_Persistencia, Vcl.Buttons;

type
  TForm_AlteraPreco = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    cbxGrupo: TComboBox;
    cbxSubGrupo: TComboBox;
    edit_Porcentagem: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btn_sair: TBitBtn;
    btn_gravar: TBitBtn;
    btn_cancelar: TBitBtn;

    procedure CarregaGruposCadastrados;
    procedure CarregaSubGruposCadatrados(Cod_Grupo:Integer);
    procedure cbxGrupoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_gravarClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_sairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_AlteraPreco: TForm_AlteraPreco;

implementation

{$R *.dfm}

procedure TForm_AlteraPreco.CarregaGruposCadastrados;
var Temp : GrupoProd_Cadastrados;
    I: integer;
begin
    cbxGrupo.Clear;
    Temp := Retorna_GrupoProd_Cadastrados('','','AZ', False);
    for I := 0 to Length(Temp) -1 do
      Begin
          cbxGrupo.Items.Add(Temp[i].Descricao);
      End;
end;

procedure TForm_AlteraPreco.CarregaSubGruposCadatrados(Cod_Grupo:Integer);
var Temp : SubGrupoProd_Cadastrados;
    I: integer;
begin
    cbxSubGrupo.Clear;
    Temp := Retorna_SubGrupoProd_Cadastrados('CodGrupo',inttostr(Cod_Grupo),'AZ', False);
    for I := 0 to Length(Temp) -1 do
      Begin
          cbxSubGrupo.Items.Add(Temp[i].Descricao);
      End;
end;

procedure TForm_AlteraPreco.btn_cancelarClick(Sender: TObject);
begin
    btn_gravar.Enabled:= False;
    btn_cancelar.Enabled:= False;
    cbxGrupo.ItemIndex:= -1;
    cbxSubGrupo.Clear;
    edit_Porcentagem.Value:= 0;
end;

procedure TForm_AlteraPreco.btn_gravarClick(Sender: TObject);
begin
    Atualiza_Preco_Venda(Retorna_Codigo_Grupo(cbxGrupo.Text), Retorna_Codigo_SubGrupo(cbxSubGrupo.Text), edit_Porcentagem.Value);
    btn_gravar.Enabled:= False;
    btn_cancelar.Enabled:= False;
    cbxGrupo.ItemIndex:= -1;
    cbxSubGrupo.Clear;
    edit_Porcentagem.Value:= 0;
    ShowMessage('Preços Atualizados com Sucesso');
end;

procedure TForm_AlteraPreco.btn_sairClick(Sender: TObject);
begin
    Form_AlteraPreco.Close;
end;

procedure TForm_AlteraPreco.cbxGrupoChange(Sender: TObject);
begin
    CarregaSubGruposCadatrados(Retorna_Codigo_Grupo(cbxGrupo.Text));
    cbxSubGrupo.Enabled := True;
    btn_gravar.Enabled:= True;
    btn_cancelar.Enabled:= True;
end;

procedure TForm_AlteraPreco.FormShow(Sender: TObject);
begin
    CarregaGruposCadastrados;
end;

end.
