unit Unit_Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.Grids, Vcl.ComCtrls, Unit_Persistencia, Unit_Util, StrUtils,
  Vcl.Menus;

type
  TForm_Clientes = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    sgdClientes: TStringGrid;
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
    edit_cod: TLabeledEdit;
    edit_nome: TLabeledEdit;
    edit_endereco: TLabeledEdit;
    lab_cpf: TLabel;
    edit_cpf: TMaskEdit;
    edit_tel: TMaskEdit;
    lab_tel: TLabel;
    rad_sexo: TRadioGroup;
    edit_datanascimento: TLabeledEdit;
    edit_estadocivil: TLabeledEdit;
    PopupMenu1: TPopupMenu;
    EditarCadastro1: TMenuItem;
    Panel3: TPanel;
    Btn_AZ: TBitBtn;
    Btn_ZA: TBitBtn;
    Btn_12: TBitBtn;
    Btn_21: TBitBtn;
    Label3: TLabel;
    ExcluirCadastro1: TMenuItem;
    cbx_mostrarExcluidos: TCheckBox;
    edit_email: TLabeledEdit;
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
    procedure sgdClientesSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgdClientesDblClick(Sender: TObject);
    procedure cb_camposChange(Sender: TObject);
    procedure edit_pesquisaChange(Sender: TObject);
    procedure btn_PesquisarClick(Sender: TObject);
    procedure ExcluirCadastro1Click(Sender: TObject);

    procedure HabilitaTela(Habilita: Boolean);
    procedure HabilitaBotoes(Quais: String);
    procedure Preenche_Componentes;
    procedure PopulaGrid;
    procedure PintaGrid;
    procedure LimpaTela;
    function Coleta_Dados: Dados_Cliente;
    function Validado: Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Clientes: TForm_Clientes;
  Linha: Integer;
  Novo: Boolean;

implementation

{$R *.dfm}

procedure TForm_Clientes.btn_sairClick(Sender: TObject);
begin
    Form_Clientes.Close;
end;

procedure TForm_Clientes.HabilitaBotoes(Quais: String);
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

procedure TForm_Clientes.HabilitaTela(Habilita: Boolean);
begin
    {edit_cod.Enabled:=      Habilita;}
    edit_nome.Enabled:=     Habilita;
    edit_endereco.Enabled:= Habilita;
    edit_cpf.Enabled :=      Habilita;
    lab_cpf.Enabled :=      Habilita;
    edit_tel.Enabled:=      Habilita;
    lab_tel.Enabled :=      Habilita;
    edit_email.Enabled:=    Habilita;
    rad_sexo.Enabled:=      Habilita;
    edit_estadocivil.Enabled:= Habilita;
    edit_datanascimento.Enabled:= Habilita;
end;

procedure TForm_Clientes.LimpaTela;
begin
    edit_cod.Clear;
    edit_nome.Clear;
    edit_endereco.Clear;
    edit_cpf.Clear;
    edit_tel.Clear;
    edit_email.Clear;
    rad_sexo.ItemIndex:= -1;
    edit_estadocivil.Clear;
    edit_datanascimento.Clear;
end;

procedure TForm_Clientes.Btn_12Click(Sender: TObject);
begin
    btn_az.Enabled := true;
    btn_za.Enabled := true;
    btn_12.Enabled := false;
    btn_21.Enabled := true;
    PopulaGrid;
end;

procedure TForm_Clientes.Btn_21Click(Sender: TObject);
begin
    btn_az.Enabled := true;
    btn_za.Enabled := true;
    btn_12.Enabled := true;
    btn_21.Enabled := false;
    PopulaGrid;
end;

procedure TForm_Clientes.Btn_AZClick(Sender: TObject);
begin
    btn_az.Enabled := false;
    btn_za.Enabled := true;
    btn_12.Enabled := true;
    btn_21.Enabled := true;
    PopulaGrid;
end;

procedure TForm_Clientes.btn_cancelarClick(Sender: TObject);
begin
    if(Application.MessageBox('Deseja realmente cancelar?', 'Cancelar', MB_ICONQUESTION+MB_YESNO) = mrYes)
      then begin
              LimpaTela;
              HabilitaBotoes('10001');
              HabilitaTela(False);
      end;
end;

procedure TForm_Clientes.btn_gravarClick(Sender: TObject);
begin
    if Validado
      then begin
      if Novo
        then Grava_Dados_Cliente(Coleta_Dados)
        else Atualiza_Dados_Cliente(Coleta_Dados);
          HabilitaTela(False);
          HabilitaBotoes('10001');
          LimpaTela;
          PopulaGrid;
      end;
end;

procedure TForm_Clientes.btn_limparClick(Sender: TObject);
begin
    if(Application.MessageBox('Deseja realmente limpar todos os campos?', 'Limpar Campos', MB_ICONQUESTION+MB_YESNO) = mrYes)
      then begin
              LimpaTela;
              edit_nome.SetFocus;
      end;
end;

