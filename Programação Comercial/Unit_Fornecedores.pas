unit Unit_Fornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Buttons, Vcl.Grids, Vcl.ComCtrls, StrUtils, Unit_Util, Unit_Persistencia,
  Vcl.Menus;

type
  TForm_Fornecedores = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    lab_qtdDados: TLabel;
    sgdFornecedores: TStringGrid;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    btn_Pesquisar: TBitBtn;
    cb_campos: TComboBox;
    edit_pesquisa: TMaskEdit;
    Panel3: TPanel;
    Label3: TLabel;
    Btn_AZ: TBitBtn;
    Btn_ZA: TBitBtn;
    Btn_12: TBitBtn;
    Btn_21: TBitBtn;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    btn_sair: TBitBtn;
    btn_gravar: TBitBtn;
    btn_cancelar: TBitBtn;
    btn_limpar: TBitBtn;
    btn_novo: TBitBtn;
    label_cnpj: TLabel;
    label_tel: TLabel;
    edit_RazaoSocial: TLabeledEdit;
    edit_nomeFantasia: TLabeledEdit;
    edit_endereco: TLabeledEdit;
    edit_cnpj: TMaskEdit;
    edit_telefone: TMaskEdit;
    edit_cod: TLabeledEdit;
    Edit_InscricaoEstadual: TLabeledEdit;
    Edit_Email: TLabeledEdit;
    PopupMenu1: TPopupMenu;
    EditarCadastro1: TMenuItem;
    cbx_mostrarExcluidos: TCheckBox;
    ExcluirCadastro1: TMenuItem;
    procedure btn_novoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_limparClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_sairClick(Sender: TObject);
    procedure btn_gravarClick(Sender: TObject);
    procedure cb_camposChange(Sender: TObject);
    procedure edit_pesquisaChange(Sender: TObject);
    procedure btn_PesquisarClick(Sender: TObject);
    procedure sgdFornecedoresClick(Sender: TObject);
    procedure sgdFornecedoresSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Btn_12Click(Sender: TObject);
    procedure Btn_21Click(Sender: TObject);
    procedure Btn_AZClick(Sender: TObject);
    procedure Btn_ZAClick(Sender: TObject);

    procedure HabilitaTela(Habilita: Boolean);
    procedure HabilitaBotoes(Quais: String);
    procedure PintaGrid;
    procedure PopulaGrid();
    procedure LimpaTela;
    function Validado: Boolean;
    procedure Preenche_Componentes;
    function Coleta_Dados: Dados_Fornecedor;
    procedure EditarCadastro1Click(Sender: TObject);
    procedure ExcluirCadastro1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Fornecedores: TForm_Fornecedores;
  Linha: Integer;
  Novo: Boolean;

implementation

{$R *.dfm}



procedure TForm_Fornecedores.Btn_12Click(Sender: TObject);
begin
    btn_az.Enabled := true;
    btn_za.Enabled := true;
    btn_12.Enabled := false;
    btn_21.Enabled := true;
    PopulaGrid;
end;

procedure TForm_Fornecedores.Btn_21Click(Sender: TObject);
begin
    btn_az.Enabled := true;
    btn_za.Enabled := true;
    btn_12.Enabled := true;
    btn_21.Enabled := false;
    PopulaGrid;
end;

procedure TForm_Fornecedores.Btn_AZClick(Sender: TObject);
begin
    btn_az.Enabled := false;
    btn_za.Enabled := true;
    btn_12.Enabled := true;
    btn_21.Enabled := true;
    PopulaGrid;
end;

procedure TForm_Fornecedores.btn_cancelarClick(Sender: TObject);
begin
    if(Application.MessageBox('Deseja realmente cancelar?', 'Cancelar', MB_ICONQUESTION+MB_YESNO) = mrYes)
      then begin
              LimpaTela;
              HabilitaBotoes('10001');
              HabilitaTela(False);
      end;

end;

procedure TForm_Fornecedores.btn_gravarClick(Sender: TObject);
begin
    if Validado
      then begin
      if Novo
        then Grava_Dados_Fornecedor(Coleta_Dados)
        else Atualiza_Dados_Fornecedor(Coleta_Dados);
          HabilitaTela(False);
          HabilitaBotoes('10001');
          LimpaTela;
          PopulaGrid;
      end;

