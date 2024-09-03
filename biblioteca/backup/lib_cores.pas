unit lib_cores;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Graphics;

type

  { TLibCores }

  TLibCores = class
  private
    class function RGBToColor(Red, Green, Blue: byte): TColor;
  public
    class function Primary: TColor;
    class function Secondary: TColor;
    class function Success: TColor;
    class function Danger: TColor;
    class function Warning: TColor;
    class function Info: TColor;
    class function Light: TColor;
    class function Dark: TColor;
    class function Gelo: TColor;
    // PDV
    class function BackGround: TColor;
    class function BackMensagem: TColor;
    class function BackAcessoProduto : TColor;
  end;

implementation

{ TLibCores }

class function TLibCores.RGBToColor(Red, Green, Blue: byte): TColor;
begin
  Result := (Blue shl 16) or (Green shl 8) or Red;
end;

class function TLibCores.Primary: TColor;
begin
  Result := RGBToColor(0, 123, 255);
end;

class function TLibCores.Secondary: TColor;
begin
  Result := RGBToColor(108, 117, 125);
end;

class function TLibCores.Success: TColor;
begin
  Result := RGBToColor(40, 167, 69);
end;

class function TLibCores.Danger: TColor;
begin
  Result := RGBToColor(220, 53, 69);
end;

class function TLibCores.Warning: TColor;
begin
  Result := RGBToColor(255, 193, 7);
end;

class function TLibCores.Info: TColor;
begin
  Result := RGBToColor(23, 162, 184);
end;

class function TLibCores.Light: TColor;
begin
  Result := RGBToColor(248, 249, 250);
end;

class function TLibCores.Dark: TColor;
begin
  Result := RGBToColor(52, 58, 64);
end;

class function TLibCores.Gelo: TColor;
begin
  Result := RGBToColor(255, 255, 255);
end;

class function TLibCores.BackGround: TColor;
begin
  Result := RGBToColor(215, 227,244);
end;

class function TLibCores.BackMensagem: TColor;
begin
    Result := RGBToColor(80, 142,208);
end;

end.
