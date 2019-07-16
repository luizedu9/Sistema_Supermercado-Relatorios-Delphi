unit Unit_GrupoProd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.Grids, Vcl.ComCtrls, Unit_Persistencia, Unit_Util, StrUtils,
  Vcl.Menus;

type
  TForm_GrupoProd = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    sgdGrupoProd: TStringGrid;
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
    procedure sgdGrupoProdSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure sgdGrupoProdDblClick(Sender: TObject);
    procedure cb_camposChange(Sender: TObject);
    procedure edit_pesquisaChange(Sender: TObject);
    procedure btn_PesquisarClick(Sender: TObject);

    procedure HabilitaTela(Habilita: Boolean);
    procedure HabilitaBotoes(Quais: String);
    procedure Preenche_Componentes;
    procedure PopulaGrid;
    procedure PintaGrid;
    procedure LimpaTela;
    function Coleta_Dados: Dados_GrupoProd;
    function Validado: Boolean;
    procedure ExcluirCadastro1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_GrupoProd: TForm_GrupoProd;
  var Linha: integer;
  Novo: Boolean;

implementation

{$R *.dfm}

procedure TForm_GrupoProd.btn_sairClick(Sender: TObject);
begin
    Form_GrupoProd.Close;
end;

procedure TForm_GrupoProd.HabilitaBotoes(Quais: String);
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

procedure TForm_GrupoProd.HabilitaTela(Habilita: Boolean);
begin
    {edit_cod.Enabled:=      Habilita;}
    edit_descricao.Enabled:=     Habilita;
end;

procedure TForm_GrupoProd.LimpaTela;
begin
    edit_cod.Clear;
    edit_descricao.Clear;
end;

procedure TForm_GrupoProd.Btn_12Click(Sender: TObject);
begin
    btn_az.Enabled := true;
    btn_za.Enabled := true;
    btn_12.Enabled := false;
    btn_21.Enabled := true;
    PopulaGrid;
end;

procedure TForm_GrupoProd.Btn_21Click(Sender: TObject);
begin
    btn_az.Enabled := true;
    btn_za.Enabled := true;
    btn_12.Enabled := true;
    btn_21.Enabled := false;
    PopulaGrid;
end;

procedure TForm_GrupoProd.Btn_AZClick(Sender: TObject);
begin
    btn_az.Enabled := false;
    btn_za.Enabled := true;
    btn_12.Enabled := true;
    btn_21.Enabled := true;
    PopulaGrid;
end;

procedure TForm_GrupoProd.btn_cancelarClick(Sender: TObject);
begin
    if(Application.MessageBox('Deseja realmente cancelar?', 'Cancelar', MB_ICONQUESTION+MB_YESNO) = mrYes)
      then begin
              LimpaTela;
              HabilitaBotoes('10001');
              HabilitaTela(False);
      end;
end;

procedure TForm_GrupoProd.btn_gravarClick(Sender: TObject);
begin
    if Validado
      then begin
      if Novo
        then Grava_Dados_GrupoProd(Coleta_Dados)
        else Atualiza_Dados_GrupoProd(Coleta_Dados);
          HabilitaTela(False);
          HabilitaBotoes('10001');
          LimpaTela;
          PopulaGrid;
      end;
end;

procedure TForm_GrupoProd.btn_limparClick(Sender: TObject);
begin
    if(Application.MessageBox('Deseja realmente limpar todos os campos?', 'Limpar Campos', MB_ICONQUESTION+MB_YESNO) = mrYes)
      then begin
              LimpaTela;
              edit_descricao.SetFocus;
      end;
end;

procedure TForm_GrupoProd.btn_novoClick(Sender: TObject);
begin
    Novo := True;
    HabilitaTela(True);
    HabilitaBotoes('01110');
    edit_cod.Text := Retorna_Proximo_Codigo_GrupoProd;
end;

procedure TForm_GrupoProd.btn_PesquisarClick(Sender: TObject);
begin
    PopulaGrid;
end;

procedure TForm_GrupoProd.Btn_ZAClick(Sender: TObject);
begin
    btn_az.Enabled := true;
    btn_za.Enabled := false;
    btn_12.Enabled := true;
    btn_21.Enabled := true;
    PopulaGrid;
end;

procedure TForm_GrupoProd.cb_camposChange(Sender: TObject);
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

