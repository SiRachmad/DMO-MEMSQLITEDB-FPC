unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  ZConnection, ZDataset;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    LConn: TZConnection;
    LQuery: TZQuery;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  LConn:= TZConnection.Create(Self);
  LQuery:= TZQuery.Create(Self);
  LQuery.Connection:= LConn;
  LConn.Protocol:= 'sqlite-3';
  LConn.LibraryLocation:= ExtractFilePath(ParamStr(0))+'sqlite-3.dll';
  LConn.Database:= ':memory:';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if not LConn.Connected then begin
    LConn.Connect;
    Button1.Caption:= 'Dissconnect DB';
  end else begin
    LConn.Disconnect;
    Button1.Caption:= 'Connect DB';
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if LQuery.Active then
    LQuery.Close;
  LQuery.SQL.Text:= Memo1.Lines.Text;
  LQuery.Open;
  DataSource1.DataSet:= LQuery;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if LQuery.Active then
    LQuery.Close;
  LQuery.SQL.Text:= Memo1.Lines.Text;
  LQuery.ExecSQL;
end;

end.
