unit Unit_SubGrupoProd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.Grids, Vcl.ComCtrls, Unit_Persistencia, Unit_Util, StrUtils,
  Vcl.Menus;

type
  TForm_SubGrupoProd = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    sgdSubGrupoProd: TStringGrid;
    Panel1: TPanel;
    cb_campos: TComboBox;
    edit_pesquisa: TMaskEdit;
    btn_Pesquisar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    btn_sair: TBitBtn;
    btn_gravar: TBitBtn;
    btn_cancelar: TBitBtn;
    btn_limpar: TBitBtn;
    btn_novo: TBitBtn;
    lab_qtdDados: TLabel;
    PopupMenu1: TPopupMenu;
    EditarCadastro1: TMenuItem;
    Panel3: TPanel;
    Btn_AZ: TBitBtn;
    Btn_ZA: TBitBtn;
    Btn_12: TBitBtn;
    Btn_21: TBitBtn;
    Label3: TLabel;
    edit_cod: TLabeledEdit;
    edit_descricao: TLabeledEdit;
    cbxGrupo: TComboBox;
    Label4: TLabel;
    cbx_mostrarExcluidos: TCheckBox;
    ExcluirCadastro1: TMenuItem;
    procedure btn_sairClick(Sender: TObject);
    procedure btn_limparClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_novoClick(Sender: TObject);
    procedure btn_gravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Btn_AZClick(Sender: TObject);
    procedure Btn_ZAClick(Sender: TObject);
    procedure Btn_12Click(Sender: TObject);
    procedure Btn_21Click(Sender: TObject);
    procedure sgdSubGrupoProdSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure sgdSubGrupoProdDblClick(Sender: TObject);
    procedure cb_camposChange(Sender: TObject);
    procedure edit_pesquisaChange(Sender: TObject);
    procedure btn_PesquisarClick(Sender: TObject);

    procedure HabilitaTela(Habilita: Boolean);
    procedure HabilitaBotoes(Quais: String);
    procedure Preenche_Componentes;
    Procedure Atualiza_Combo_Grupo(Descricao: String);
    procedure PopulaGrid;
    procedure PintaGrid;
    procedure LimpaTela;
    procedure CarregaGruposCadastrados;
    function Coleta_Dados: Dados_SubGrupoProd;
    function Validado: Boolean;
    procedure ExcluirCadastro1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_SubGrupoProd: TForm_SubGrupoProd;
  var Linha: integer;
  Novo: Boolean;

implementation

{$R *.dfm}

procedure TForm_SubGrupoProd.CarregaGruposCadastrados;
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

procedure TForm_SubGrupoProd.btn_sairClick(Sender: TObject);
begin
    Form_SubGrupoProd.Close;
end;

procedure TForm_SubGrupoProd.HabilitaBotoes(Quais: String);
begin
    if(Quais[1] = '0')
      then btn_novo.Enabled:= False
      else btn_novo.enabled:= True;
    if(Quais[2] = '0')
      then btn_limpar.Enabled:= False
      else btn_limpar.enabled:= True;
    if(Quais[3] = '0')
      then btn_cancelar.Enabled:= False
      else btn_cancelar.enabled:= True;
    if(Quais[4] = '0')
      then btn_gravar.Enabled:= False
      else btn_gravar.enabled:= True;
    if(Quais[5] = '0')
      then btn_sair.Enabled:= False
      else btn_sair.enabled:= True;
end;

procedure TForm_SubGrupoProd.HabilitaTela(Habilita: Boolean);
begin
    {edit_cod.Enabled:=      Habilita;}
    edit_descricao.Enabled:= Habilita;
    cbxGrupo.Enabled:=       Habilita;
    Label4.Enabled:=         Habilita;
    CarregaGruposCadastrados;
end;

procedure TForm_SubGrupoProd.LimpaTela;
begin
    edit_cod.Clear;
    edit_descricao.Clear;
    cbxGrupo.ItemIndex := -1;
end;

procedure TForm_SubGrupoProd.Btn_12Click(Sender: TObject);
begin
    btn_az.Enabled := true;
    btn_za.Enabled := true;
    btn_12.Enabled := false;
    btn_21.Enabled := true;
    PopulaGrid;
end;

procedure TForm_SubGrupoProd.Btn_21Click(Sender: TObject);
begin
    btn_az.Enabled := true;
    btn_za.Enabled := true;
    btn_12.Enabled := true;
    btn_21.Enabled := false;
    PopulaGrid;
end;

procedure TForm_SubGrupoProd.Btn_AZClick(Sender: TObject);
begin
    btn_az.Enabled := false;
    btn_za.Enabled := true;
    btn_12.Enabled := true;
    btn_21.Enabled := true;
    PopulaGrid;
end;

