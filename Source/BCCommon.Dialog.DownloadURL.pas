unit BCCommon.Dialog.DownloadURL;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.ActnList, Vcl.StdCtrls,
  BCControl.ProgressBar, Vcl.ExtActns, BCCommon.Dialog.Base, BCControl.Panel,
  Vcl.Dialogs, sDialogs, sGauge, System.Actions, Vcl.ExtCtrls, sPanel, sSkinProvider;

type
  TDownloadURLDialog = class(TBCBaseDialog)
    ActionCancel: TAction;
    ActionList: TActionList;
    ActionOK: TAction;
    ButtonCancel: TButton;
    LabelInformation: TLabel;
    PanelProgress: TBCPanel;
    PanelTop: TBCPanel;
    ProgressBar: TBCProgressBar;
    SaveDialog: TsSaveDialog;
    procedure ActionCancelExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ActionOKExecute(Sender: TObject);
  private
    FCancel: Boolean;
    procedure OnURLDownloadProgress(Sender: TDownLoadURL; Progress, ProgressMax: Cardinal;
      StatusCode: TURLDownloadStatus; StatusText: string; var Cancel: Boolean);
    procedure SetInformationText(const AValue: string);
  public
    function Open(const ADefaultFileName: string; const ADownloadURL: string): string;
  end;

procedure CheckForUpdates(const AAppName: string; const AAboutVersion: string);

function DownloadURLDialog: TDownloadURLDialog;

implementation

{$R *.dfm}

uses
  Winapi.Windows, Winapi.WinInet, Winapi.ShellApi, System.StrUtils, BCCommon.Messages,
  BCCommon.Language.Strings, BCCommon.Consts;

var
  FDownloadURLDialog: TDownloadURLDialog;

function DownloadURLDialog: TDownloadURLDialog;
begin
  if not Assigned(FDownloadURLDialog) then
    Application.CreateForm(TDownloadURLDialog, FDownloadURLDialog);
  Result := FDownloadURLDialog;
end;

procedure TDownloadURLDialog.ActionCancelExecute(Sender: TObject);
begin
  FCancel := True;
  LabelInformation.Caption := LanguageDataModule.GetConstant('DownloadCancelling');
  Repaint;
  Application.ProcessMessages;
  Close;
end;

procedure TDownloadURLDialog.FormDestroy(Sender: TObject);
begin
  FDownloadURLDialog := nil;
end;

procedure TDownloadURLDialog.SetInformationText(const AValue: string);
begin
  LabelInformation.Caption := AValue;
  Invalidate;
  Application.ProcessMessages;
end;

function TDownloadURLDialog.Open(const ADefaultFileName: string; const ADownloadURL: string): string;
begin
  FCancel := False;
  Result := '';
  ButtonCancel.Action := ActionCancel;
  Application.ProcessMessages;
  SaveDialog.Filter := Trim(StringReplace(LanguageDataModule.GetFileTypes('Zip'), '|', #0, [rfReplaceAll])) + #0#0;
  SaveDialog.Title := LanguageDataModule.GetConstant('SaveAs');
  SaveDialog.FileName := ADefaultFileName;
  SaveDialog.DefaultExt := 'zip';
  if SaveDialog.Execute(Handle) then
  begin
    SetInformationText(ADownloadURL);
    Application.ProcessMessages;
    with TDownloadURL.Create(Self) do
    try
      URL := ADownloadURL;
      FileName := SaveDialog.Files[0];
      Result := FileName;
      OnDownloadProgress := OnURLDownloadProgress;
      ExecuteTarget(nil);
    finally
      Free;
    end;
  end
  else
    Close;
  SetInformationText(LanguageDataModule.GetConstant('DownloadDone'));
  ButtonCancel.Action := ActionOK;
end;

procedure TDownloadURLDialog.ActionOKExecute(Sender: TObject);
begin
  Close;
end;

procedure TDownloadURLDialog.OnURLDownloadProgress;
begin
  ProgressBar.Count := ProgressMax;
  ProgressBar.Progress := Progress;
  Invalidate;
  Cancel := FCancel;
  Application.ProcessMessages;
end;

function GetAppVersion(const Url:string):string;
const
  BuffSize = 64*1024;
  TitleTagBegin = '<p>';
  TitleTagEnd = '</p>';
var
  hInter: HINTERNET;
  UrlHandle: HINTERNET;
  BytesRead: Cardinal;
  Buffer: Pointer;
  i,f: Integer;
begin
  Result:='';
  hInter := InternetOpen('', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  if Assigned(hInter) then
  begin
    GetMem(Buffer,BuffSize);
    try
       UrlHandle := InternetOpenUrl(hInter, PChar(Url), nil, 0, INTERNET_FLAG_RELOAD,0);
       try
        if Assigned(UrlHandle) then
        begin
          InternetReadFile(UrlHandle, Buffer, BuffSize, BytesRead);
          if BytesRead > 0 then
          begin
            SetString(Result, PAnsiChar(Buffer), BytesRead);
            i := Pos(TitleTagBegin,Result);
            if i > 0 then
            begin
              f := PosEx(TitleTagEnd,Result,i+Length(TitleTagBegin));
              Result := Copy(Result,i+Length(TitleTagBegin),f-i-Length(TitleTagBegin));
            end;
          end;
        end;
       finally
         InternetCloseHandle(UrlHandle);
       end;
    finally
      FreeMem(Buffer);
    end;
    InternetCloseHandle(hInter);
  end
end;

procedure CheckForUpdates(const AAppName: string; const AAboutVersion: string);
var
  LAppName: string;
  LVersion: string;
  LFileName: string;
begin
  LAppName := AAppName;
  try
    try
      Screen.Cursor := crHourGlass;
      LVersion := GetAppVersion(Format('%s/newversioncheck.php?a=%s&v=%s', [BONECODE_URL, LowerCase(AAppName), AAboutVersion]));
    finally
      Screen.Cursor := crDefault;
    end;

    if (Trim(LVersion) <> '') and (LVersion <> AAboutVersion) then
    begin
      if AskYesOrNo(Format(LanguageDataModule.GetYesOrNoMessage('NewVersion'), [LVersion, AAppName, CHR_DOUBLE_ENTER])) then
      begin
        LAppName := LAppName + {$IFDEF WIN64}IntToStr(64){$ELSE}IntToStr(32){$ENDIF};
        LFileName := DownloadURLDialog.Open(Format('%s.zip', [LAppName]), Format('%s/downloads/%s.zip', [BONECODE_URL, LAppName]));
        ShellExecute(Application.Handle, PChar('explore'), nil, nil, PChar(ExtractFilePath(LFileName)), SW_SHOWNORMAL);
      end;
    end
    else
      ShowMessage(LanguageDataModule.GetMessage('LatestVersion'));
  except
    on E: Exception do
      ShowErrorMessage(E.Message);
  end;
end;

end.
