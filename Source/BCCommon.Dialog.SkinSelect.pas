unit BCCommon.Dialog.SkinSelect;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCCommon.Dialog.Base, Vcl.StdCtrls, BCControl.Button,
  BCControl.Panel, sListBox, acSkinPreview, BCControl.Splitter, BCComponent.SkinManager, acSlider,
  Vcl.ComCtrls, sTrackBar, sLabel, sGroupBox, sButton, Vcl.ExtCtrls, sPanel, sSplitter, sSkinProvider;

type
  TSkinSelectDialog = class(TBCBaseDialog)
    ListBoxSkins: TsListBox;
    PanelButtons: TBCPanel;
    ButtonOK: TBCButton;
    ButtonCancel: TBCButton;
    PanelPreviewArea: TBCPanel;
    SplitterLeft: TBCSplitter;
    PanelSkinColorization: TBCPanel;
    SplitterRight: TBCSplitter;
    GroupBoxSkinColorization: TsGroupBox;
    LabelSaturationValue: TsLabel;
    LabelHueOffsetValue: TsLabel;
    LabelBrightnessValue: TsLabel;
    LabelHueOffsetMin: TsLabel;
    LabelHueOffsetMax: TsLabel;
    LabelSaturationMin: TsLabel;
    LabelSaturationMax: TsLabel;
    LabelHueOffset: TsLabel;
    LabelSaturation: TsLabel;
    LabelBrightnessMin: TsLabel;
    LabelBrightnessMax: TsLabel;
    LabelBrightness: TsLabel;
    TrackBarSaturation: TsTrackBar;
    TrackBarHueOffset: TsTrackBar;
    TrackBarBrightness: TsTrackBar;
    StickyLabelExtendedBordersMode: TsStickyLabel;
    SliderExtendedBordersMode: TsSlider;
    StickyLabelBlendOnMove: TsStickyLabel;
    SliderBlendOnMove: TsSlider;
    SliderAllowGlowing: TsSlider;
    StickyLabelAllowGlowing: TsStickyLabel;
    HTMLLabelAllSkinsDownload: TsHTMLLabel;
    SliderAllowAeroBlurring: TsSlider;
    StickyLabelAllowAeroBlurring: TsStickyLabel;
    StickyLabelAllowAnimation: TsStickyLabel;
    SliderAllowAnimation: TsSlider;
    SliderAllowOuterEffects: TsSlider;
    StickyLabelAllowOuterEffects: TsStickyLabel;
    procedure ListBoxSkinsClick(Sender: TObject);
    procedure TrackBarHueOffsetSkinPaint(Sender: TObject; Canvas: TCanvas);
    procedure TrackBarHueOffsetChange(Sender: TObject);
    procedure TrackBarSaturationChange(Sender: TObject);
    procedure TrackBarBrightnessChange(Sender: TObject);
    procedure SliderBlendOnMoveSliderChange(Sender: TObject);
    procedure SliderExtendedBordersModeSliderChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FPreviewForm: TFormSkinPreview;
    procedure DeleteCommercialSkins;
  public
    { Public declarations }
    class procedure ClassShowModal(ASkinManager: TBCSkinManager);
  end;

implementation

{$R *.dfm}

uses
  sGraphUtils, acntUtils, BCCommon.Language.Strings, BCCommon.Consts;

class procedure TSkinSelectDialog.ClassShowModal(ASkinManager: TBCSkinManager);
var
  LSkinSelectDialog: TSkinSelectDialog;
begin
  Application.CreateForm(TSkinSelectDialog, LSkinSelectDialog);

  with LSkinSelectDialog do
  try
    ASkinManager.GetExternalSkinNames(ListBoxSkins.Items);
    DeleteCommercialSkins;
    ListBoxSkins.ItemIndex := ListBoxSkins.Items.IndexOf(ASkinManager.SkinName);
    FPreviewForm := TFormSkinPreview.Create(nil); // Form will be freed automatically together with this frame
    try
      FPreviewForm.Align := alClient;
      FPreviewForm.Parent := PanelPreviewArea;
      FPreviewForm.Name := 'FormSkinPreview';
      FPreviewForm.PreviewManager.SkinDirectory := ASkinManager.SkinDirectory;
      FPreviewForm.PreviewManager.SkinName := ListBoxSkins.Items[ListBoxSkins.ItemIndex];
      FPreviewForm.Constraints.MinHeight := PanelPreviewArea.Height;
      FPreviewForm.Constraints.MinWidth := PanelPreviewArea.Width;
      TrackBarHueOffset.Position := ASkinManager.HueOffset;
      TrackBarSaturation.Position := ASkinManager.Saturation;
      TrackBarBrightness.Position := ASkinManager.Brightness;
      SliderBlendOnMove.SliderOn := ASkinManager.AnimEffects.BlendOnMoving.Active;
      SliderAllowAeroBlurring.SliderOn := ASkinManager.Effects.AllowAeroBluring;
      SliderAllowAnimation.SliderOn := ASkinManager.Effects.AllowAnimation;
      SliderAllowGlowing.SliderOn := ASkinManager.Effects.AllowGlowing;
      SliderAllowOuterEffects.SliderOn := ASkinManager.Effects.AllowOuterEffects;
      SliderExtendedBordersMode.SliderOn := ASkinManager.ExtendedBorders;
      FPreviewForm.PreviewManager.Active := True;
      FPreviewForm.Visible := True;
      if ShowModal = mrOk then
      begin
        ASkinManager.SkinName := ListBoxSkins.Items[ListBoxSkins.ItemIndex];
        ASkinManager.BeginUpdate;
        ASkinManager.HueOffset := TrackBarHueOffset.Position;
        ASkinManager.Saturation := TrackBarSaturation.Position;
        ASkinManager.Brightness := TrackBarBrightness.Position;
        ASkinManager.AnimEffects.BlendOnMoving.Active := SliderBlendOnMove.SliderOn;
        ASkinManager.ExtendedBorders := SliderExtendedBordersMode.SliderOn;
        ASkinManager.Effects.AllowAeroBluring := SliderAllowAeroBlurring.SliderOn;
        ASkinManager.Effects.AllowAnimation := SliderAllowAnimation.SliderOn;
        ASkinManager.Effects.AllowGlowing := SliderAllowGlowing.SliderOn;
        ASkinManager.Effects.AllowOuterEffects := SliderAllowOuterEffects.SliderOn;
        ASkinManager.EndUpdate(True, False);
      end;
    finally
      FPreviewForm.Free;
    end;
  finally
    Free;
    LSkinSelectDialog := nil;
  end;
