object Form_Entrada_Produtos: TForm_Entrada_Produtos
  Left = 0
  Top = 0
  Caption = 'Entrada de Produtos'
  ClientHeight = 519
  ClientWidth = 631
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox4: TGroupBox
    Left = 0
    Top = 342
    Width = 631
    Height = 134
    Align = alBottom
    Caption = 'Pagamento'
    TabOrder = 0
    object Label1: TLabel
      Left = 114
      Top = 23
      Width = 102
      Height = 13
      Caption = 'Forma de pagamento'
      Enabled = False
    end
    object lab_qtdParcelas: TLabel
      Left = 393
      Top = 23
      Width = 40
      Height = 13
      Caption = 'Parcelas'
      Enabled = False
    end
    object Edit_Total: TLabeledEdit
      Left = 18
      Top = 37
      Width = 66
      Height = 21
      EditLabel.Width = 72
      EditLabel.Height = 13
      EditLabel.Caption = 'Total da Venda'
      Enabled = False
      TabOrder = 0
      Text = '0,00'
    end
    object edit_Entrada: TLabeledEdit
      Left = 289
      Top = 39
      Width = 66
      Height = 21
      EditLabel.Width = 38
      EditLabel.Height = 13
      EditLabel.Caption = 'Entrada'
      Enabled = False
      TabOrder = 1
      Text = '0,00'
      OnChange = edit_EntradaChange
      OnExit = edit_EntradaExit
      OnKeyPress = edit_EntradaKeyPress
    end
    object spin_qtdParcelas: TSpinEdit
      Left = 393
      Top = 39
      Width = 43
      Height = 22
      Enabled = False
      MaxValue = 6
      MinValue = 2
      TabOrder = 2
      Value = 2
      OnChange = spin_qtdParcelasChange
    end
    object edit_valorParcelas: TLabeledEdit
      Left = 473
      Top = 39
      Width = 66
      Height = 21
      EditLabel.Width = 67
      EditLabel.Height = 13
      EditLabel.Caption = 'Valor Parcelas'
      Enabled = False
      TabOrder = 3
      Text = '0,00'
    end
    object Panel4: TPanel
      Left = 114
      Top = 32
      Width = 152
      Height = 27
      BevelOuter = bvNone
      TabOrder = 4
      object rad_formaPagamento: TRadioGroup
        Left = -8
        Top = -13
        Width = 177
        Height = 49
        BiDiMode = bdLeftToRight
        Columns = 2
        Enabled = False
        ItemIndex = 0
        Items.Strings = (
          #192' vista'
          #192' prazo')
        ParentBiDiMode = False
        TabOrder = 0
        OnClick = rad_formaPagamentoClick
      end
    end
    object edtImposto: TLabeledEdit
      Left = 17
      Top = 89
      Width = 66
      Height = 21
      EditLabel.Width = 39
      EditLabel.Height = 13
      EditLabel.Caption = 'Imposto'
      Enabled = False
      TabOrder = 5
      Text = '0,00'
      OnChange = edtImpostoChange
      OnExit = edtImpostoExit
      OnKeyPress = edtImpostoKeyPress
    end
    object edtFrete: TLabeledEdit
      Left = 106
      Top = 89
      Width = 63
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = 'Frete'
      Enabled = False
      TabOrder = 6
      Text = '0,00'
      OnChange = edtFreteChange
      OnExit = edtFreteExit
      OnKeyPress = edtFreteKeyPress
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 631
    Height = 81
    Align = alTop
    Caption = 'Dados Gerais da Venda'
    TabOrder = 1
    object Label2: TLabel
      Left = 18
      Top = 21
      Width = 55
      Height = 13
      Caption = 'Fornecedor'
      Enabled = False
    end
    object Label3: TLabel
      Left = 377
      Top = 21
      Width = 25
      Height = 13
      Caption = 'CNPJ'
      Enabled = False
    end
    object edtCodigoFornecedor: TLabeledEdit
      Left = 507
      Top = 40
      Width = 110
      Height = 21
      EditLabel.Width = 106
      EditLabel.Height = 13
      EditLabel.Caption = 'C'#243'digo do Fornecedor'
      TabOrder = 0
      Visible = False
    end
    object edit_CNPJ: TMaskEdit
      Left = 377
      Top = 40
      Width = 110
      Height = 21
      Enabled = False
      EditMask = '99.999.999/9999-99;1;_'
      MaxLength = 18
      TabOrder = 1
      Text = '  .   .   /    -  '
    end
    object cbx_Fornecedor: TComboBox
      Left = 18
      Top = 40
      Width = 337
      Height = 21
      AutoComplete = False
      Style = csDropDownList
      Enabled = False
      TabOrder = 2
      OnSelect = cbx_FornecedorSelect
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 81
    Width = 631
    Height = 261
    Align = alClient
    Caption = 'Produtos'
    TabOrder = 2
    object Panel3: TPanel
      Left = 2
      Top = 15
      Width = 627
      Height = 90
      Align = alTop
      TabOrder = 0
      object edit_CodProduto: TLabeledEdit
        Left = 16
        Top = 23
        Width = 65
        Height = 21
        EditLabel.Width = 64
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'd. Produto'
        Enabled = False
        NumbersOnly = True
        TabOrder = 0
        OnChange = edit_CodProdutoChange
      end
      object Edit_Descricao: TLabeledEdit
        Left = 87
        Top = 23
        Width = 306
        Height = 21
        TabStop = False
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Descri'#231#227'o'
        Enabled = False
        ReadOnly = True
        TabOrder = 1
      end
      object Edit_Preco: TLabeledEdit
        Left = 408
        Top = 23
        Width = 57
        Height = 21
        TabStop = False
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Pre'#231'o'
        Enabled = False
        TabOrder = 2
      end
      object Edit_Quantidade: TLabeledEdit
        Left = 471
        Top = 23
        Width = 66
        Height = 21
        EditLabel.Width = 56
        EditLabel.Height = 13
        EditLabel.Caption = 'Quantidade'
        Enabled = False
        NumbersOnly = True
        TabOrder = 3
      end
      object Btn_Inserir: TBitBtn
        Left = 166
        Top = 51
        Width = 107
        Height = 25
        Caption = 'Inserir Produto'
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333000003333333333F777773FF333333008877700
          33333337733FFF773F33330887000777033333733F777FFF73F3308800000007
          703337F37777777FF7F33080000000007033373777777777F73F087000222000
          77037F3777333777FF7F08000222220007037F777F3333777F7F0F0002222200
          07037F777F3333777F7F0F000822220008037F777FF33377737F0F7000882000
          780373F777FFF777F373308000000000803337F77777777737F330F800000008
          8033373F777777733733330F8700078803333373FF77733F733333300FFF8800
          3333333773FFFF77333333333000003333333333377777333333}
        NumGlyphs = 2
        TabOrder = 4
        OnClick = Btn_InserirClick
      end
      object Btn_Remover: TBitBtn
        Left = 294
        Top = 51
        Width = 115
        Height = 25
        Caption = 'Remover Produto'
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333000003333333333F777773FF333333008877700
          33333337733FFF773F33330887000777033333733F777FFF73F3308800000007
          703337F37777777FF7F33080000000007033373777777777F73F087000111000
          77037F3777333777FF7F08000111110007037F777F3333777F7F0F0001111100
          07037F777F3333777F7F0F000811110008037F777FF33377737F0F7000881000
          780373F777FFF777F373308000000000803337F77777777737F330F800000008
          8033373F777777733733330F8700078803333373FF77733F733333300FFF8800
          3333333773FFFF77333333333000003333333333377777333333}
        NumGlyphs = 2
        TabOrder = 5
        OnClick = Btn_RemoverClick
      end
    end
    object sgd_Produto: TStringGrid
      Left = 2
      Top = 105
      Width = 627
      Height = 154
      Align = alClient
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 476
    Width = 631
    Height = 43
    Align = alBottom
    TabOrder = 3
    object btn_novo: TBitBtn
      Left = 69
      Top = 6
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
    object btn_limpar: TBitBtn
      Left = 173
      Top = 6
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
      TabOrder = 1
      OnClick = btn_limparClick
    end
    object btn_cancelar: TBitBtn
      Left = 277
      Top = 6
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
      TabOrder = 2
      OnClick = btn_cancelarClick
    end
    object btn_gravar: TBitBtn
      Left = 381
      Top = 6
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
      TabOrder = 3
      OnClick = btn_gravarClick
    end
    object btn_sair: TBitBtn
      Left = 486
      Top = 6
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
      TabOrder = 4
      OnClick = btn_sairClick
    end
  end
end
