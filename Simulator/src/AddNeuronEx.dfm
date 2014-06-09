object addNeuronExtended: TaddNeuronExtended
  Left = 299
  Top = 177
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Einf'#252'gen Erweitert'
  ClientHeight = 287
  ClientWidth = 338
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 38
    Height = 13
    Caption = 'Anzahl: '
  end
  object Label2: TLabel
    Left = 176
    Top = 16
    Width = 74
    Height = 13
    Caption = 'Neuronen Typ: '
  end
  object Label3: TLabel
    Left = 176
    Top = 64
    Width = 102
    Height = 13
    Caption = 'Aktivierungsfunktion: '
  end
  object Label4: TLabel
    Left = 8
    Top = 112
    Width = 56
    Height = 13
    Caption = 'Aktivierung:'
  end
  object Label5: TLabel
    Left = 8
    Top = 64
    Width = 45
    Height = 13
    Caption = 'Eingabe: '
  end
  object Label6: TLabel
    Left = 176
    Top = 112
    Width = 63
    Height = 13
    Caption = 'Schwellwert: '
  end
  object Num: TEdit
    Left = 8
    Top = 32
    Width = 145
    Height = 21
    TabOrder = 0
    OnKeyPress = NumKeyPress
  end
  object neType: TComboBox
    Left = 176
    Top = 32
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 1
    Text = 'Input'
    Items.Strings = (
      'Input'
      'Middle'
      'Output')
  end
  object neActFunc: TComboBox
    Left = 176
    Top = 80
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 2
    Text = 'Identit'#228't'
    Items.Strings = (
      'Identit'#228't'
      'Bin'#228'r'
      'Linear'
      'Sinus'
      'Sigmoid'
      'Tanh')
  end
  object neActivation: TEdit
    Left = 8
    Top = 128
    Width = 145
    Height = 21
    TabOrder = 3
    OnKeyPress = neInputKeyPress
  end
  object neInput: TEdit
    Left = 8
    Top = 80
    Width = 145
    Height = 21
    TabOrder = 4
    OnKeyPress = neInputKeyPress
  end
  object neThreshold: TEdit
    Left = 176
    Top = 128
    Width = 145
    Height = 21
    TabOrder = 5
    OnKeyPress = neInputKeyPress
  end
  object btCreate: TButton
    Left = 80
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Erstellen'
    TabOrder = 6
    OnClick = btCreateClick
  end
  object btCancel: TButton
    Left = 168
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    TabOrder = 7
    OnClick = btCancelClick
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 168
    Width = 321
    Height = 65
    Caption = 'Anordnung:'
    TabOrder = 8
    object Label7: TLabel
      Left = 8
      Top = 24
      Width = 38
      Height = 16
      Caption = 'Breite:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object width: TEdit
      Left = 48
      Top = 24
      Width = 97
      Height = 21
      TabOrder = 0
      Text = '20'
    end
  end
end