end;

procedure TForm_Fornecedores.btn_limparClick(Sender: TObject);
begin
    if(Application.MessageBox('Deseja realmente limpar todos os campos?', 'Limpar Campos', MB_ICONQUESTION+MB_YESNO) = mrYes)
      then begin
              LimpaTela;
              edit_nomeFantasia.SetFocus;
      end;

end;

procedure TForm_Fornecedores.btn_novoClick(Sender: TObject);
begin
    Novo := True;
    HabilitaTela(True);
    HabilitaBotoes('01110');
    edit_cod.Text := Retorna_Proximo_Codigo_Fornecedor;
end;

procedure TForm_Fornecedores.btn_PesquisarClick(Sender: TObject);
begin
    PopulaGrid;
end;

procedure TForm_Fornecedores.btn_sairClick(Sender: TObject);
begin
   Form_Fornecedores.Close;
end;

procedure TForm_Fornecedores.Btn_ZAClick(Sender: TObject);
begin
    btn_az.Enabled := true;
    btn_za.Enabled := false;
    btn_12.Enabled := true;
    btn_21.Enabled := true;
    PopulaGrid;
end;

procedure TForm_Fornecedores.cb_camposChange(Sender: TObject);
begin
    case cb_campos.ItemIndex of
      0: Begin
        edit_pesquisa.EditMask:='';
      End;
      1: Begin
        edit_pesquisa.EditMask:='';
      End;
      2: Begin
        edit_pesquisa.EditMask:='(99)9999-9999;1;_';
      End;
      3: Begin
        edit_pesquisa.EditMask:='99.999.999/9999-99;1;_';
      End;
    end;
end;

procedure TForm_Fornecedores.HabilitaTela(Habilita: Boolean);
begin
    {edit_cod.Enabled:=      Habilita;}
    edit_nomeFantasia.Enabled:=     Habilita;
    edit_RazaoSocial.Enabled:= Habilita;
    edit_nomeFantasia.Enabled:=      Habilita;
    Edit_InscricaoEstadual.Enabled:=      Habilita;
    edit_cnpj.Enabled:=      Habilita;
    edit_endereco.Enabled:= Habilita;
    edit_telefone.Enabled:=     Habilita;
    edit_Email.Enabled:=     Habilita;
    label_cnpj.Enabled:=       Habilita;
    label_tel.Enabled:=       Habilita;
end;

procedure TForm_Fornecedores.FormShow(Sender: TObject);
begin
    PageControl1.ActivePageIndex:= 0;
    PintaGrid;
    PopulaGrid;
    linha:=1;
end;

procedure TForm_Fornecedores.HabilitaBotoes(Quais: String);
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

procedure TForm_Fornecedores.PintaGrid;
begin
    sgdFornecedores.Cells[0,0]:= 'Cód.';
    sgdFornecedores.Cells[1,0]:= 'Nome';
    sgdFornecedores.Cells[2,0]:= 'Razao Social';
    sgdFornecedores.Cells[3,0]:= 'Inscrição Estadual';
    sgdFornecedores.Cells[4,0]:= 'CNPJ';
    sgdFornecedores.Cells[5,0]:= 'Endereço';
    sgdFornecedores.Cells[6,0]:= 'Telefone';
    sgdFornecedores.Cells[7,0]:= 'Email';
    sgdFornecedores.ColWidths[0]:= 60;
    sgdFornecedores.ColWidths[1]:= 100;
    sgdFornecedores.ColWidths[2]:= 100;
    sgdFornecedores.ColWidths[3]:= 80;
    sgdFornecedores.ColWidths[4]:= 80;
    sgdFornecedores.ColWidths[5]:= 80;
    sgdFornecedores.ColWidths[6]:= 100;
    sgdFornecedores.ColWidths[7]:= 100;
end;

