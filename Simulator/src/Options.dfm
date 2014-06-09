object settings: Tsettings
  Left = 565
  Top = 271
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Einstellungen'
  ClientHeight = 216
  ClientWidth = 329
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
    Top = 8
    Width = 158
    Height = 16
    Caption = 'Scroll Geschwindigkeit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 121
    Height = 16
    Caption = 'Hintergrundfarbe:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 64
    Width = 70
    Height = 16
    Caption = 'Gridfarbe:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object TrackBar1: TTrackBar
    Left = 176
    Top = 8
    Width = 150
    Height = 25
    Max = 20
    Frequency = 2
    Position = 15
    TabOrder = 0
    OnChange = TrackBar1Change
  end
  object Panel1: TPanel
    Left = 136
    Top = 40
    Width = 25
    Height = 17
    TabOrder = 1
    OnClick = Panel1Click
  end
  object Panel2: TPanel
    Left = 136
    Top = 64
    Width = 25
    Height = 17
    TabOrder = 2
    OnClick = Panel2Click
  end
  object Panel3: TPanel
    Left = 8
    Top = 88
    Width = 313
    Height = 89
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label4: TLabel
      Left = 8
      Top = 9
      Width = 112
      Height = 16
      Caption = 'Neuronenfarben'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 8
      Top = 32
      Width = 42
      Height = 13
      Caption = 'selektiert'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      OnClick = Label5Click
    end
    object Label6: TLabel
      Left = 200
      Top = 32
      Width = 23
      Height = 13
      Caption = 'input'
      OnClick = Label6Click
    end
    object Label7: TLabel
      Left = 264
      Top = 32
      Width = 30
      Height = 13
      Caption = 'output'
      OnClick = Label7Click
    end
    object Label8: TLabel
      Left = 104
      Top = 32
      Width = 30
      Height = 13
      Caption = 'middle'
      OnClick = Label8Click
    end
    object Label9: TLabel
      Left = 8
      Top = 56
      Width = 66
      Height = 13
      Caption = 'Verbindungen'
      OnClick = Label9Click
    end
    object Label10: TLabel
      Left = 104
      Top = 56
      Width = 82
      Height = 13
      Caption = 'Auswahlrechteck'
      OnClick = Label10Click
    end
    object Label11: TLabel
      Left = 200
      Top = 56
      Width = 54
      Height = 13
      Caption = 'Schriftfarbe'
      OnClick = Label11Click
    end
  end
  object Button1: TButton
    Left = 248
    Top = 184
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 4
    OnClick = Button1Click
  end
  object cld: TColorDialog
    Left = 232
    Top = 40
  end
end