procedure TForm_GrupoProd.sgdGrupoProdDblClick(Sender: TObject);
begin
  if(sgdGrupoProd.Cells[0,Linha] <> '')
     Then Begin
      Preenche_Componentes;
     End
     Else ShowMessage('É necessario selecionar um registro valido');
end;

procedure TForm_GrupoProd.sgdGrupoProdSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
    Linha:= ARow;
end;

procedure TForm_GrupoProd.edit_pesquisaChange(Sender: TObject);
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

procedure TForm_GrupoProd.ExcluirCadastro1Click(Sender: TObject);
begin
    if (isNumero(sgdGrupoProd.Cells[0,Linha]))
      Then Begin
       if(sgdGrupoProd.Cells[0,Linha] <> '')
          Then Begin
            if(Application.MessageBox('Deseja realmente excluir o grupo?', 'Excluir Grupo', MB_ICONQUESTION+MB_YESNO) = mrYes)
              then begin
                ApagaGrupoProd(strtoint(sgdGrupoProd.Cells[0,Linha]));
                PopulaGrid;
              end;
          End
        Else ShowMessage('É necessario selecionar um registro valido');
      End;
end;

procedure TForm_GrupoProd.FormShow(Sender: TObject);
begin
    PageControl1.ActivePageIndex:= 0;
    PintaGrid;
    PopulaGrid;
    linha:=1;
end;

procedure TForm_GrupoProd.PopulaGrid();
var GrupoProd_Atuais: GrupoProd_Cadastrados;
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

    SetLength(GrupoProd_Atuais,0);
    if(not(btn_az.Enabled)) Then
        GrupoProd_Atuais := Retorna_GrupoProd_Cadastrados(Campo,Termo,'AZ', cbx_mostrarExcluidos.Checked);
    if(not(btn_za.Enabled)) Then
        GrupoProd_Atuais := Retorna_GrupoProd_Cadastrados(Campo,Termo,'ZA', cbx_mostrarExcluidos.Checked);
    if(not(btn_12.Enabled)) Then
        GrupoProd_Atuais := Retorna_GrupoProd_Cadastrados(Campo,Termo,'12', cbx_mostrarExcluidos.Checked);
    if(not(btn_21.Enabled)) Then
        GrupoProd_Atuais := Retorna_GrupoProd_Cadastrados(Campo,Termo,'21', cbx_mostrarExcluidos.Checked);
        if(Length(GrupoProd_Atuais) >= 1)
          Then sgdGrupoProd.RowCount := Length(GrupoProd_Atuais)+1
          Else Begin
            sgdGrupoProd.RowCount := 2;
            sgdGrupoProd.Cells[0,1]:= '';
            sgdGrupoProd.Cells[1,1]:= '';
          End;
    lab_qtdDados.Caption:= InttoStr(Length(GrupoProd_Atuais))+' Grupo de Produtos Cadastrados';
    for I := 0 to Length(GrupoProd_Atuais) - 1 do
      begin
        sgdGrupoProd.Cells[0,I+1]:= IntToStr(GrupoProd_Atuais[I].Codigo);
        sgdGrupoProd.Cells[1,I+1]:= GrupoProd_Atuais[I].Descricao;
      end;
end;


procedure TForm_GrupoProd.Preenche_Componentes;
var Temp: Dados_GrupoProd;
begin
    Temp:= Retorna_Dados_GrupoProd(StrToInt(sgdGrupoProd.Cells[0,Linha]));
    edit_cod.text:= inttostr(Temp.Codigo);
    edit_descricao.text:= Temp.Descricao;
    PageControl1.ActivePageIndex := 1;
    HabilitaTela(True);
    HabilitaBotoes('01110');
    Novo := False;
end;

function TForm_GrupoProd.Coleta_Dados: Dados_GrupoProd;
var Temp: Dados_GrupoProd;
begin
    Temp.Codigo:=strtoint(edit_cod.text);
    Temp.Descricao:=edit_descricao.text;
    Result := Temp;
end;

procedure TForm_GrupoProd.PintaGrid;
begin
    sgdGrupoProd.Cells[0,0]:= 'Cód.';
    sgdGrupoProd.Cells[1,0]:= 'Descrição';
    sgdGrupoProd.ColWidths[0]:= 60;
    sgdGrupoProd.ColWidths[1]:= 300;
end;

function TForm_GrupoProd.Validado: Boolean;
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