procedure TForm_Fornecedores.PopulaGrid();
var Fornecedores_Atuais: Fornecedores_Cadastrados;
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
          Campo := 'Nome';
        End;
        2: Begin
          Campo := 'Endereco';
        End;
        3: Begin
          Campo := 'Telefone';
        End;
        4: Begin
          Campo := 'CNPJ';
        End;
      end;
    End;
    Termo:= Trim(edit_pesquisa.Text);

    SetLength(Fornecedores_Atuais,0);
    if(not(btn_az.Enabled)) Then
        Fornecedores_Atuais := Retorna_Fornecedores_Cadastrados(Campo,Termo,'AZ', cbx_mostrarExcluidos.Checked);
    if(not(btn_za.Enabled)) Then
        Fornecedores_Atuais := Retorna_Fornecedores_Cadastrados(Campo,Termo,'ZA', cbx_mostrarExcluidos.Checked);
    if(not(btn_12.Enabled)) Then
        Fornecedores_Atuais := Retorna_Fornecedores_Cadastrados(Campo,Termo,'12', cbx_mostrarExcluidos.Checked);
    if(not(btn_21.Enabled)) Then
        Fornecedores_Atuais := Retorna_Fornecedores_Cadastrados(Campo,Termo,'21', cbx_mostrarExcluidos.Checked);
        if(Length(Fornecedores_Atuais) >= 1)
          Then sgdFornecedores.RowCount := Length(Fornecedores_Atuais)+1
          Else Begin
            sgdFornecedores.RowCount := 2;
            sgdFornecedores.Cells[0,1]:= '';
            sgdFornecedores.Cells[1,1]:= '';
            sgdFornecedores.Cells[2,1]:= '';
            sgdFornecedores.Cells[3,1]:= '';
            sgdFornecedores.Cells[4,1]:= '';
            sgdFornecedores.Cells[5,1]:= '';
            sgdFornecedores.Cells[6,1]:= '';
            sgdFornecedores.Cells[7,1]:= '';
          End;
    lab_qtdDados.Caption:= InttoStr(Length(Fornecedores_Atuais))+' Fornecedores Cadastrados';
    for I := 0 to Length(Fornecedores_Atuais) - 1 do
      begin
        sgdFornecedores.Cells[0,I+1]:= IntToStr(Fornecedores_Atuais[I].Codigo);
        sgdFornecedores.Cells[1,I+1]:= Fornecedores_Atuais[I].NomeFantasia;
        sgdFornecedores.Cells[2,I+1]:= Fornecedores_Atuais[I].RazaoSocial;
        sgdFornecedores.Cells[3,I+1]:= Fornecedores_Atuais[I].InscricaoEstadual;
        sgdFornecedores.Cells[4,I+1]:= Fornecedores_Atuais[I].CNPJ;
        sgdFornecedores.Cells[5,I+1]:= Fornecedores_Atuais[I].Endereco;
        sgdFornecedores.Cells[6,I+1]:= Fornecedores_Atuais[I].Telefone;
        sgdFornecedores.Cells[7,I+1]:= Fornecedores_Atuais[I].Email;

      end;
end;

procedure TForm_Fornecedores.sgdFornecedoresClick(Sender: TObject);
begin
    if(sgdFornecedores.Cells[0,Linha] <> '')
      Then Begin
        Preenche_Componentes;
      End
      Else ShowMessage('É necessario selecionar um registro valido');
end;

procedure TForm_Fornecedores.sgdFornecedoresSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
    Linha := ARow;
end;

procedure TForm_Fornecedores.Preenche_Componentes;
var Temp: Dados_Fornecedor;
begin
    Temp:= Retorna_Dados_Fornecedor(strtoint(sgdFornecedores.Cells[0,Linha]));
    edit_cod.text:= inttostr(Temp.Codigo);
    edit_NomeFantasia.text:= Temp.NomeFantasia;
    edit_RazaoSocial.text:= Temp.RazaoSocial;
    edit_InscricaoEstadual.text:= Temp.InscricaoEstadual;
    edit_CNPJ.text:= Temp.CNPJ;
    edit_Endereco.text:= Temp.Endereco;
    edit_Telefone.text:= Temp.Telefone;
    edit_Email.text:= Temp.Email;

    PageControl1.ActivePageIndex:= 1;
    HabilitaTela(True);
    HabilitaBotoes('01110');
    Novo:= False;
end;

procedure TForm_Fornecedores.LimpaTela;
begin
    edit_cod.Clear;
    edit_nomeFantasia.Clear;
    edit_RazaoSocial.Clear;
    edit_InscricaoEstadual.Clear;
    edit_cnpj.Clear;
    edit_endereco.Clear;
    edit_telefone.Clear;
    edit_Email.Clear;
end;