procedure TForm_Clientes.btn_novoClick(Sender: TObject);
begin
    Novo := True;
    HabilitaTela(True);
    HabilitaBotoes('01110');
    edit_cod.Text := Retorna_Proximo_Codigo_Cliente;
end;

procedure TForm_Clientes.btn_PesquisarClick(Sender: TObject);
begin
    PopulaGrid;
end;

procedure TForm_Clientes.Btn_ZAClick(Sender: TObject);
begin
    btn_az.Enabled := true;
    btn_za.Enabled := false;
    btn_12.Enabled := true;
    btn_21.Enabled := true;
    PopulaGrid;
end;

procedure TForm_Clientes.cb_camposChange(Sender: TObject);
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

procedure TForm_Clientes.Preenche_Componentes;
var Temp: Dados_Cliente;
begin
    Temp:= Retorna_Dados_Cliente(strtoint(sgdClientes.Cells[0,Linha]));
    edit_cod.text:= inttostr(Temp.Codigo);
    edit_nome.text:= Temp.Nome;
    edit_endereco.text:= Temp.Endereco;
    edit_cpf.text:= Temp.CPF;
    edit_tel.text:= Temp.Telefone;
    edit_email.text:= Temp.Email;
    rad_sexo.ItemIndex:= Temp.Sexo;
    edit_EstadoCivil.text:= Temp.EstadoCivil;
    edit_datanascimento.text:= Temp.DataNascimento;

    PageControl1.ActivePageIndex:= 1;
    HabilitaTela(True);
    HabilitaBotoes('01110');
    Novo:= False;
end;

procedure TForm_Clientes.sgdClientesDblClick(Sender: TObject);
begin
    if(sgdClientes.Cells[0,Linha] <> '')
      Then Begin
        Preenche_Componentes;
      End
      Else ShowMessage('É necessario selecionar um registro valido');
end;

procedure TForm_Clientes.sgdClientesSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
    Linha:= ARow;
end;

function TForm_Clientes.Coleta_Dados: Dados_Cliente;
var Temp: Dados_Cliente;
begin
    Temp.Codigo:=strtoint(edit_cod.text);
    Temp.Endereco:=edit_endereco.text;
    Temp.Nome:=edit_nome.text;
    Temp.CPF:=edit_cpf.text;
    Temp.Telefone:=edit_tel.text;
    Temp.Email:=edit_Email.text;
    Temp.Sexo:=rad_sexo.ItemIndex;
    Temp.EstadoCivil:=edit_EstadoCivil.text;
    Temp.DataNascimento:=edit_DataNascimento.text;
    result := Temp;
end;

procedure TForm_Clientes.edit_pesquisaChange(Sender: TObject);
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

procedure TForm_Clientes.ExcluirCadastro1Click(Sender: TObject);
begin
    if (isNumero(sgdClientes.Cells[0,Linha]))
      Then Begin
        if(sgdClientes.Cells[0,Linha] <> '')
          Then Begin
              if(Application.MessageBox('Deseja realmente excluir o cliente?', 'Excluir Cliente', MB_ICONQUESTION+MB_YESNO) = mrYes)
                then begin
                  ApagaCliente(strtoint(sgdClientes.Cells[0,Linha]));
                  PopulaGrid;
                end
          End
          Else ShowMessage('É necessario selecionar um registro valido');
      End;
end;

procedure TForm_Clientes.FormShow(Sender: TObject);
begin
    PageControl1.ActivePageIndex:= 0;
    PintaGrid;
    PopulaGrid;
    linha:=1;
end;

procedure TForm_Clientes.PopulaGrid();
var Clientes_Atuais: Clientes_Cadastrados;
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
          Campo := 'CPF';
        End;
      end;
    End;
    Termo:= Trim(edit_pesquisa.Text);

    SetLength(Clientes_Atuais,0);
    if(not(btn_az.Enabled)) Then
        Clientes_Atuais := Retorna_Clientes_Cadastrados(Campo,Termo,'AZ', cbx_mostrarExcluidos.Checked);
    if(not(btn_za.Enabled)) Then
        Clientes_Atuais := Retorna_Clientes_Cadastrados(Campo,Termo,'ZA', cbx_mostrarExcluidos.Checked);
    if(not(btn_12.Enabled)) Then
        Clientes_Atuais := Retorna_Clientes_Cadastrados(Campo,Termo,'12', cbx_mostrarExcluidos.Checked);
    if(not(btn_21.Enabled)) Then
        Clientes_Atuais := Retorna_Clientes_Cadastrados(Campo,Termo,'21', cbx_mostrarExcluidos.Checked);
        if(Length(Clientes_Atuais) >= 1)
          Then sgdClientes.RowCount := Length(Clientes_Atuais)+1
          Else Begin
            sgdClientes.RowCount := 2;
            sgdClientes.Cells[0,1]:= '';
            sgdClientes.Cells[1,1]:= '';
            sgdClientes.Cells[2,1]:= '';
            sgdClientes.Cells[3,1]:= '';
            sgdClientes.Cells[4,1]:= '';
            sgdClientes.Cells[5,1]:= '';
            sgdClientes.Cells[6,1]:= '';
            sgdClientes.Cells[7,1]:= '';
            sgdClientes.Cells[8,1]:= '';
          End;
    lab_qtdDados.Caption:= InttoStr(Length(Clientes_Atuais))+' Clientes Cadastrados';
    for I := 0 to Length(Clientes_Atuais) - 1 do
      begin
        sgdClientes.Cells[0,I+1]:= IntToStr(Clientes_Atuais[I].Codigo);
        sgdClientes.Cells[1,I+1]:= Clientes_Atuais[I].Nome;
        sgdClientes.Cells[2,I+1]:= Clientes_Atuais[I].Endereco;
        sgdClientes.Cells[3,I+1]:= Clientes_Atuais[I].CPF;
        sgdClientes.Cells[4,I+1]:= Clientes_Atuais[I].Telefone;
        sgdClientes.Cells[5,I+1]:= Clientes_Atuais[I].Email;
        case Clientes_Atuais[I].Sexo of
          0: sgdClientes.Cells[6,I+1]:= 'Masc';
          1: sgdClientes.Cells[6,I+1]:= 'Femi';
          2: sgdClientes.Cells[6,I+1]:= 'Indef';
        end;
        sgdClientes.Cells[7,I+1]:= Clientes_Atuais[I].EstadoCivil;
        sgdClientes.Cells[8,I+1]:= Clientes_Atuais[I].DataNascimento;
      end;
