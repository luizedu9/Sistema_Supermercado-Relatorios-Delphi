unit Unit_Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.Grids, Vcl.ComCtrls, Unit_Persistencia, Unit_Util, StrUtils,
  Vcl.Menus;

type
  TForm_Produtos = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    sgdProdutos: TStringGrid;
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
    edit_codBarras: TLabeledEdit;
    edit_precoVenda: TLabeledEdit;
    edit_precoCusto: TLabeledEdit;
    edit_estoqueMinimo: TLabeledEdit;
    edit_estoqueAtual: TLabeledEdit;
    CheckBox1: TCheckBox;
    cbxGrupo: TComboBoxEx;
    cbxSubGrupo: TComboBoxEx;
    Label4: TLabel;
    Label5: TLabel;
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
    procedure sgdProdutosSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure sgdProdutosDblClick(Sender: TObject);
    procedure cb_camposChange(Sender: TObject);
    procedure edit_pesquisaChange(Sender: TObject);
    procedure btn_PesquisarClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure cbxGrupoChange(Sender: TObject);

    procedure HabilitaTela(Habilita: Boolean);
    procedure HabilitaBotoes(Quais: String);
    procedure Preenche_Componentes;
    Procedure Atualiza_Combo_Grupo(Descricao: String);
    procedure Atualiza_Combo_SubGrupo(Descricao:String);
    procedure PopulaGrid;
    procedure PintaGrid;
    procedure LimpaTela;
    function Coleta_Dados: Dados_Produto;
    function Validado: Boolean;
    procedure CarregaGruposCadastrados;
    procedure CarregaSubGruposCadatrados(Cod_Grupo:Integer);
    procedure ExcluirCadastro1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Produtos: TForm_Produtos;
  var Linha: integer;
  Novo: Boolean;

implementation

{$R *.dfm}

procedure TForm_Produtos.CarregaGruposCadastrados;
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

procedure TForm_Produtos.CarregaSubGruposCadatrados(Cod_Grupo:Integer);
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

procedure TForm_Produtos.btn_sairClick(Sender: TObject);
begin
    Form_Produtos.Close;
end;

procedure TForm_Produtos.HabilitaBotoes(Quais: String);
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

procedure TForm_Produtos.HabilitaTela(Habilita: Boolean);
begin
    {edit_cod.Enabled:=      Habilita;}
    edit_descricao.Enabled:=     Habilita;
    edit_codBarras.Enabled:=     Habilita;
    edit_precoVenda.Enabled:=    Habilita;
    edit_precoCusto.Enabled:=    Habilita;
    edit_estoqueAtual.Enabled:=  Habilita;
    edit_estoqueMinimo.Enabled:= Habilita;
    Label4.Enabled:= Habilita;
    cbxGrupo.Enabled:= Habilita;
    CarregaGruposCadastrados;
end;

procedure TForm_Produtos.LimpaTela;
begin
    edit_cod.Clear;
    edit_descricao.Clear;
    edit_codBarras.Clear;
    edit_precoVenda.Clear;
    edit_precoCusto.Clear;
    edit_estoqueAtual.Clear;
    edit_estoqueMinimo.Clear;
    cbxGrupo.ItemIndex:= -1;
    cbxSubGrupo.ItemIndex:= -1;
end;

procedure TForm_Produtos.Btn_12Click(Sender: TObject);
begin
    btn_az.Enabled := true;
    btn_za.Enabled := true;
    btn_12.Enabled := false;
    btn_21.Enabled := true;
    PopulaGrid;
end;

procedure TForm_Produtos.Btn_21Click(Sender: TObject);
begin
    btn_az.Enabled := true;
    btn_za.Enabled := true;
    btn_12.Enabled := true;
    btn_21.Enabled := false;
    PopulaGrid;
end;

procedure TForm_Produtos.Btn_AZClick(Sender: TObject);
begin
    btn_az.Enabled := false;
    btn_za.Enabled := true;
    btn_12.Enabled := true;
    btn_21.Enabled := true;
    PopulaGrid;
end;

