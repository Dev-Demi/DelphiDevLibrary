(*
 http://it-blackcat.blogspot.com/2020/06/change-image-resolution.html


*)
procedure ScaleJpeg2(jpg: TJPEGImage; const NewWidth, NewHeight: Integer;
  const StretchMode: Integer = HALFTONE);
var
  bmp: Vcl.Graphics.TBitmap;
  fScale: Double;
  PrevPt: TPoint;
begin
  fScale := Min(NewWidth / jpg.Width, NewHeight / jpg.Height);
  bmp := Vcl.Graphics.TBitmap.Create;
  try
    bmp.SetSize(Round(jpg.Width * fScale), Round(jpg.Height * fScale));
    GetBrushOrgEx(bmp.Canvas.Handle, PrevPt);
    SetStretchBltMode(bmp.Canvas.Handle, StretchMode);
    SetBrushOrgEx(bmp.Canvas.Handle, PrevPt.x, PrevPt.y, @PrevPt);
    StretchBlt(bmp.Canvas.Handle, 0, 0, bmp.Width, bmp.Height,
      jpg.Canvas.Handle, 0, 0, jpg.Width, jpg.Height, SRCCOPY);
    jpg.Assign(bmp);
  finally
    bmp.Free;
  end;
end;