end;

procedure TForm_Clientes.PintaGrid;
begin
    sgdClientes.Cells[0,0]:= 'Cód.';
    sgdClientes.Cells[1,0]:= 'Nome';
    sgdClientes.Cells[2,0]:= 'Endereco';
    sgdClientes.Cells[3,0]:= 'CPF';
    sgdClientes.Cells[4,0]:= 'Telefone';
    sgdClientes.Cells[5,0]:= 'Email';
    sgdClientes.Cells[6,0]:= 'Sexo';
    sgdClientes.Cells[7,0]:= 'Estado Civil';
    sgdClientes.Cells[8,0]:= 'Data Nascimento';
    sgdClientes.ColWidths[0]:= 60;
    sgdClientes.ColWidths[1]:= 100;
    sgdClientes.ColWidths[2]:= 100;
    sgdClientes.ColWidths[3]:= 80;
    sgdClientes.ColWidths[4]:= 80;
    sgdClientes.ColWidths[5]:= 80;
    sgdClientes.ColWidths[6]:= 100;
    sgdClientes.ColWidths[7]:= 100;
    sgdClientes.ColWidths[8]:= 80;
end;

function TForm_Clientes.Validado: Boolean;
Var Temp_CPF : String;
begin
    if(trim(edit_nome.text) = '')
      Then Begin
         Application.MessageBox('O Campo de nome é obrigatorio',
                                'Informe o nome',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex := 1;
         edit_nome.SetFocus;
         Exit;
      End;
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
    if(AnsiPos(' ', edit_cpf.text) <> 0)
      Then Begin
         Application.MessageBox('O Campo de cpf é obrigatorio',
                                'Informe o CPF',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex:= 1;
         edit_cpf.SetFocus;
         Exit;
      End;
    Temp_CPF:= edit_cpf.Text;
    Temp_CPF := AnsiReplaceStr(Temp_CPF,'.','');
    Temp_CPF := AnsiReplaceStr(Temp_CPF,'-','');
    if not (isCPF(Temp_CPF))
      then begin
         Application.MessageBox('O Campo de CPF é invalido',
                                'Informe um CPF valido',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex:= 1;
         edit_cpf.SetFocus;
         Exit;
      end;
    if(AnsiPos(' ', edit_tel.text) <> 0)
      Then Begin
         Application.MessageBox('O Campo de telefone é obrigatorio',
                                'Informe o Telefone',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex:= 1;
         edit_tel.SetFocus;
         Exit;
      End;
    if(AnsiPos(' ', edit_email.text) <> 0)
      Then Begin
         Application.MessageBox('O Campo de email é obrigatorio',
                                'Informe o email',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex:= 1;
         edit_email.SetFocus;
         Exit;
      End;
    if(rad_sexo.ItemIndex = -1)
      Then Begin
         Application.MessageBox('O Campo de sexo é obrigatorio',
                                'Informe o Sexo',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex := 1;
         Exit;
      End;
    if(AnsiPos(' ', edit_estadocivil.text) <> 0)
      Then Begin
         Application.MessageBox('O Campo de estado civil é obrigatorio',
                                'Informe o estado civil',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex:= 1;
         edit_estadocivil.SetFocus;
         Exit;
      End;
    if(AnsiPos(' ', edit_datanascimento.text) <> 0)
      Then Begin
         Application.MessageBox('O Campo de data de nascimento é obrigatorio',
                                'Informe a data de nascimento',
                                MB_ICONERROR+MB_OK);
         Result:= false;
         PageControl1.ActivePageIndex:= 1;
         edit_datanascimento.SetFocus;
         Exit;
      End;
    result:= true;
end;

end.
