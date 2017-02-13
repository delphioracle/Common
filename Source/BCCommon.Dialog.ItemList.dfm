inherited ItemListDialog: TItemListDialog
  Caption = 'ItemListDialog'
  ClientHeight = 416
  ClientWidth = 406
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PanelButtons: TBCPanel [0]
    AlignWithMargins = True
    Left = 3
    Top = 380
    Width = 397
    Height = 33
    Margins.Top = 0
    Margins.Right = 6
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'CHECKBOX'
    object ButtonFind: TButton
      AlignWithMargins = True
      Left = 239
      Top = 5
      Width = 75
      Height = 25
      Margins.Top = 5
      Align = alRight
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object ButtonCancel: TButton
      AlignWithMargins = True
      Left = 322
      Top = 5
      Width = 75
      Height = 25
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 0
      Align = alRight
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object PanelTop: TBCPanel [1]
    Left = 0
    Top = 0
    Width = 406
    Height = 62
    Align = alTop
    BevelOuter = bvNone
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    ParentColor = True
    TabOrder = 1
    SkinData.SkinSection = 'CHECKBOX'
    object SpeedButtonDivider1: TBCSpeedButton
      AlignWithMargins = True
      Left = 122
      Top = 6
      Width = 10
      Height = 50
      Margins.Left = 0
      Margins.Top = 4
      Margins.Right = 0
      Margins.Bottom = 4
      Align = alLeft
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      ButtonStyle = tbsDivider
      SkinData.SkinSection = 'SPEEDBUTTON'
      ImageIndex = 1
    end
    object SpeedButtonDelete: TBCSpeedButton
      Left = 62
      Top = 2
      Width = 60
      Height = 58
      Action = ActionDelete
      Align = alLeft
      AllowAllUp = True
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ButtonStyle = tbsCheck
      SkinData.SkinSection = 'TOOLBUTTON'
      Images = ImagesDataModule.ImageList
      ImageIndex = 22
    end
    object SpeedButtonInsert: TBCSpeedButton
      Left = 2
      Top = 2
      Width = 60
      Height = 58
      Action = ActionInsert
      Align = alLeft
      AllowAllUp = True
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ButtonStyle = tbsCheck
      SkinData.SkinSection = 'TOOLBUTTON'
      Images = ImagesDataModule.ImageList
      ImageIndex = 18
    end
    object SpeedButtonClear: TBCSpeedButton
      Left = 132
      Top = 2
      Width = 60
      Height = 58
      Action = ActionClearAll
      Align = alLeft
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ButtonStyle = tbsTextButton
      SkinData.SkinSection = 'TOOLBUTTON'
      Images = ImagesDataModule.ImageList
      ImageIndex = 65
    end
    object SpeedButtonDivider2: TBCSpeedButton
      AlignWithMargins = True
      Left = 192
      Top = 6
      Width = 10
      Height = 50
      Margins.Left = 0
      Margins.Top = 4
      Margins.Right = 0
      Margins.Bottom = 4
      Align = alLeft
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      ButtonStyle = tbsDivider
      SkinData.SkinSection = 'SPEEDBUTTON'
      ImageIndex = 1
    end
    object SpeedButtonMoveUp: TBCSpeedButton
      Left = 202
      Top = 2
      Width = 60
      Height = 58
      Action = ActionMoveUp
      Align = alLeft
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ButtonStyle = tbsTextButton
      SkinData.SkinSection = 'TOOLBUTTON'
      Images = ImagesDataModule.ImageList
      ImageIndex = 129
    end
    object SpeedButtonMoveDown: TBCSpeedButton
      Left = 262
      Top = 2
      Width = 60
      Height = 58
      Action = ActionMoveDown
      Align = alLeft
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ButtonStyle = tbsTextButton
      SkinData.SkinSection = 'TOOLBUTTON'
      Images = ImagesDataModule.ImageList
      ImageIndex = 130
    end
    object SpeedButtonSort: TBCSpeedButton
      Left = 322
      Top = 2
      Width = 60
      Height = 58
      Action = ActionSort
      Align = alLeft
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ButtonStyle = tbsTextButton
      SkinData.SkinSection = 'TOOLBUTTON'
      Images = ImagesDataModule.ImageList
      ImageIndex = 31
    end
  end
  object ListBox: TsListBox [2]
    AlignWithMargins = True
    Left = 6
    Top = 62
    Width = 394
    Height = 318
    Margins.Left = 6
    Margins.Top = 0
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alClient
    TabOrder = 2
    SkinData.SkinSection = 'EDIT'
  end
  object ActionList: TActionList
    Images = ImagesDataModule.ImageList
    Left = 190
    Top = 104
    object ActionInsert: TAction
      Caption = 'Insert'
      ImageIndex = 18
      OnExecute = ActionInsertExecute
    end
    object ActionDelete: TAction
      Caption = 'Delete'
      ImageIndex = 22
      OnExecute = ActionDeleteExecute
    end
    object ActionClearAll: TAction
      Caption = 'Clear all'
      ImageIndex = 65
      OnExecute = ActionClearAllExecute
    end
    object ActionMoveUp: TAction
      Caption = 'Move up'
      Hint = 'Move selected item up'
      ImageIndex = 129
      OnExecute = ActionMoveUpExecute
    end
    object ActionMoveDown: TAction
      Caption = 'Move down'
      Hint = 'Move selected item down'
      ImageIndex = 130
      OnExecute = ActionMoveDownExecute
    end
    object ActionSort: TAction
      Caption = 'Sort'
      ImageIndex = 31
      OnExecute = ActionSortExecute
    end
  end
end