procedure TForm_Produtos.btn_cancelarClick(Sender: TObject);
begin
    if(Application.MessageBox('Deseja realmente cancelar?', 'Cancelar', MB_ICONQUESTION+MB_YESNO) = mrYes)
      then begin
              LimpaTela;
              HabilitaBotoes('10001');
              HabilitaTela(False);
      end;
end;

procedure TForm_Produtos.btn_gravarClick(Sender: TObject);
begin
    if Validado
      then begin
      if Novo
        then Grava_Dados_Produto(Coleta_Dados)
        else Atualiza_Dados_Produto(Coleta_Dados);
          HabilitaTela(False);
          HabilitaBotoes('10001');
          LimpaTela;
          PopulaGrid;
      end;
end;

procedure TForm_Produtos.btn_limparClick(Sender: TObject);
begin
    if(Application.MessageBox('Deseja realmente limpar todos os campos?', 'Limpar Campos', MB_ICONQUESTION+MB_YESNO) = mrYes)
      then begin
              LimpaTela;
              edit_descricao.SetFocus;
      end;
end;

procedure TForm_Produtos.btn_novoClick(Sender: TObject);
begin
    Novo := True;
    HabilitaTela(True);
    HabilitaBotoes('01110');
    edit_cod.Text := Retorna_Proximo_Codigo_Produto;
end;

procedure TForm_Produtos.btn_PesquisarClick(Sender: TObject);
begin
    PopulaGrid;
end;

procedure TForm_Produtos.Btn_ZAClick(Sender: TObject);
begin
    btn_az.Enabled := true;
    btn_za.Enabled := false;
    btn_12.Enabled := true;
    btn_21.Enabled := true;
    PopulaGrid;
end;

procedure TForm_Produtos.cbxGrupoChange(Sender: TObject);
var d:String;
begin
    d:=cbxGrupo.Text;
    CarregaSubGruposCadatrados(Retorna_Codigo_Grupo(d));
    cbxSubGrupo.Enabled := true;
    Label5.Enabled:= true;
end;

procedure TForm_Produtos.cb_camposChange(Sender: TObject);
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

procedure TForm_Produtos.sgdProdutosDblClick(Sender: TObject);
begin
  if(sgdProdutos.Cells[0,Linha] <> '')
     Then Begin
      Preenche_Componentes;
     End
     Else ShowMessage('É necessario selecionar um registro valido');
end;

procedure TForm_Produtos.sgdProdutosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
    Linha:= ARow;
end;

procedure TForm_Produtos.edit_pesquisaChange(Sender: TObject);
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

procedure TForm_Produtos.ExcluirCadastro1Click(Sender: TObject);
begin
    if (isNumero(sgdProdutos.Cells[0,Linha]))
      Then Begin
       if(sgdProdutos.Cells[0,Linha] <> '')
          Then Begin
            if(Application.MessageBox('Deseja realmente excluir o produto?', 'Excluir Produto', MB_ICONQUESTION+MB_YESNO) = mrYes)
              then begin
                ApagaProduto(strtoint(sgdProdutos.Cells[0,Linha]));
                PopulaGrid;
              end;
          End
        Else ShowMessage('É necessario selecionar um registro valido');
      End;

end;

procedure TForm_Produtos.FormShow(Sender: TObject);
begin
    PageControl1.ActivePageIndex:= 0;
    PintaGrid;
    PopulaGrid;
    linha:=1;
end;