procedure TForm_SubGrupoProd.btn_cancelarClick(Sender: TObject);
begin
    if(Application.MessageBox('Deseja realmente cancelar?', 'Cancelar', MB_ICONQUESTION+MB_YESNO) = mrYes)
      then begin
              LimpaTela;
              HabilitaBotoes('10001');
              HabilitaTela(False);
      end;
end;

procedure TForm_SubGrupoProd.btn_gravarClick(Sender: TObject);
var Prod_Com_SubGrupo: Prods_Com_SubGrupo;
begin
    if Validado
      Then begin
        if Novo
          then Grava_Dados_SubGrupoProd(Coleta_Dados)
          else begin
          Prod_Com_SubGrupo := Tem_Prod_SubGrupo(Coleta_Dados.Codigo);
          if Length(Prod_Com_SubGrupo) > 0
            then Begin
              if(Application.MessageBox('Existem Produtos com este Sub Grupo, Deseja atualiza-los automaticamente','Atualizar Produtos?', MB_ICONWARNING+MB_YESNOCANCEL) = mrYes)
                Then Atualiza_Produtos_Cascata(Prod_Com_SubGrupo, Retorna_Codigo_Grupo(cbxGrupo.Text));
              Atualiza_Dados_SubGrupoProd(Coleta_Dados);
            End;
          end;
          HabilitaTela(False);
          HabilitaBotoes('10001');
          LimpaTela;
          PopulaGrid;
      end;
end;

procedure TForm_SubGrupoProd.btn_limparClick(Sender: TObject);
begin
    if(Application.MessageBox('Deseja realmente limpar todos os campos?', 'Limpar Campos', MB_ICONQUESTION+MB_YESNO) = mrYes)
      then begin
              LimpaTela;
              edit_descricao.SetFocus;
      end;
end;

procedure TForm_SubGrupoProd.btn_novoClick(Sender: TObject);
begin
    Novo := True;
    HabilitaTela(True);
    HabilitaBotoes('01110');
    edit_cod.Text := Retorna_Proximo_Codigo_SubGrupoProd;
end;

procedure TForm_SubGrupoProd.btn_PesquisarClick(Sender: TObject);
begin
    PopulaGrid;
end;

procedure TForm_SubGrupoProd.Btn_ZAClick(Sender: TObject);
begin
    btn_az.Enabled := true;
    btn_za.Enabled := false;
    btn_12.Enabled := true;
    btn_21.Enabled := true;
    PopulaGrid;
end;

procedure TForm_SubGrupoProd.cb_camposChange(Sender: TObject);
begin
    case cb_campos.ItemIndex of
      0: Begin
        edit_pesquisa.EditMask:='';
      End;
      1: Begin
        edit_pesquisa.EditMask:='';
      End;
      2: Begin
        edit_pesquisa.EditMask:='';
      End;
      3: Begin
        edit_pesquisa.EditMask:='999.999.999-99';
      End;
      4: Begin
        edit_pesquisa.EditMask:='(99)9999-9999;1;_';
      End;
    end;
end;

procedure TForm_SubGrupoProd.sgdSubGrupoProdDblClick(Sender: TObject);
begin
  if(sgdSubGrupoProd.Cells[0,Linha] <> '')
     Then Begin
      Preenche_Componentes;
     End
     Else ShowMessage('É necessario selecionar um registro valido');
end;

procedure TForm_SubGrupoProd.sgdSubGrupoProdSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
    Linha:= ARow;
end;

procedure TForm_SubGrupoProd.edit_pesquisaChange(Sender: TObject);
Const Numeros = ['0'..'9'];
var i: Integer;
begin
    if(cb_campos.ItemIndex = 0)
      Then Begin
        for I := 1 to Length(edit_pesquisa.Text) do
          begin
              if(not(edit_pesquisa.Text[I] in Numeros))
                Then Begin
                   Application.MessageBox('Ao pesquisar por codigo utilize apenas números','Erro',MB_ICONWARNING + MB_OK);
                   edit_pesquisa.Clear;
                End;
          end;
        PopulaGrid;
      End
    Else PopulaGrid;
end;

procedure TForm_SubGrupoProd.ExcluirCadastro1Click(Sender: TObject);
begin
    if (isNumero(sgdSubGrupoProd.Cells[0,Linha]))
      Then Begin
       if(sgdSubGrupoProd.Cells[0,Linha] <> '')
          Then Begin
            if(Application.MessageBox('Deseja realmente excluir o sub grupo?', 'Excluir Sub Grupo', MB_ICONQUESTION+MB_YESNO) = mrYes)
              then begin
                ApagaSubGrupoProd(strtoint(sgdSubGrupoProd.Cells[0,Linha]));
                PopulaGrid;
              end;
          End
        Else ShowMessage('É necessario selecionar um registro valido');
      End;

end;

procedure TForm_SubGrupoProd.FormShow(Sender: TObject);
begin
    PageControl1.ActivePageIndex:= 0;
    PintaGrid;
    PopulaGrid;
    linha:=1;
