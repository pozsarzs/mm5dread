{ +--------------------------------------------------------------------------+ }
{ | MM5DRead v0.1 * Status reader program for MM5D device                    | }
{ | Copyright (C) 2020 Pozsár Zsolt <pozsar.zsolt@szerafingomba.hu>          | }
{ | config.pas(.in)                                                          | }
{ | Setting for source code                                                  | }
{ +--------------------------------------------------------------------------+ }

//   This program is free software: you can redistribute it and/or modify it
// under the terms of the European Union Public License 1.1 version.
//
//   This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.

const
  APPNAME='MM5DRead';
  VERSION='0.1';
  // install path
  INSTPATH='/usr/';
  {$IFDEF UseFHS}
    MYI18PATH='/usr/share/locale/';
  {$ELSE}
    {$IFDEF UNIX}
      MYI18PATH='/languages/';
    {$ENDIF}
    {$IFDEF ANDROID}
      MYI18PATH='/languages/';
    {$ENDIF}
    {$IFDEF WIN32}
      MYI18PATH='\languages\';
    {$ENDIF}
  {$ENDIF}
  // user's folders
  {$IFDEF UNIX}
    DIR_CONFIG='/.config/mm5dread/';
  {$ENDIF}
  {$IFDEF ANDROID}
    DIR_CONFIG='/config/';
  {$ENDIF}
  {$IFDEF WIN32}
    DIR_CONFIG='\AppData\Local\mm5dread\';
  {$ENDIF}