procedure TForm_Produtos.PopulaGrid();
var Produtos_Atuais: Produtos_Cadastrados;
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
        2: Begin
          Campo := 'CodBarras';
        End;
      end;
    End;
    Termo:= Trim(edit_pesquisa.Text);

    SetLength(Produtos_Atuais,0);
    if(not(btn_az.Enabled)) Then
        Produtos_Atuais := Retorna_Produtos_Cadastrados(Campo,Termo,'AZ', cbx_mostrarExcluidos.Checked);
    if(not(btn_za.Enabled)) Then
        Produtos_Atuais := Retorna_Produtos_Cadastrados(Campo,Termo,'ZA', cbx_mostrarExcluidos.Checked);
    if(not(btn_12.Enabled)) Then
        Produtos_Atuais := Retorna_Produtos_Cadastrados(Campo,Termo,'12', cbx_mostrarExcluidos.Checked);
    if(not(btn_21.Enabled)) Then
        Produtos_Atuais := Retorna_Produtos_Cadastrados(Campo,Termo,'21', cbx_mostrarExcluidos.Checked);
        if(Length(Produtos_Atuais) >= 1)
          Then sgdProdutos.RowCount := Length(Produtos_Atuais)+1
          Else Begin
            sgdProdutos.RowCount := 2;
            sgdProdutos.Cells[0,1]:= '';
            sgdProdutos.Cells[1,1]:= '';
            sgdProdutos.Cells[2,1]:= '';
            sgdProdutos.Cells[3,1]:= '';
            sgdProdutos.Cells[4,1]:= '';
            sgdProdutos.Cells[5,1]:= '';
            sgdProdutos.Cells[6,1]:= '';
            sgdProdutos.Cells[7,1]:= '';
            sgdProdutos.Cells[8,1]:= '';
          End;
    lab_qtdDados.Caption:= InttoStr(Length(Produtos_Atuais))+' Produtos Cadastrados';
    for I := 0 to Length(Produtos_Atuais) - 1 do
      begin
        sgdProdutos.Cells[0,I+1]:= IntToStr(Produtos_Atuais[I].Codigo);
        sgdProdutos.Cells[1,I+1]:= Produtos_Atuais[I].Descricao;
        sgdProdutos.Cells[2,I+1]:= Produtos_Atuais[I].Cod_Barras;
        sgdProdutos.Cells[3,I+1]:= floattostr(Produtos_Atuais[I].Preco_Venda);
        sgdProdutos.Cells[4,I+1]:= floattostr(Produtos_Atuais[I].Preco_Custo);
        sgdProdutos.Cells[5,I+1]:= floattostr(Produtos_Atuais[I].Estoque_Atual);
        sgdProdutos.Cells[6,I+1]:= floattostr(Produtos_Atuais[I].Estoque_Minimo);
        if(Produtos_Atuais[I].Cod_Grupo <> 0)
          Then sgdProdutos.Cells[7,I+1]:= Retorna_Dados_GrupoProd(Produtos_Atuais[I].Cod_Grupo).Descricao;
        if(Produtos_Atuais[I].Cod_SubGrupo <> 0)
          Then sgdProdutos.Cells[8,I+1]:= Retorna_Dados_SubGrupoProd(Produtos_Atuais[I].Cod_SubGrupo).Descricao;
      end;
end;

procedure TForm_Produtos.Preenche_Componentes;
var Temp: Dados_Produto;
begin
    Temp:= Retorna_Dados_Produto(StrToInt(sgdProdutos.Cells[0,Linha]));
    edit_cod.text:= inttostr(Temp.Codigo);
    edit_descricao.text:= Temp.Descricao;
    edit_codBarras.text:= Temp.Cod_Barras;
    edit_precoCusto.text:= floattostr(Temp.Preco_Custo);
    edit_precoVenda.text:= floattostr(Temp.Preco_Venda);
    edit_estoqueMinimo.text:= floattostr(Temp.Estoque_Minimo);
    edit_estoqueAtual.text:= floattostr(Temp.Estoque_Atual);
    PageControl1.ActivePageIndex := 1;
    HabilitaTela(True);
    if (Temp.Cod_Grupo <> 0)
      then Atualiza_Combo_Grupo(Retorna_Dados_GrupoProd(Temp.Cod_Grupo).Descricao);
    if (Temp.Cod_SubGrupo <> 0)
      then Atualiza_Combo_SubGrupo(Retorna_Dados_SubGrupoProd(Temp.Cod_SubGrupo).Descricao);
    HabilitaBotoes('01110');
    Novo := False;
end;

Procedure TForm_Produtos.Atualiza_Combo_Grupo(Descricao: String);
Var I:Integer;
Begin
    cbxGrupo.ItemIndex:= -1;
    for I := 0 to cbxGrupo.Items.Count do
      if cbxGrupo.Items[i] = Descricao
        Then Begin
          cbxGrupo.ItemIndex:= I;
          Break;
        End;
End;

