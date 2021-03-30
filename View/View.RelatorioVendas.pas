unit View.RelatorioVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, DmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, RLConsts;

type
  TfrmRelatorioVendas = class(TForm)
    dsVenda: TDataSource;
    qrVenda: TFDQuery;
    qrVendaDATA: TDateField;
    qrVendaTANQUE: TStringField;
    qrVendaBOMBA: TStringField;
    qrVendaVALOR: TFMTBCDField;
    Relatorio: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLDBText1: TRLDBText;
    RLGroup2: TRLGroup;
    RLBand4: TRLBand;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLBand3: TRLBand;
    RLLabel4: TRLLabel;
    RLDBText5: TRLDBText;
    RLLabel3: TRLLabel;
    RLLabel5: TRLLabel;
    RLDraw1: TRLDraw;
    RLBand5: TRLBand;
    RLLabel6: TRLLabel;
    TotalGeral: TRLLabel;
    RLDraw2: TRLDraw;
    procedure RelatorioBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioVendas: TfrmRelatorioVendas;

implementation

{$R *.dfm}

procedure TfrmRelatorioVendas.RelatorioBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  qrVenda.First;
  TotalGeral.Caption := '0,000';
  while Not qrVenda.Eof do
  begin
    TotalGeral.Caption := FormatFloat('0.000', qrVenda.FieldByName('VALOR').AsFloat + StrToFloat(TotalGeral.Caption));
    qrVenda.Next;
  end;
end;

initialization
  RLConsts.SetVersion(3,71,'B');

end.
