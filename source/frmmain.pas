{ +--------------------------------------------------------------------------+ }
{ | MM5DRead v0.3 * Status reader program for MM5D device                    | }
{ | Copyright (C) 2020-2023 Pozsár Zsolt <pozsar.zsolt@szerafingomba.hu>     | }
{ | frmmain.pas                                                              | }
{ | Main form                                                                | }
{ +--------------------------------------------------------------------------+ }

//   This program is free software: you can redistribute it and/or modify it
// under the terms of the European Union Public License 1.1 version.

//   This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.

unit frmmain;

{$mode objfpc}{$H+}
interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, untcommonproc;

type
  { TForm1 }
  TForm1 = class(TForm)
    Bevel1: TBevel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    Bevel13: TBevel;
    Bevel14: TBevel;
    Bevel15: TBevel;
    Bevel16: TBevel;
    Bevel17: TBevel;
    Bevel18: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Shape1: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    StatusBar1: TStatusBar;
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  inifile: string;

resourcestring
  MESSAGE01 = 'Cannot read configuration file!';
  MESSAGE02 = 'Cannot write configuration file!';
  MESSAGE03 = 'Cannot read data from this URL!';
  MESSAGE04 = 'Hyphae';
  MESSAGE05 = 'Mushroom';
  MESSAGE06 = 'The number of received data is wrong!';
  MESSAGE07 = 'Use v0.6 or higher software on the controller!';

implementation

{$R *.lfm}
{ TForm1 }

// read data from device
procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  format: TFormatSettings;
  errorcode: byte;
  ledoff, ledon: TColor;
  t, rh: single;