function TForm_Fornecedores.Validado: Boolean;
Var Temp_CNPJ : String;
begin
    if(trim(edit_nomeFantasia.text) = '')
      Then Begin
         Application.MessageBox('O Campo de nome fantasia é obrigatorio',
                                'Informe o nome fantasia',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex := 1;
         edit_nomeFantasia.SetFocus;
         Exit;
      End;

    if(trim(edit_RazaoSocial.text) = '')
      Then Begin
         Application.MessageBox('O Campo de razão social é obrigatorio',
                                'Informe a razão social',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex := 1;
         edit_RazaoSocial.SetFocus;
         Exit;
      End;

    if(trim(edit_InscricaoEstadual.text) = '')
      Then Begin
         Application.MessageBox('O Campo de inscrição estadual é obrigatorio',
                                'Informe a inscrição estadual',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex := 1;
         edit_InscricaoEstadual.SetFocus;
         Exit;
      End;

    if(AnsiPos(' ', edit_cnpj.text) <> 0)
      Then Begin
         Application.MessageBox('O Campo de cnpj é obrigatorio',
                                'Informe o CNPJ',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex:= 1;
         edit_cnpj.SetFocus;
         Exit;
      End;
    Temp_CNPJ:= edit_cnpj.Text;
    Temp_CNPJ := AnsiReplaceStr(Temp_CNPJ,'.','');
    Temp_CNPJ := AnsiReplaceStr(Temp_CNPJ,'-','');
    Temp_CNPJ := AnsiReplaceStr(Temp_CNPJ,'/','');
    if not (isCNPJ(Temp_CNPJ))
      then begin
         Application.MessageBox('O Campo de CNPJ é invalido',
                                'Informe um CNPJ valido',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex:= 1;
         edit_cnpj.SetFocus;
         Exit;
      end;

     if(trim(edit_endereco.text) = '')
      Then Begin
         Application.MessageBox('O Campo de endereço é obrigatorio',
                                'Informe o endereço',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex := 1;
         edit_endereco.SetFocus;
         Exit;
      End;

    if(AnsiPos(' ', edit_telefone.text) <> 0)
      Then Begin
         Application.MessageBox('O Campo de telefone é obrigatorio',
                                'Informe o Telefone',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex:= 1;
         edit_telefone.SetFocus;
         Exit;
      End;

     if(trim(edit_email.text) = '')
      Then Begin
         Application.MessageBox('O Campo de email é obrigatorio',
                                'Informe o email',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex := 1;
         edit_email.SetFocus;
         Exit;
      End;

    result:= true;
end;

function TForm_Fornecedores.Coleta_Dados: Dados_Fornecedor;
var Temp: Dados_Fornecedor;
begin
    Temp.Codigo:=strtoint(edit_cod.text);
    Temp.NomeFantasia:=edit_NomeFantasia.text;
    Temp.RazaoSocial:=edit_RazaoSocial.text;
    Temp.InscricaoEstadual:=edit_InscricaoEstadual.text;
    Temp.CNPJ:=edit_CNPJ.text;
    Temp.Endereco:=edit_endereco.text;
    Temp.Telefone:=edit_Telefone.text;
    Temp.Email:=edit_Email.text;
    result := Temp;
end;

procedure TForm_Fornecedores.EditarCadastro1Click(Sender: TObject);
begin
  if(sgdFornecedores.Cells[0,Linha] <> '')
    Then Begin
      Preenche_Componentes;
    End
    Else ShowMessage('É necessario selecionar um registro valido');
end;

procedure TForm_Fornecedores.edit_pesquisaChange(Sender: TObject);
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

procedure TForm_Fornecedores.ExcluirCadastro1Click(Sender: TObject);
begin
    if (isNumero(sgdFornecedores.Cells[0,Linha]))
      Then Begin
       if(sgdFornecedores.Cells[0,Linha] <> '')
          Then Begin
            if(Application.MessageBox('Deseja realmente excluir o fornecedor?', 'Excluir Fornecedor', MB_ICONQUESTION+MB_YESNO) = mrYes)
              then begin
                ApagaFornecedor(strtoint(sgdFornecedores.Cells[0,Linha]));
                PopulaGrid;
              end;
          End
        Else ShowMessage('É necessario selecionar um registro valido');
      End;
end;

end.
