unit Control.Bomba;

interface

uses
  Model.Bomba, Dao.Bomba, DmConexao, System.SysUtils, System.Classes;

type
  TControlBomba = class
    Bomba: TBomba;
    Constructor Create;
    Destructor Destroy; override;
    function Gravar: boolean;
    function Excluir(pCodigo: string): Boolean;
    function Consulta(pPesquisa: string; pTipo: string = 'C'): TBomba;
    function RetornaLista: TStringList;
    function ExcluirBombaTanque(pCodigo: string): Boolean;
    function RetornaProxCodigo: Integer;
  end;

var
  DaoBomba: TDaoBomba;

implementation

{ TControlBomba }

constructor TControlBomba.Create;
begin
  if not Assigned(Bomba) then
    Bomba := TBomba.Create;
  if not Assigned(DaoBomba) then
    DaoBomba := TDaoBomba.Create;
end;

destructor TControlBomba.Destroy;
begin
  inherited;
  if Assigned(Bomba) then
    FreeAndNil(Bomba);
  if Assigned(DaoBomba) then
    FreeAndNil(DaoBomba);
end;

function TControlBomba.Excluir(pCodigo: string): Boolean;
begin
  Result := DaoBomba.Excluir(pCodigo);
end;

function TControlBomba.ExcluirBombaTanque(pCodigo: string): Boolean;
begin
  Result := DaoBomba.ExcluirBombaTanque(pCodigo);
end;

function TControlBomba.Gravar: boolean;
begin
  Result := DaoBomba.Inserir(Bomba);
end;

function TControlBomba.RetornaLista: TStringList;
begin
  Result := DaoBomba.RetornaLista;
end;

function TControlBomba.RetornaProxCodigo: Integer;
begin
  Result := DaoBomba.RetornaProxCodigo;
end;

function TControlBomba.Consulta(pPesquisa, pTipo: string): TBomba;
begin
  Result := DaoBomba.Consulta(pPesquisa, pTipo);
end;

end.
