unit Utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, ExtDlgs;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonLoad: TButton;
    ButtonSave: TButton;
    ButtonWarna: TButton;
    ButtonInvers: TButton;
    ButtonGray: TButton;
    ButtonContrast: TButton;
    ButtonBrightness: TButton;
    ButtonBiner: TButton;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    G: TTrackBar;
    TrackBarcontrast: TTrackBar;
    TrackBarBiner: TTrackBar;
    TrackBarBrightness: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure ButtonBinerClick(Sender: TObject);
    procedure ButtonBrightnessClick(Sender: TObject);
    procedure ButtonContrastClick(Sender: TObject);
    procedure ButtonGrayClick(Sender: TObject);
    procedure ButtonInversClick(Sender: TObject);
    procedure ButtonLoadClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonWarnaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GChange(Sender: TObject);
    procedure TrackBarBinerChange(Sender: TObject);
    procedure TrackBarBrightnessChange(Sender: TObject);
    procedure TrackBarcontrastChange(Sender: TObject);



  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
uses
  windows;
var
  bitmapR,bitmapG,bitmapB : array [0..1000,0..1000] of byte;
  bitmapR1,bitmapG1,bitmapB1 : array [0..1000,0..1000] of byte;

procedure TForm1.ButtonLoadClick(Sender: TObject);
var
  x,y : integer;
begin
  if OpenPictureDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    for y := 0 to image1.Height-1 do
    begin
      for x := 0 to image1.Width-1 do
      begin
        bitmapR[x,y] := GetRValue(image1.Canvas.Pixels[x,y]);
        bitmapG[x,y] := GetGValue(image1.Canvas.Pixels[x,y]);
        bitmapB[x,y] := GetBValue(image1.Canvas.Pixels[x,y]);
      end;
    end;
  end;

  begin
    image2.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    for y := 0 to image2.Height-1 do
    begin
      for x := 0 to image2.Width-1 do
      begin
        bitmapR1[x,y] := GetRValue(image2.Canvas.Pixels[x,y]);
        bitmapG1[x,y] := GetGValue(image2.Canvas.Pixels[x,y]);
        bitmapB1[x,y] := GetBValue(image2.Canvas.Pixels[x,y]);
      end;
    end;
  end;

end;

procedure TForm1.ButtonSaveClick(Sender: TObject);
begin
  if SavePictureDialog1.Execute then
  begin
    image2.Picture.SaveToFile(SavePictureDialog1.FileName)
  end;
end;

procedure TForm1.ButtonWarnaClick(Sender: TObject);
var
  x,y : integer;

begin
  for y := 0 to image1.Height-1 do
  begin
    for x := 0 to image1.Width-1 do
    begin
      bitmapR[x,y] := bitmapR1[x,y];
      bitmapG[x,y] := bitmapG1[x,y];
      bitmapB[x,y] := bitmapB1[x,y];

      image1.Canvas.Pixels[x,y] := RGB(bitmapR[x,y],bitmapG[x,y],bitmapB[x,y]);
      image2.Canvas.Pixels[x,y] := RGB(bitmapR[x,y],bitmapG[x,y],bitmapB[x,y]);
    end;
end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.GChange(Sender: TObject);
begin
  label2.caption := Inttostr(G.Position);
end;

procedure TForm1.TrackBarBinerChange(Sender: TObject);
begin
  label1.caption := Inttostr(TrackBarBiner.Position);
end;

procedure TForm1.TrackBarBrightnessChange(Sender: TObject);
begin
  label4.Caption := Inttostr(TrackBarBrightness.Position);
end;

procedure TForm1.TrackBarcontrastChange(Sender: TObject);
begin
  label3.Caption := Inttostr(TrackbarContrast.Position);
end;


procedure TForm1.ButtonGrayClick(Sender: TObject);
var
  x,y : integer;
  gray : byte;
begin
  for y := 0 to image1.Height-1 do
  begin
    for x := 0 to image1.Width-1 do
    begin
      gray := (bitmapR[x,y]+bitmapG[x,y]+bitmapB[x,y]) div 3;
      bitmapR[x,y] := gray;
      bitmapG[x,y] := gray;
      bitmapB[x,y] := gray;

      image1.Canvas.Pixels[x,y] := RGB(gray,gray,gray);
      image2.Canvas.Pixels[x,y] := RGB(gray,gray,gray);
    end;
  end;
end;

procedure TForm1.ButtonBinerClick(Sender: TObject);
var
  x,y : integer;
  gray : byte;
begin
  for y := 0 to image2.Height-1 do
  begin
    for x := 0 to image2.Width-1 do
    begin
      gray := (bitmapR[x,y]+bitmapG[x,y]+bitmapB[x,y]) div 3;
      if gray <= TrackBarBiner.Position then
         image2.Canvas.Pixels[x,y] := RGB(0,0,0)
      else
        image2.Canvas.Pixels[x,y] := RGB(255,255,255)
    end;
  end;

end;


procedure TForm1.ButtonBrightnessClick(Sender: TObject);
var
  x,y : integer;
  brightnessR,brightnessG,brightnessB : integer;
begin
     for y := 0 to image1.Height-1 do
     begin
       for x := 0 to image1.Width-1 do
       begin
         brightnessR := bitmapR[x,y] + TrackbarBrightness.Position;
         if brightnessR < 0 then
            brightnessR := 0;
         if brightnessR > 255 then
            brightnessR := 255;

         brightnessG := bitmapG[x,y] + TrackbarBrightness.Position;
         if brightnessG < 0 then
            brightnessG := 0;
         if brightnessG > 255 then
            brightnessG := 255;

         brightnessB := bitmapB[x,y] + TrackbarBrightness.Position;
         if brightnessB < 0 then
            brightnessB := 0;
         if brightnessB > 255 then
            brightnessB := 255;

         image2.Canvas.Pixels[x,y] := RGB(brightnessR,brightnessG,brightnessB);
       end;
     end;
end;

procedure TForm1.ButtonContrastClick(Sender: TObject);
var
  x,y : integer;
  conR,conG,conB : integer;
begin
  for y := 0 to image1.Height-1 do
  begin
    for x := 0 to image1.Width-1 do
    begin
      conR := G .position * (bitmapR[x,y] - TrackBarcontrast.position) + TrackBarcontrast.position;
      if conR < 0 then
         conR := 0;
      if conR > 255 then
         conR := 255;

      conG := G.position * (bitmapG[x,y] - TrackBarcontrast.position) + TrackBarcontrast.position;
      if conG < 0 then
         conG := 0;
      if conG > 255 then
         conG := 255;

      conB := G.position * (bitmapB[x,y] - TrackBarcontrast.position) + TrackBarcontrast.position;
      if conB < 0 then
         conB := 0;
      if conB > 255 then
         conB := 255;

      image2.Canvas.Pixels[x,y] := RGB(conR,conG,conB);
    end;
  end;

end;

procedure TForm1.ButtonInversClick(Sender: TObject);
var
  x,y : integer;
  inversR,inversG,inversB : integer;
begin
  for y := 0 to image2.Height-1 do
  begin
    for x := 0 to image2.Width-1 do
    begin
      inversR := 255-bitmapR[x,y];
      inversG := 255-bitmapG[x,y];
      inversB := 255-bitmapB[x,y];

      image2.Canvas.Pixels[x,y] := RGB(inversR,inversG,inversB);
    end;
  end;

end;

end.
