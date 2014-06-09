//This file is a part of ANNSI-Project
//
//(c)2007/2008 by MAD-Crew
//Marcel S.,Alex L. D., Dimitri M.

unit MathUtils;

interface

type

  CMatrix2DField = record
      m11: Single;
      m12: Single;
      m13: Single;
      m21: Single;
      m22: Single;
      m23: Single;
      m31: Single;
      m32: Single;
      m33: Single;
  end;

  CMatrix2D = class
  private
    

  public
    m_members : CMatrix2DField;

    constructor Create;

    procedure translate(x:Single; y:Single);
    procedure scale(x:Single; y:Single);
    procedure rotate(angle:Single);
    procedure setIdentity;

    procedure multMatrix(matrix:CMatrix2D);

  end;

  CVector2D = class
  private
      m_x : Single;
      m_y : Single;
      m_w : Single;

      procedure SetX(X:Single);
      procedure SetY(Y:Single);

  public
      constructor Create; overload;
      constructor Create(x:Single;y:Single); overload;
      constructor Create(vector2D:CVector2D);overload;

      function Add(vec:CVector2D):CVector2D;
      function Sub(vec:CVector2D):CVector2D;
      function Mult(vec:CVector2D):CVector2D;overload;
      function Mult(scal:Single):CVector2D;overload;
      function Divis(vec:CVector2D):Cvector2D;overload;
      function Divis(scal:Single):CVector2D;overload;

      procedure transform(matrix:CMatrix2D);

      property X : Single read m_x write SetX;
      property Y : Single read m_y write SetY;

  end;

implementation

constructor CVector2D.Create;
begin
  self.m_x:=0.0;
  self.m_y:=0.0;
  self.m_w:=1.0;
end;

constructor CVector2D.Create(x:Single;y:Single);
begin
  self.m_x:=x;
  self.m_y:=y;
end;

constructor CVector2D.Create(vector2D:CVector2D);
begin
   self.m_x:=vector2D.X;
   self.m_y:=vector2D.Y;
end;

function CVector2D.Add(vec:CVector2D):CVector2D;
begin

  result:=CVector2D.Create(self.m_x+vec.X,
                            self.m_y+vec.Y);
end;

function CVector2D.Sub(vec:CVector2D):CVector2D;
begin

  result:=CVector2D.Create(self.m_x-vec.X,
                            self.m_y-vec.Y);
end;

function CVector2D.Mult(vec:CVector2D):CVector2D;
begin

  result:=CVector2D.Create(self.m_x*vec.X,
                            self.m_y*vec.Y);
end;

function CVector2D.Mult(scal:Single):CVector2D;
begin

  result:=CVector2D.Create(self.m_x*scal,
                            self.m_y*scal);
end;

function CVector2D.Divis(vec:CVector2D):CVector2D;
begin

  result:=CVector2D.Create(self.m_x/vec.X,
                            self.m_y/vec.Y);
end;

function CVector2D.Divis(scal:Single):CVector2D;
begin

  result:=CVector2D.Create(self.m_x/scal,
                            self.m_y/scal);
end;


procedure CVector2D.SetX(X:Single);
begin
    self.m_x:=X;
end;

procedure CVector2D.SetY(Y:Single);
begin
    self.m_y:=Y;
end;

procedure CVector2D.transform(matrix:CMatrix2D);
begin
  self.m_x:= self.m_x*matrix.m_members.m11+self.m_y*matrix.m_members.m21+matrix.m_members.m31;
  self.m_y:= self.m_x*matrix.m_members.m12+self.m_y*matrix.m_members.m22+matrix.m_members.m32;

end;

constructor CMatrix2D.Create;
begin
   FillChar(self.m_members,sizeof(self.m_members),0);
end;

procedure CMatrix2D.translate(x:Single;y:Single);
begin
    self.m_members.m11:=1;
    self.m_members.m12:=0;
    self.m_members.m13:=0;

	  self.m_members.m21:=0;
    self.m_members.m22:=1;
    self.m_members.m23:=0;

	  self.m_members.m31:=x;
    self.m_members.m32:=y;
    self.m_members.m33:=1;

    //self.multMatrix(self);

end;

procedure CMatrix2D.scale(x:Single;y:Single);
begin
    self.m_members.m11:=x;
    self.m_members.m12:=0;
    self.m_members.m13:=0;

	  self.m_members.m21:=0;
    self.m_members.m22:=y;
    self.m_members.m23:=0;

	  self.m_members.m31:=x;
    self.m_members.m32:=y;
    self.m_members.m33:=1;

end;

procedure CMatrix2D.rotate(angle:Single);
var
    tempSin:Extended;
    tempCos:Extended;
begin

    tempSin:=sin(angle);
    tempCos:=cos(angle);

	  self.m_members.m11 := tempCos;
    self.m_members.m12 := tempSin;
    self.m_members.m13 := 0;

	  self.m_members.m21 := -tempSin;
    self.m_members.m22 := tempCos;
    self.m_members.m23 := 0;

	  self.m_members.m31 := 0;
    self.m_members.m32 := 0;
    self.m_members.m33 := 1;

    //self.multMatrix(self);

end;

procedure CMatrix2D.setIdentity;
begin
    self.m_members.m11:=1;
    self.m_members.m12:=0;
    self.m_members.m13:=0;

	  self.m_members.m21:=0;
    self.m_members.m22:=1;
    self.m_members.m23:=0;

	  self.m_members.m31:=0;
    self.m_members.m32:=0;
    self.m_members.m33:=1;

end;

procedure CMatrix2D.multMatrix(matrix:CMatrix2D);
var temp: CMatrix2DField;
begin

	temp.m11 := (self.m_members.m11 * matrix.m_members.m11) +
              (self.m_members.m12 * matrix.m_members.m21) +
              (self.m_members.m13 * matrix.m_members.m31);
	temp.m12 := (self.m_members.m11 * matrix.m_members.m12) +
              (self.m_members.m12 * matrix.m_members.m22) +
              (self.m_members.m13 * matrix.m_members.m32);
	temp.m13 := (self.m_members.m11 * matrix.m_members.m13) +
              (self.m_members.m12 * matrix.m_members.m23) +
              (self.m_members.m13 * matrix.m_members.m33);

	temp.m21 := (self.m_members.m21 * matrix.m_members.m11) +
              (self.m_members.m22 * matrix.m_members.m21) +
              (self.m_members.m23 * matrix.m_members.m31);
	temp.m22 := (self.m_members.m21 * matrix.m_members.m12) +
              (self.m_members.m22 * matrix.m_members.m22) +
              (self.m_members.m23 * matrix.m_members.m32);
	temp.m23 := (self.m_members.m21 * matrix.m_members.m13) +
              (self.m_members.m22 * matrix.m_members.m23) +
              (self.m_members.m23 * matrix.m_members.m33);

	temp.m31 := (self.m_members.m31 * matrix.m_members.m11) +
              (self.m_members.m32 * matrix.m_members.m21) +
              (self.m_members.m33 * matrix.m_members.m31);
	temp.m32 := (self.m_members.m31 * matrix.m_members.m12) +
              (self.m_members.m32 * matrix.m_members.m22) +
              (self.m_members.m33 * matrix.m_members.m32);
	temp.m33 := (self.m_members.m31 * matrix.m_members.m13) +
              (self.m_members.m32 * matrix.m_members.m23) +
              (self.m_members.m33 * matrix.m_members.m33);

  self.m_members:=temp;

end;

end.