begin
  errorcode := getdatafromdevice(ComboBox1.Text, Edit1.Text);
  if errorcode = 0 then
    if (value0.Count < 2) or (value1.Count < 4) or (value2.Count < 12) or
      (value3.Count < 20) or (value4.Count < 4) then
      errorcode := 2
    else
      errorcode := 0;
  if errorcode = 0 then
  begin
    format.DecimalSeparator := '.';
    trystrtofloat(value3.Strings[2], t, format);
    trystrtofloat(value3.Strings[3], rh, format);
    // displays
    t := round(t);
    if (t >= 0) and (t < 100) then
      Label3.Caption := floattostr(t) + ' °C'
    else
      Label3.Caption := '0 °C';
    rh := round(rh);
    if (rh >= 0) and (rh < 101) then
      Label4.Caption := floattostr(rh) + ' %'
    else
      Label4.Caption := '0 %';
    // LEDs
    // - green
    ledoff := clGreen;
    ledon := clLime;
    if value3.Strings[5] = '1' then
      Shape3.Brush.Color := ledon
    else
      Shape3.Brush.Color := ledoff;
    if value3.Strings[6] = '1' then
      Shape4.Brush.Color := ledon
    else
      Shape4.Brush.Color := ledoff;
    if value3.Strings[7] = '1' then
      Shape5.Brush.Color := ledon
    else
      Shape5.Brush.Color := ledoff;
    if value3.Strings[8] = '1' then
      Shape6.Brush.Color := ledon
    else
      Shape6.Brush.Color := ledoff;
    if value3.Strings[17] = '1' then
      Shape17.Brush.Color := ledon
    else
      Shape17.Brush.Color := ledoff;
    // - red
    ledoff := clMaroon;
    ledon := clred;
    if value3.Strings[13] = '1' then
      Shape7.Brush.Color := ledon
    else
      Shape7.Brush.Color := ledoff;
    if value3.Strings[14] = '1' then
      Shape8.Brush.Color := ledon
    else
      Shape8.Brush.Color := ledoff;
    if value3.Strings[15] = '1' then
      Shape9.Brush.Color := ledon
    else
      Shape9.Brush.Color := ledoff;
    if value3.Strings[16] = '1' then
      Shape10.Brush.Color := ledon
    else
      Shape10.Brush.Color := ledoff;
    if value3.Strings[19] = '1' then
      Shape15.Brush.Color := ledon
    else
      Shape15.Brush.Color := ledoff;
    // - yellow
    ledoff := clOlive;
    ledon := clYellow;
    if value3.Strings[9] = '1' then
      Shape11.Brush.Color := ledon
    else
      Shape11.Brush.Color := ledoff;
    if value3.Strings[10] = '1' then
      Shape12.Brush.Color := ledon
    else
      Shape12.Brush.Color := ledoff;
    if value3.Strings[11] = '1' then
      Shape13.Brush.Color := ledon
    else
      Shape13.Brush.Color := ledoff;
    if value3.Strings[12] = '1' then
      Shape14.Brush.Color := ledon
    else
      Shape14.Brush.Color := ledoff;
    if value3.Strings[18] = '1' then
      Shape16.Brush.Color := ledon
    else
      Shape16.Brush.Color := ledoff;
    // - labels
    if value4.Strings[0] = 'off' then
      Label13.Font.Color := clRed;
    if value4.Strings[0] = 'on' then
      Label13.Font.Color := clGreen;
    if value4.Strings[0] = 'neutral' then
      Label13.Font.Color := clBlack;
    if value4.Strings[1] = 'off' then
      Label14.Font.Color := clRed;
    if value4.Strings[1] = 'on' then
      Label14.Font.Color := clGreen;
    if value4.Strings[1] = 'neutral' then
      Label14.Font.Color := clBlack;
    if value4.Strings[2] = 'off' then
      Label15.Font.Color := clRed;
    if value4.Strings[2] = 'on' then
      Label15.Font.Color := clGreen;
    if value4.Strings[2] = 'neutral' then
      Label15.Font.Color := clBlack;
    if value4.Strings[3] = 'off' then
      Label16.Font.Color := clRed;
    if value4.Strings[3] = 'on' then
      Label16.Font.Color := clGreen;
    if value4.Strings[3] = 'neutral' then
      Label16.Font.Color := clBlack;
    // status bar
    StatusBar1.Panels.Items[0].Text := value0.Strings[0] + ' ' + value0.Strings[1];
    StatusBar1.Panels.Items[1].Text := value3.Strings[0] + ' ' + value3.Strings[1];
    if value3.Strings[4] = 'H' then
      StatusBar1.Panels.Items[2].Text := MESSAGE04
    else
      StatusBar1.Panels.Items[2].Text := MESSAGE05;
    Form1.Caption := APPNAME + ' v' + VERSION + ' | ' + value1.Strings[3];
  end
  else
  begin
    // displays
    Label3.Caption := '0 °C';
    Label4.Caption := '0 %';
    // LEDs
    // - green
    ledoff := clGreen;
    Shape3.Brush.Color := ledoff;
    Shape4.Brush.Color := ledoff;
    Shape5.Brush.Color := ledoff;
    Shape6.Brush.Color := ledoff;
    Shape15.Brush.Color := ledoff;
    // - red
    ledoff := clMaroon;
    Shape7.Brush.Color := ledoff;
    Shape8.Brush.Color := ledoff;
    Shape9.Brush.Color := ledoff;
    Shape10.Brush.Color := ledoff;
    Shape16.Brush.Color := ledoff;
    // - yellow
    ledoff := clOlive;
    Shape11.Brush.Color := ledoff;
    Shape12.Brush.Color := ledoff;
    Shape13.Brush.Color := ledoff;
    Shape14.Brush.Color := ledoff;
    Shape17.Brush.Color := ledoff;
    // - labels
    Label13.Font.Color := clBlack;
    Label14.Font.Color := clBlack;
    Label15.Font.Color := clBlack;
    Label16.Font.Color := clBlack;
    // status bar
    StatusBar1.Panels.Items[0].Text := '';
    StatusBar1.Panels.Items[1].Text := '';
    StatusBar1.Panels.Items[2].Text := '';
    Form1.Caption := APPNAME + ' v' + VERSION;
    case errorcode of
      1: ShowMessage(MESSAGE03);
      2: ShowMessage(MESSAGE06 + #10 + MESSAGE07);
    end;
  end;
end;

// add URL to list
procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  line: byte;
  thereis: boolean;
begin
  thereis := False;
  if ComboBox1.Items.Count > 0 then
    for line := 0 to ComboBox1.Items.Count - 1 do
      if ComboBox1.Items.Strings[line] = ComboBox1.Text then
        thereis := True;
  if (not thereis) and (ComboBox1.Items.Count < 64) then
    ComboBox1.Items.AddText(ComboBox1.Text);
end;

// remove URL from list
procedure TForm1.SpeedButton3Click(Sender: TObject);
var
  line: byte;
begin
  if ComboBox1.Items.Count > 0 then
  begin
    for line := 0 to ComboBox1.Items.Count - 1 do
      if ComboBox1.Items.Strings[line] = ComboBox1.Text then
        break;
    ComboBox1.Items.Delete(line);
    ComboBox1Change(Sender);
  end;
end;

// event of ComboBox1
procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  if length(ComboBox1.Text) = 0 then
  begin
    SpeedButton1.Enabled := False;
    SpeedButton2.Enabled := False;
    SpeedButton3.Enabled := False;
  end
  else
  begin
    SpeedButton1.Enabled := True;
    SpeedButton2.Enabled := True;
    SpeedButton3.Enabled := True;
  end;
end;

// events of Form1
procedure TForm1.FormCreate(Sender: TObject);
var
  b: byte;
begin
  makeuserdir;
  getlang;
  getexepath;
  Form1.Caption := APPNAME + ' v' + VERSION;
  // load configuration
  inifile := untcommonproc.userdir + DIR_CONFIG + 'mm5dread.ini';
  if FileSearch('mm5dread.ini', untcommonproc.userdir + DIR_CONFIG) <> '' then
    if not loadconfiguration(inifile) then
      ShowMessage(MESSAGE01);
  Edit1.Text := untcommonproc.uids;
  for b := 0 to 63 do
    if length(urls[b]) > 0 then
      ComboBox1.Items.Add(untcommonproc.urls[b]);
  // set position of speedbuttons
  SpeedButton1.Top := ComboBox1.Top + ((ComboBox1.Height - SpeedButton1.Height) div 2);
  SpeedButton2.Top := SpeedButton1.Top;
  SpeedButton3.Top := SpeedButton1.Top;
  Edit1.Top := SpeedButton1.Top;
  untcommonproc.value0 := TStringList.Create;
  untcommonproc.value1 := TStringList.Create;
  untcommonproc.value2 := TStringList.Create;
  untcommonproc.value3 := TStringList.Create;
  untcommonproc.value4 := TStringList.Create;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  Bevel2.Width := (Form1.Width div 2) - 6;
  Bevel3.Width := Bevel2.Width;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  b: byte;
begin
  for b := 0 to 63 do
    untcommonproc.urls[b] := '';
  if ComboBox1.Items.Count > 0 then
    for b := 0 to ComboBox1.Items.Count - 1 do
      untcommonproc.urls[b] := ComboBox1.Items.Strings[b];
  untcommonproc.uids := Edit1.Text;
  if not saveconfiguration(inifile) then
    ShowMessage(MESSAGE02);
  untcommonproc.value0.Free;
  untcommonproc.value1.Free;
  untcommonproc.value2.Free;
  untcommonproc.value3.Free;
  untcommonproc.value4.Free;
end;

end.
