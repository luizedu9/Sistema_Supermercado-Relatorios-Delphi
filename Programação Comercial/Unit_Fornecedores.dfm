object Form_Fornecedores: TForm_Fornecedores
  Left = 0
  Top = 0
  Caption = 'Cadastro/Edi'#231#227'o de dados dos Fornecedores'
  ClientHeight = 471
  ClientWidth = 665
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 665
    Height = 471
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Fornecedores Cadastrados'
      object lab_qtdDados: TLabel
        Left = 0
        Top = 365
        Width = 657
        Height = 13
        Align = alBottom
        ExplicitWidth = 3
      end
      object sgdFornecedores: TStringGrid
        Left = 73
        Top = 0
        Width = 584
        Height = 365
        Align = alClient
        ColCount = 9
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        PopupMenu = PopupMenu1
        TabOrder = 0
        OnClick = sgdFornecedoresClick
        OnSelectCell = sgdFornecedoresSelectCell
        ColWidths = (
          64
          167
          125
          114
          102
          64
          64
          64
          64)
      end
      object Panel1: TPanel
        Left = 0
        Top = 378
        Width = 657
        Height = 65
        Align = alBottom
        BevelInner = bvLowered
        TabOrder = 1
        object Label1: TLabel
          Left = 24
          Top = 6
          Width = 69
          Height = 13
          Caption = 'Pesquisar por:'
        end
        object Label2: TLabel
          Left = 143
          Top = 6
          Width = 90
          Height = 13
          Caption = 'Termo de pesquisa'
        end
        object btn_Pesquisar: TBitBtn
          Left = 551
          Top = 24
          Width = 82
          Height = 25
          Caption = 'Pesquisa'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
            03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
            0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
            0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
            0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
            0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
            0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
            0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
            0333337F777FFFFF7F3333000000000003333377777777777333}
          NumGlyphs = 2
          TabOrder = 0
          OnClick = btn_PesquisarClick
        end
        object cb_campos: TComboBox
          Left = 24
          Top = 25
          Width = 113
          Height = 21
          Style = csDropDownList
          TabOrder = 1
          OnChange = cb_camposChange
          Items.Strings = (
            'Codigo'
            'Nome'
            'Endere'#231'o'
            'Telefone'
            'CNPJ')
        end
        object edit_pesquisa: TMaskEdit
          Left = 143
          Top = 25
          Width = 386
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 2
          OnChange = edit_pesquisaChange
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 73
        Height = 365
        Align = alLeft
        ParentBackground = False
        TabOrder = 2
        object Label3: TLabel
          Left = 6
          Top = 48
          Width = 53
          Height = 13
          Caption = 'Ordena'#231#227'o'
        end
        object Btn_AZ: TBitBtn
          Left = 14
          Top = 125
          Width = 33
          Height = 25
          Caption = 'A..Z'
          TabOrder = 0
          OnClick = Btn_AZClick
        end
        object Btn_ZA: TBitBtn
          Left = 14
          Top = 156
          Width = 33
          Height = 25
          Caption = 'Z..A'
          TabOrder = 1
          OnClick = Btn_ZAClick
        end
        object Btn_12: TBitBtn
          Left = 14
          Top = 67
          Width = 33
          Height = 25
          Caption = '1..2'
          Enabled = False
          TabOrder = 2
          OnClick = Btn_12Click
        end
        object Btn_21: TBitBtn
          Left = 14
          Top = 98
          Width = 33
          Height = 25
          Caption = '2..1'
          TabOrder = 3
          OnClick = Btn_21Click
        end
        object cbx_mostrarExcluidos: TCheckBox
          Left = 6
          Top = 187
          Width = 67
          Height = 30
          Caption = 'Mostrar Excluidos'
          TabOrder = 4
          WordWrap = True
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Cadastro/Edi'#231#227'o de dados'
      ImageIndex = 1
      object label_cnpj: TLabel
        Left = 62
        Top = 127
        Width = 25
        Height = 13
        Caption = 'CNPJ'
        Enabled = False
      end
      object label_tel: TLabel
        Left = 360
        Top = 127
        Width = 42
        Height = 13
        Caption = 'Telefone'
        Enabled = False
      end
      object Panel2: TPanel
        Left = 0
        Top = 379
        Width = 657
        Height = 64
        Align = alBottom
        BevelInner = bvLowered
        TabOrder = 8
        object btn_sair: TBitBtn
          Left = 556
          Top = 16
          Width = 75
          Height = 25
          Caption = '&Sair'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
            03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
            0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
            0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
            0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
            0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
            0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
            0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
            0333337F777FFFFF7F3333000000000003333377777777777333}
          NumGlyphs = 2
          TabOrder = 1
          OnClick = btn_sairClick
        end
        object btn_gravar: TBitBtn
          Left = 422
          Top = 16
          Width = 75
          Height = 25
          Caption = '&Gravar'
          Enabled = False
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
            7700333333337777777733333333008088003333333377F73377333333330088
            88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
            000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
            FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
            99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
            99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
            99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
            93337FFFF7737777733300000033333333337777773333333333}
          NumGlyphs = 2
          TabOrder = 2
          OnClick = btn_gravarClick
        end
        object btn_cancelar: TBitBtn
          Left = 288
          Top = 16
          Width = 75
          Height = 25
          Caption = '&Cancelar'
          Enabled = False
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
            33333337777FF377FF3333993370739993333377FF373F377FF3399993000339
            993337777F777F3377F3393999707333993337F77737333337FF993399933333
            399377F3777FF333377F993339903333399377F33737FF33377F993333707333
            399377F333377FF3377F993333101933399377F333777FFF377F993333000993
            399377FF3377737FF7733993330009993933373FF3777377F7F3399933000399
            99333773FF777F777733339993707339933333773FF7FFF77333333999999999
            3333333777333777333333333999993333333333377777333333}
          NumGlyphs = 2
          TabOrder = 3
          OnClick = btn_cancelarClick
        end
        object btn_limpar: TBitBtn
          Left = 154
          Top = 16
          Width = 75
          Height = 25
          Caption = '&Limpar'
          Enabled = False
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
            555557777F777555F55500000000555055557777777755F75555005500055055
            555577F5777F57555555005550055555555577FF577F5FF55555500550050055
            5555577FF77577FF555555005050110555555577F757777FF555555505099910
            555555FF75777777FF555005550999910555577F5F77777775F5500505509990
            3055577F75F77777575F55005055090B030555775755777575755555555550B0
            B03055555F555757575755550555550B0B335555755555757555555555555550
            BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
            50BB555555555555575F555555555555550B5555555555555575}
          NumGlyphs = 2
          TabOrder = 4
          OnClick = btn_limparClick
        end
        object btn_novo: TBitBtn
          Left = 21
          Top = 16
          Width = 75
          Height = 25
          Caption = '&Novo'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
            000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
            00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
            F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
            0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
            FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
            FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
            0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
            00333377737FFFFF773333303300000003333337337777777333}
          NumGlyphs = 2
          TabOrder = 0
          OnClick = btn_novoClick
        end
      end
      object edit_RazaoSocial: TLabeledEdit
        Left = 93
        Top = 70
        Width = 420
        Height = 21
        CharCase = ecUpperCase
        EditLabel.Width = 60
        EditLabel.Height = 13
        EditLabel.Caption = 'Raz'#227'o Social'
        Enabled = False
        LabelPosition = lpLeft
        TabOrder = 2
        TextHint = 'Digite aqui a Raz'#227'o Social'
      end
      object edit_nomeFantasia: TLabeledEdit
        Left = 93
        Top = 43
        Width = 420
        Height = 21
        CharCase = ecUpperCase
        EditLabel.Width = 71
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome Fantasia'
        Enabled = False
        LabelPosition = lpLeft
        TabOrder = 1
        TextHint = 'Digite aqui o Nome Fantasia'
      end
      object edit_endereco: TLabeledEdit
        Left = 93
        Top = 151
        Width = 420
        Height = 21
        CharCase = ecUpperCase
        EditLabel.Width = 45
        EditLabel.Height = 13
        EditLabel.Caption = 'Endere'#231'o'
        Enabled = False
        LabelPosition = lpLeft
        TabOrder = 6
        TextHint = 'Digite aqui o Endere'#231'o'
      end
      object edit_cnpj: TMaskEdit
        Left = 93
        Top = 124
        Width = 112
        Height = 21
        Enabled = False
        EditMask = '99.999.999/9999-99;1;_'
        MaxLength = 18
        TabOrder = 4
        Text = '  .   .   /    -  '
      end
      object edit_telefone: TMaskEdit
        Left = 408
        Top = 124
        Width = 105
        Height = 21
        Enabled = False
        EditMask = '(99)9999-9999'
        MaxLength = 13
        TabOrder = 5
        Text = '(  )    -    '
      end
      object edit_cod: TLabeledEdit
        Left = 93
        Top = 16
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        Enabled = False
        LabelPosition = lpLeft
        TabOrder = 0
      end
      object Edit_InscricaoEstadual: TLabeledEdit
        Left = 93
        Top = 97
        Width = 420
        Height = 21
        CharCase = ecUpperCase
        EditLabel.Width = 87
        EditLabel.Height = 13
        EditLabel.Caption = 'Inscri'#231#227'o Estadual'
        Enabled = False
        LabelPosition = lpLeft
        TabOrder = 3
        TextHint = 'Digite aqui a Inscri'#231#227'o Estadual'
      end
      object Edit_Email: TLabeledEdit
        Left = 93
        Top = 178
        Width = 420
        Height = 21
        CharCase = ecUpperCase
        EditLabel.Width = 24
        EditLabel.Height = 13
        EditLabel.Caption = 'Email'
        Enabled = False
        LabelPosition = lpLeft
        TabOrder = 7
        TextHint = 'Digite aqui o Email'
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 544
    Top = 176
    object EditarCadastro1: TMenuItem
      Caption = 'Editar Cadastro'
      OnClick = EditarCadastro1Click
    end
    object ExcluirCadastro1: TMenuItem
      Caption = 'Excluir Cadastro'
      OnClick = ExcluirCadastro1Click
    end
  end
end