end;

procedure TSkinSelectDialog.DeleteCommercialSkins;
var
  LIndex: Integer;
begin
  for LIndex := ListBoxSkins.Items.Count - 1 downto 0 do
  if (Pos('(CS)', ListBoxSkins.Items[LIndex]) <> 0) or (ListBoxSkins.Items[LIndex] = 'TV-c') then
  begin
    if Assigned(ListBoxSkins.Items.Objects[LIndex]) then
      ListBoxSkins.Items.Objects[LIndex].Free;
    ListBoxSkins.Items.Delete(LIndex);
  end;
end;

procedure TSkinSelectDialog.FormCreate(Sender: TObject);
begin
  inherited;
  HTMLLabelAllSkinsDownload.Caption := Format('<a href="%s">%s</a>', [SKINS_DOWNLOAD_URL,
    LanguageDataModule.GetConstant('AllSkinsDownload')]);
end;

procedure TSkinSelectDialog.FormDestroy(Sender: TObject);
var
  LIndex: Integer;
begin
  inherited;
  for LIndex := 0 to ListBoxSkins.Items.Count - 1 do
    if Assigned(ListBoxSkins.Items.Objects[LIndex]) then
      ListBoxSkins.Items.Objects[LIndex].Free;
end;

procedure TSkinSelectDialog.ListBoxSkinsClick(Sender: TObject);
begin
  inherited;
  FPreviewForm.PreviewManager.SkinName := ListBoxSkins.Items[ListBoxSkins.ItemIndex];
end;

procedure TSkinSelectDialog.SliderBlendOnMoveSliderChange(Sender: TObject);
begin
  inherited;
  FPreviewForm.PreviewManager.AnimEffects.BlendOnMoving.Active := SliderBlendOnMove.SliderOn;
end;

procedure TSkinSelectDialog.SliderExtendedBordersModeSliderChange(Sender: TObject);
begin
  inherited;
  FPreviewForm.PreviewManager.ExtendedBorders := SliderExtendedBordersMode.SliderOn;
end;

procedure TSkinSelectDialog.TrackBarHueOffsetChange(Sender: TObject);
begin
  inherited;
  if FPreviewForm.PreviewManager.HueOffset <> TrackBarHueOffset.Position then
  begin
    FPreviewForm.PreviewManager.BeginUpdate;
    LabelHueOffsetValue.Caption := IntToStr(TrackBarHueOffset.Position);
    FPreviewForm.PreviewManager.HueOffset := TrackBarHueOffset.Position;
    FPreviewForm.PreviewManager.EndUpdate(True, False);
  end;
end;

procedure TSkinSelectDialog.TrackBarHueOffsetSkinPaint(Sender: TObject; Canvas: TCanvas);
const
  LINEHEIGHT = 3;
var
  LRect: TRect;
  X: Integer;
  LHUEValue, LHUEStep: Real;
begin
  LRect := TrackBarHueOffset.ChannelRect;
  OffsetRect(LRect, 0, HeightOf(LRect) + 4);
  InflateRect(LRect, -WidthOf(TrackBarHueOffset.ThumbRect) div 2, 0);
  LRect.Bottom := LRect.Top + LINEHEIGHT;
  LHUEValue := 0;
  LHUEStep := 360 / WidthOf(LRect);
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Style := psSolid;
  for X := 0 to WidthOf(LRect) - 1 do
  begin
    Canvas.Pen.Color := ChangeHue(Round(LHUEValue), 5460991);
    Canvas.MoveTo(LRect.Left + X, LRect.Top);
    Canvas.LineTo(LRect.Left + X, LRect.Top + LINEHEIGHT);
    LHUEValue := LHUEValue + LHUEStep;
  end;
end;

procedure TSkinSelectDialog.TrackBarSaturationChange(Sender: TObject);
begin
  inherited;
  if FPreviewForm.PreviewManager.Saturation <> TrackBarSaturation.Position then
  begin
    FPreviewForm.PreviewManager.BeginUpdate;
    LabelSaturationValue.Caption := IntToStr(TrackBarSaturation.Position);
    FPreviewForm.PreviewManager.Saturation := TrackBarSaturation.Position;
    FPreviewForm.PreviewManager.EndUpdate(True, False);
  end;
end;

procedure TSkinSelectDialog.TrackBarBrightnessChange(Sender: TObject);
begin
  inherited;
  if FPreviewForm.PreviewManager.Brightness <> TrackBarBrightness.Position then
  begin
    FPreviewForm.PreviewManager.BeginUpdate;
    LabelBrightnessValue.Caption := IntToStr(TrackBarBrightness.Position);
    FPreviewForm.PreviewManager.Brightness := TrackBarBrightness.Position;
    FPreviewForm.PreviewManager.EndUpdate(True, False);
  end;
end;

end.
