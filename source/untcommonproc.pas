{ +--------------------------------------------------------------------------+ }
{ | MM5DRead v0.3 * Status reader program for MM5D device                    | }
{ | Copyright (C) 2020-2023 Pozsár Zsolt <pozsar.zsolt@szerafingomba.hu>     | }
{ | untcommonproc.pas                                                        | }
{ | Common functions and procedures                                          | }
{ +--------------------------------------------------------------------------+ }

//   This program is free software: you can redistribute it and/or modify it
// under the terms of the European Union Public License 1.1 version.

//   This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.

unit untcommonproc;

{$MODE OBJFPC}{$H-}
interface

uses
  Classes, Dialogs, INIFiles, SysUtils, {$IFDEF WIN32}Windows,{$ENDIF} httpsend;

var
  value0, value1, value2, value3, value4: TStringList;
  exepath: shortstring;
  lang: string[2];
  uids: string;
  urls: array[0..63] of string;
  userdir: string;
{$IFDEF WIN32}
const
  CSIDL_PROFILE = 40;
  SHGFP_TYPE_CURRENT = 0;
{$ENDIF}

{$I config.pas}

function getdatafromdevice(url, uid: string): byte;
function getexepath: string;
function getlang: string;
function loadconfiguration(filename: string): boolean;
function saveconfiguration(filename: string): boolean;
procedure makeuserdir;

{$IFDEF WIN32}
function SHGetFolderPath(hwndOwner: HWND; nFolder: integer; hToken: THandle;
  dwFlags: DWORD; pszPath: LPTSTR): HRESULT; stdcall;
  external 'Shell32.dll' Name 'SHGetFolderPathA';
{$ENDIF}

implementation

// get data from controller device via http
function getdatafromdevice(url, uid: string): byte;
const
  s1 = '/cgi-bin/getdata.cgi?uid=';
  s2 = '&value=';
begin
  Result := 0;
  value0.Clear;
  value1.Clear;
  value2.Clear;
  value3.Clear;
  value4.Clear;
  url := url + s1 + uid + s2;
  with THTTPSend.Create do
  begin
    if not HttpGetText(url + '0', value0) then
      Result := 1;
    if not HttpGetText(url + '1', value1) then
      Result := 1;
    if not HttpGetText(url + '2', value2) then
      Result := 1;
    if not HttpGetText(url + '3', value3) then
      Result := 1;
    if not HttpGetText(url + '4', value4) then
      Result := 1;
    Free;
  end;
end;

// get executable path
function getexepath: string;
var
  p: shortstring;
begin
  exepath := ExtractFilePath(ParamStr(0));
  Result := exepath;
end;

// get system language
function getlang: string;
var
{$IFDEF WIN32}
  buffer: PChar;
  size: integer;
{$ENDIF}
  s: string;
begin
 {$IFDEF UNIX}
  s := getenvironmentvariable('LANG');
 {$ENDIF}
 {$IFDEF WIN32}
  size := getlocaleinfo(LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, nil, 0);
  getmem(buffer, size);
  try
    getlocaleinfo(LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, buffer, size);
    s := string(buffer);
  finally
    freemem(buffer);
  end;
 {$ENDIF}
  if length(s) = 0 then
    s := 'en';
  lang := lowercase(s[1..2]);
  Result := lang;
end;

// load configuration
function loadconfiguration(filename: string): boolean;
var
  b: byte;
  iif: TINIFile;
begin
  iif := TIniFile.Create(filename);
  Result := True;
  try
    uids := iif.ReadString('uids', '1', '');
    for b := 0 to 63 do
      urls[b] := iif.ReadString('urls', IntToStr(b + 1), '');
  except
    Result := False;
  end;
  iif.Free;
end;

// save configuration
function saveconfiguration(filename: string): boolean;
var
  b: byte;
  iif: TINIFile;
begin
  iif := TIniFile.Create(filename);
  Result := True;
  try
    iif.WriteString('uids', '1', uids);
    for b := 0 to 63 do
      iif.WriteString('urls', IntToStr(b + 1), urls[b]);
  except
    Result := False;
  end;
  iif.Free;
end;

// make user's directory
procedure makeuserdir;
{$IFDEF WIN32}
var
  buffer: array[0..MAX_PATH] of char;

  function getuserprofile: string;
  begin
    fillchar(buffer, sizeof(buffer), 0);
    ShGetFolderPath(0, CSIDL_PROFILE, 0, SHGFP_TYPE_CURRENT, buffer);
    Result := string(PChar(@buffer));
  end;
{$ENDIF}

begin
 {$IFDEF UNIX}
  userdir := getenvironmentvariable('HOME');
 {$ENDIF}
 {$IFDEF WIN32}
  userdir := getuserprofile;
 {$ENDIF}
  forcedirectories(userdir + DIR_CONFIG);
end;

end.
