unit Control.Tanque;

interface

uses
  Model.Tanque, Dao.Tanque, DmConexao, System.SysUtils, System.Classes;

type
  TControlTanque = class
    Tanque: TTanque;
    Constructor Create;
    Destructor Destroy; override;
    function Gravar: boolean;
    function Excluir(pCodigo: string): Boolean;
    function Consulta(pPesquisa: string; pTipo: string = 'C'): TTanque;
    function RetornaLista: TStringList;
    function TanquePermiteBomba(pPesquisa: String): Boolean;
    function RetornaProxCodigo: Integer;
  end;

var
  DaoTanque: TDaoTanque;

implementation

{ TControlTanque }

constructor TControlTanque.Create;
begin
  if not Assigned(Tanque) then
    Tanque := TTanque.Create;

  if not Assigned(DaoTanque) then
    DaoTanque := TDaoTanque.Create;
end;

destructor TControlTanque.Destroy;
begin
  inherited;
  if Assigned(Tanque) then
    FreeAndNil(Tanque);

  if Assigned(DaoTanque) then
    FreeAndNil(DaoTanque);
end;

function TControlTanque.Excluir(pCodigo: string): Boolean;
begin
  Result := DaoTanque.Excluir(pCodigo);
end;

function TControlTanque.Gravar: boolean;
begin
  Result := DaoTanque.Inserir(Tanque);
end;

function TControlTanque.RetornaLista: TStringList;
begin
  Result := DaoTanque.RetornaLista;
end;

function TControlTanque.RetornaProxCodigo: Integer;
begin
  Result := DaoTanque.RetornaProxCodigo;
end;

function TControlTanque.TanquePermiteBomba(pPesquisa: String): Boolean;
begin
  Result := DaoTanque.TanquePermiteBomba(pPesquisa);
end;

function TControlTanque.Consulta(pPesquisa: string; pTipo: string = 'C'): TTanque;
begin
  Result := DaoTanque.Consulta(pPesquisa, pTipo);
end;

end.
