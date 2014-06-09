object OptionsMenu: TOptionsMenu
  Left = 544
  Top = 179
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Optionen'
  ClientHeight = 380
  ClientWidth = 229
  Color = clBtnFace
  DockSite = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 225
    Height = 329
    ActivePage = TabSheet1
    MultiLine = True
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Neuron'
      object Label1: TLabel
        Left = 2
        Top = 8
        Width = 116
        Height = 20
        Caption = ' Neuronenart: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 8
        Top = 120
        Width = 77
        Height = 20
        Caption = 'Eingabe: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 8
        Top = 176
        Width = 106
        Height = 20
        Caption = 'Schwellwert: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 8
        Top = 232
        Width = 100
        Height = 20
        Caption = 'Aktivierung: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 8
        Top = 64
        Width = 165
        Height = 20
        Caption = 'Aktivierungfunktion: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object NeuronTypes: TComboBox
        Left = 8
        Top = 32
        Width = 161
        Height = 19
        Hint = 'Neuronen Art'
        Style = csOwnerDrawFixed
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Items.Strings = (
          'Input'
          'Middle'
          'Output')
      end
      object Input: TEdit
        Left = 8
        Top = 144
        Width = 161
        Height = 21
        TabOrder = 1
        OnKeyPress = InputKeyPress
      end
      object Threshold: TEdit
        Left = 8
        Top = 200
        Width = 161
        Height = 21
        TabOrder = 2
      end
      object Activation: TEdit
        Left = 8
        Top = 256
        Width = 161
        Height = 21
        TabOrder = 3
      end
      object ActivFunc: TComboBox
        Left = 8
        Top = 88
        Width = 161
        Height = 22
        Style = csOwnerDrawFixed
        ItemHeight = 16
        TabOrder = 4
        Items.Strings = (
          'Identit'#228't'
          'Bin'#228'r'
          'Linear'
          'Sinus'
          'Sigmoid'
          'Tanh')
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Verbindung'
      ImageIndex = 1
      object Connections: TStringGrid
        Left = 8
        Top = 16
        Width = 193
        Height = 273
        ColCount = 2
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSizing, goColSizing, goEditing]
        ScrollBars = ssVertical
        TabOrder = 0
        OnSetEditText = ConnectionsSetEditText
        ColWidths = (
          95
          94)
      end
    end
  end
  object Button1: TButton
    Left = 24
    Top = 344
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 128
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    TabOrder = 1
    OnClick = Button2Click
  end
end