procedure TForm_Produtos.Atualiza_Combo_SubGrupo(Descricao:String);
Var I : Integer;
Begin
    cbxSubGrupo.ItemIndex:= -1;
    for I := 0 to cbxSubGrupo.Items.Count do
      if cbxSubGrupo.Items[I] = Descricao
        Then Begin
          cbxSubGrupo.ItemIndex := I;
          Break;
        End;
End;

procedure TForm_Produtos.CheckBox1Click(Sender: TObject);
begin
    if(CheckBox1.Checked)
      then sgdProdutos.ColWidths[4]:=100
      else sgdProdutos.ColWidths[4]:=-1;
end;

function TForm_Produtos.Coleta_Dados: Dados_Produto;
var Temp: Dados_Produto;
begin
    Temp.Codigo:=strtoint(edit_cod.text);
    Temp.Descricao:=edit_descricao.text;
    Temp.Cod_Barras:=edit_codBarras.text;
    Temp.Preco_Custo:=strtofloat(edit_precoCusto.text);
    Temp.Preco_Venda:=strtofloat(edit_precoVenda.text);
    Temp.Estoque_Minimo:=strtofloat(edit_estoqueMinimo.text);
    Temp.Estoque_Atual:=strtofloat(edit_estoqueAtual.text);
    Temp.Cod_Grupo:= Retorna_Codigo_Grupo(cbxGrupo.Text);
    Temp.Cod_SubGrupo:= Retorna_Codigo_SubGrupo(cbxSubGrupo.Text);
    Result := Temp;
end;

procedure TForm_Produtos.PintaGrid;
begin
    sgdProdutos.Cells[0,0]:= 'Cód.';
    sgdProdutos.Cells[1,0]:= 'Descrição';
    sgdProdutos.Cells[2,0]:= 'Código de Barras';
    sgdProdutos.Cells[3,0]:= 'Preço de Vendas';
    sgdProdutos.Cells[4,0]:= 'Preco de Custos';
    sgdProdutos.Cells[5,0]:= 'Estoque Atual';
    sgdProdutos.Cells[6,0]:= 'Estoque Minimo';
    sgdProdutos.Cells[7,0]:= 'Grupo';
    sgdProdutos.Cells[8,0]:= 'Sub Grupo';
    sgdProdutos.ColWidths[0]:= 60;
    sgdProdutos.ColWidths[1]:= 100;
    sgdProdutos.ColWidths[2]:= 100;
    sgdProdutos.ColWidths[3]:= 80;
    if(CheckBox1.Checked)
      then sgdProdutos.ColWidths[4]:=100
      else sgdProdutos.ColWidths[4]:=-1;
    sgdProdutos.ColWidths[5]:= 80;
    sgdProdutos.ColWidths[6]:= 80;
    sgdProdutos.ColWidths[7]:= 80;
    sgdProdutos.ColWidths[8]:= 80;
end;

function TForm_Produtos.Validado: Boolean;
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
    if(trim(edit_codBarras.text) = '')
      Then Begin
         Application.MessageBox('O Campo de Código de Barras é obrigatorio',
                                'Informe o Código de Barras',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex := 1;
         edit_codBarras.SetFocus;
         Exit;
      End;
    if(trim(edit_precoCusto.text) = '')
      Then Begin
         Application.MessageBox('O Campo de Preco de Custo é obrigatorio',
                                'Informe o Preco de Custo',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex := 1;
         edit_precoCusto.SetFocus;
         Exit;
      End;
    if(trim(edit_precoVenda.text) = '')
      Then Begin
         Application.MessageBox('O Campo de Preco de Venda é obrigatorio',
                                'Informe o Preco de Venda',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex := 1;
         edit_precoVenda.SetFocus;
         Exit;
      End;
    if(trim(edit_estoqueAtual.text) = '')
      Then Begin
         Application.MessageBox('O Campo de Estoque Atual é obrigatorio',
                                'Informe o Estoque Atual',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex := 1;
         edit_estoqueAtual.SetFocus;
         Exit;
      End;
    if(trim(edit_estoqueMinimo.text) = '')
      Then Begin
         Application.MessageBox('O Campo de Estoque Minimo é obrigatorio',
                                'Informe o Estoque Minimo',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex := 1;
         edit_estoqueMinimo.SetFocus;
         Exit;
      End;

    result:= true;
end;

end.