end;

procedure TForm_SubGrupoProd.PopulaGrid();
var SubGrupoProd_Atuais: SubGrupoProd_Cadastrados;
    I: Integer;
    Campo, Termo: String;
begin
    if Trim(edit_pesquisa.Text) = ''
    Then Begin
      Campo := '';
      Termo := '';
    End
    Else Begin
      case cb_campos.ItemIndex of
        0: Begin
          Campo := 'Codigo';
        End;
        1: Begin
          Campo := 'Descricao';
        End;
      end;
    End;
    Termo:= Trim(edit_pesquisa.Text);

    SetLength(SubGrupoProd_Atuais,0);
    if(not(btn_az.Enabled)) Then
        SubGrupoProd_Atuais := Retorna_SubGrupoProd_Cadastrados(Campo,Termo,'AZ', cbx_mostrarExcluidos.Checked);
    if(not(btn_za.Enabled)) Then
        SubGrupoProd_Atuais := Retorna_SubGrupoProd_Cadastrados(Campo,Termo,'ZA', cbx_mostrarExcluidos.Checked);
    if(not(btn_12.Enabled)) Then
        SubGrupoProd_Atuais := Retorna_SubGrupoProd_Cadastrados(Campo,Termo,'12', cbx_mostrarExcluidos.Checked);
    if(not(btn_21.Enabled)) Then
        SubGrupoProd_Atuais := Retorna_SubGrupoProd_Cadastrados(Campo,Termo,'21', cbx_mostrarExcluidos.Checked);
        if(Length(SubGrupoProd_Atuais) >= 1)
          Then sgdSubGrupoProd.RowCount := Length(SubGrupoProd_Atuais)+1
          Else Begin
            sgdSubGrupoProd.RowCount := 2;
            sgdSubGrupoProd.Cells[0,1]:= '';
            sgdSubGrupoProd.Cells[1,1]:= '';
            sgdSubGrupoProd.Cells[2,1]:= '';
          End;
    lab_qtdDados.Caption:= InttoStr(Length(SubGrupoProd_Atuais))+' Grupo de Produtos Cadastrados';
    for I := 0 to Length(SubGrupoProd_Atuais) - 1 do
      begin
        sgdSubGrupoProd.Cells[0,I+1]:= IntToStr(SubGrupoProd_Atuais[I].Codigo);
        sgdSubGrupoProd.Cells[1,I+1]:= SubGrupoProd_Atuais[I].Descricao;
        sgdSubGrupoProd.Cells[2,I+1]:= Retorna_Dados_GrupoProd(SubGrupoProd_Atuais[I].Cod_Grupo).Descricao;
      end;
end;


procedure TForm_SubGrupoProd.Preenche_Componentes;
var Temp: Dados_SubGrupoProd;
begin
    HabilitaTela(True);
    HabilitaBotoes('01110');
    Temp:= Retorna_Dados_SubGrupoProd(StrToInt(sgdSubGrupoProd.Cells[0,Linha]));
    edit_cod.text:= inttostr(Temp.Codigo);
    edit_descricao.text:= Temp.Descricao;
    Atualiza_Combo_Grupo(Retorna_Dados_GrupoProd(Temp.Cod_Grupo).Descricao);
    PageControl1.ActivePageIndex := 1;
    Novo := False;
end;

Procedure TForm_SubGrupoProd.Atualiza_Combo_Grupo(Descricao: String);
Var I:Integer;
Begin
    for I := 0 to cbxGrupo.Items.Count do
      if cbxGrupo.Items[i] = Descricao
        Then Begin
          cbxGrupo.ItemIndex:= I;
          Break;
        End;
End;

function TForm_SubGrupoProd.Coleta_Dados: Dados_SubGrupoProd;
var Temp: Dados_SubGrupoProd;
begin
    Temp.Codigo:=strtoint(edit_cod.text);
    Temp.Descricao:=edit_descricao.text;
    Temp.Cod_Grupo:= Retorna_Codigo_Grupo(cbxGrupo.Text);
    Result := Temp;
end;

procedure TForm_SubGrupoProd.PintaGrid;
begin
    sgdSubGrupoProd.Cells[0,0]:= 'Cód.';
    sgdSubGrupoProd.Cells[1,0]:= 'Descrição';
    sgdSubGrupoProd.Cells[2,0]:= 'Grupo';
    sgdSubGrupoProd.ColWidths[0]:= 60;
    sgdSubGrupoProd.ColWidths[1]:= 300;
    sgdSubGrupoProd.ColWidths[2]:= 60;
end;

function TForm_SubGrupoProd.Validado: Boolean;
begin
    if(trim(edit_descricao.text) = '')
      Then Begin
         Application.MessageBox('O Campo de descrição é obrigatorio',
                                'Informe a Descrição',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex := 1;
         edit_descricao.SetFocus;
         Exit;
      End;

    result:= true;
end;

end.
